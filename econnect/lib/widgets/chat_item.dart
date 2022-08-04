import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../data/selectors.dart';
import '../globals.dart';
import '../model/chat.dart';
import '../model/message.dart';
import 'package:http/http.dart' as http;

final _textEditingController = TextEditingController();
ScrollController _controller = ScrollController();

class ChatItem extends StatefulWidget {
  final Chat chat;
  const ChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatState();
}

class _ChatState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: ListView(
                  controller: _controller,
                  children: [
                    for (var message in widget.chat.messageList)
                      ChatMessageWidget(message: message),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessageWidget extends StatelessWidget {
  final Message message;
  const ChatMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.senderNumber == 'user';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            constraints:
                BoxConstraints.loose(MediaQuery.of(context).size * 0.8),
            decoration: BoxDecoration(
                color: isMe
                    ? CustomColors.kChatBackgroundColor
                    : CustomColors.kLightColor),
            child: Text(message.text, style: TextStyle(fontSize: 14.0+fontvaluefactor)),
          ),
        ],
      ),
    );
  }
}

class InputItem extends StatefulWidget {
  const InputItem({Key? key, required this.function, required this.chat})
      : super(key: key);
  final Function() function;
  final Chat chat;

  @override
  State<InputItem> createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: Row(children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onTap: () {
                Timer(
                  Duration(milliseconds: 300),
                  () =>
                      _controller.jumpTo(_controller.position.maxScrollExtent),
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                hintText: 'Message',
              ),
              textInputAction: TextInputAction.send,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              onSubmitted: (value) => setState(() {
                if (value.isNotEmpty) {
                  widget.chat.messageList.add(Message(
                      text: value,
                      time: DateTime.now().toString(),
                      senderNumber: 'user'));
                  _textEditingController.clear();
                  widget.function();
                }
              }),
            ),
          ),
          Container(
              width: 50.0,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_textEditingController.text.trim().isNotEmpty) {
                        widget.chat.messageList.add(Message(
                            text: _textEditingController.text.trim(),
                            time: DateTime.now().toString(),
                            senderNumber: 'user'));
                      }
                      _textEditingController.clear();
                    });
                  },
                  child: const Icon(
                    Icons.send,
                    color: CustomColors.kIconColor,
                  )))
        ]));
  }
}

class InputBotItem extends StatefulWidget {
  const InputBotItem({Key? key, required this.function, required this.chat})
      : super(key: key);
  final Function() function;
  final Chat chat;

  @override
  State<InputBotItem> createState() => _InputBotItemState();
}

class _InputBotItemState extends State<InputBotItem> {
  getresponse(String value) {
    if (value.isNotEmpty) {
      return input[value];
    }
  }

  addmessage(String value) {
    widget.chat.messageList.add(Message(
        text: value, time: DateTime.now().toString(), senderNumber: 'user'));
        
    _textEditingController.clear();
    responsemessage(value.toLowerCase());
    widget.function();
  }

  Future<String> responsemessage(value) async {
    String data = '';
    final response = await http.get(Uri.parse('https://secret-earth-37320.herokuapp.com/https://my-personal-chatbot.herokuapp.com/get?msg=$value'));
      var responseData = response.body;
      widget.chat.messageList.add(
        Message(
          text: responseData,
          time: DateTime.now().toString(),
          senderNumber: 'bot',
        ),
      );
      widget.function();
    return data;
  }
    
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: Row(children: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == '/help') {
                addmessage('help');
              }
              if (value == '/settings') {
                addmessage('settings');
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: '/help', child: Text('Help')),
              const PopupMenuItem(value: '/settings', child: Text('Settings')),
            ],
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onTap: () {
                Timer.periodic(
                  Duration(milliseconds: 300),
                  (timer) =>
                      _controller.jumpTo(_controller.position.maxScrollExtent),
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                hintText: 'Message',
              ),
              textInputAction: TextInputAction.send,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              onSubmitted: (value) => setState(() {
                if (value.isNotEmpty) {
                  addmessage(_textEditingController.text.trim());
                }
              }),
            ),
          ),
          Container(
              width: 50.0,
              child: InkWell(
                  onTap: () { //converting it from json to key value pair

                    setState(() {
                      if (_textEditingController.text.trim().isNotEmpty) {
                        widget.chat.messageList.add(Message(
                            text: _textEditingController.text.trim(),
                            time: DateTime.now().toString(),
                            senderNumber: 'user'));
                      }
                      _textEditingController.clear();
                      widget.function();
                    });
                  },
                  child: const Icon(
                    Icons.send,
                    color: CustomColors.kIconColor,
                  )))
        ]));
  }
}

class msg {
  final String msgcontent;

  const msg({
    required this.msgcontent,
  });

  factory msg.fromJson(Map<String, dynamic> json) {
    return msg(
      msgcontent: json['msgcontent'],
    );
  }
}
import 'package:econnect/constants.dart';
import 'package:econnect/data/chats.dart';
import 'package:flutter/material.dart';
import '../globals.dart';
import '../model/chat.dart';
import '../widgets/chat_item.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key, required this.chats}) : super(key: key);

  final List chats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.kPrimaryColor,
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(chats[index].pic),
            ),
            title: Text(
              chats[index].name,
              overflow: TextOverflow.ellipsis,
              style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0+fontvaluefactor),
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(
                chats[index].messageList.last.text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.0+fontvaluefactor),
              ),
            ),
            trailing: Text(
              chats[index].messageList.last.time,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10.0+fontvaluefactor, color: Colors.grey),
            ),
            onTap: () {
              if (chats[index].name == 'Helpbot') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailBotScreen(chat: chats[index]),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailChatScreen(chat: chats[index]),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}

class DetailChatScreen extends StatefulWidget {
  const DetailChatScreen({Key? key, required this.chat}) : super(key: key);
  final Chat chat;

  @override
  State<DetailChatScreen> createState() => _DetailChatScreenState();
}

class _DetailChatScreenState extends State<DetailChatScreen> {
  void refreshParent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        title: Text(widget.chat.name, style: TextStyle(fontSize: 20.0+fontvaluefactor)),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../../assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: ChatItem(chat: widget.chat),
        ),
      ]),
      bottomNavigationBar:
          InputItem(chat: widget.chat, function: refreshParent),
    );
  }
}

class DetailBotScreen extends StatefulWidget {
  const DetailBotScreen({Key? key, required this.chat}) : super(key: key);
  final Chat chat;

  @override
  State<DetailBotScreen> createState() => _DetailBotScreenState();
}

class _DetailBotScreenState extends State<DetailBotScreen> {
  void refreshParent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        title: Text(widget.chat.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../../assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: ChatItem(chat: widget.chat),
        ),
      ]),
      bottomNavigationBar:
          InputBotItem(chat: widget.chat, function: refreshParent),
    );
  }
}

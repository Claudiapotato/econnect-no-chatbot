import 'package:flutter/material.dart';
import '../constants.dart';
import '../globals.dart';

class NewSilverScreen extends StatefulWidget {
  const NewSilverScreen({Key? key}) : super(key: key);

  @override
  State<NewSilverScreen> createState() => _NewSilverScreenState();
}

class _NewSilverScreenState extends State<NewSilverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Silver Mode'),
          backgroundColor: CustomColors.kPrimaryColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                SwitchListTile(
                  title: const Text('Enable Silver Mode',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500)),
                  value: true,
                  onChanged: (bool value) {
                    clicknumber += 1;
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/newloadscreen', (_) => false);
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Silver Mode is an experimental feature that allows you to use a more simplified version of the app.',
                  style: TextStyle(fontSize: 13.0),
                ),
              ]),
        ));
  }
}

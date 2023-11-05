import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/messages.dart';

class Profile extends StatelessWidget {
  final String name;
  final String lastmsg;
  final String profileimag;
  final int id;
  const Profile(
      {super.key,
      required this.name,
      required this.lastmsg,
      required this.profileimag,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 90,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 25),
              ),
              Text(lastmsg,
                  style: const TextStyle(fontSize: 20, color: Colors.black38))
            ],
          )
        ],
      ),
    );
  }
}

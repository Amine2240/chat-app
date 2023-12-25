import 'package:flutter/material.dart';

class PromptMsg extends StatefulWidget {
  final TextEditingController controller;
  final String message, id;
  // final CallbackAction deletemessage;
   final void Function(String messageId) deletemessage;

  const PromptMsg(
      {super.key,
      required this.controller,
      required this.message,
      required this.id,
      required this.deletemessage});

  @override
  State<PromptMsg> createState() => _PromptMsgState();
}

class _PromptMsgState extends State<PromptMsg> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        margin: const EdgeInsets.symmetric(vertical: 5),
        // padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:
                const LinearGradient(begin: Alignment.bottomLeft, colors: [
              Color.fromARGB(255, 10, 106, 184),
              Color.fromARGB(255, 54, 197, 244),
            ])),
        child: Column(
          children: [
            Text(
              '${widget.message}\n',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    // setState(() {
                    //   messages.remove(item);
                    // });
                    widget.deletemessage(widget.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // deletemessage(item['_id']);
                    setState(() {
                    widget.controller.text = widget.message;
                    });
                    // setState(() {
                    //   isupdate = !isupdate;
                    // });
                    // setState(() {
                    //   tmpid = item['_id'];
                    // });
                  },
                  icon: const Icon(
                    Icons.mode,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ));
    ;
  }
}

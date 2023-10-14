import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class MessagesPage extends StatefulWidget {
  MessagesPage({super.key, required this.profilename});
  String profilename = '';

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  String inputvalue = 'amine';
  List messages = [];
  void postmessage() async {
    // BaseOptions options = BaseOptions(
    //   connectTimeout: 5 * 6000,
    //   receiveTimeout: 5*6000,
    // );
    Dio dio = Dio();
    // dio.options.connectTimeout = Duration(seconds: 10);
    try {
      Response response = await dio
          .post('http://127.0.0.1:5000/message', data: {'msg': inputvalue});
      if (response.statusCode == 200) {
        print('response succefull');
        setState(() {
          messages.add(inputvalue);
        });
        setState(() {
          inputvalue = '';
        });
      } else {
        // Handle other response status codes or errors if necessary
        print('response failed');
      }
      print('responsse.data :  ${response.data}');
    } catch (e) {
      print('error in posting from front : $e');
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset:  false,
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.profilename),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        // actions: [
        //   Icon(Icons.rounded_corner)
        // ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 530),
              child: Container(
                // height: messages.length == 0 ? 530 : double.,
                padding: const EdgeInsets.only(bottom: 20, right: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...messages.map((item) {
                      return Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          // padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 0, 80, 145),
                                    Color.fromARGB(255, 54, 197, 244),
                                  ])),
                          child: Column(
                            children: [
                              Text(
                                '$item\n',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    messages.remove(item);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ));
                    }).toList(),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 350,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 64, 175),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          inputvalue = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(
                            color: Color.fromARGB(255, 164, 164, 164)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (inputvalue != '') {
                        postmessage();
                        print(inputvalue);
                      }
                      controller.clear();
                    },
                    icon: const Icon(Icons.send_rounded),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   color: Colors.blue,
      //   height: 100,
      //   child:
      // ),
    );
  }
}

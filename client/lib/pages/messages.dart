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
  // String inputvalue = 'amine';
  List messages = [];
  bool isupdate = false;
  String tmpid = '';
  void postmessage() async {
    // BaseOptions options = BaseOptions(
    //   connectTimeout: 5 * 6000,
    //   receiveTimeout: 5*6000,
    // );
    Dio dio = Dio();
    try {
      var response = await dio.post(
        'http://localhost:5000/message',
        data: {'msg': controller.text},
      );
      print('response succefull');
      getmessage();
      // setState(() {
      //   inputvalue = '';
      // });
      print('responsse.data :  ${response.data}');
      controller.clear();
    } catch (e) {
      print('error in posting from front : $e');
      // print('input value : $inputvalue');
    }
  }

  void getmessage() async {
    Dio dio = Dio();
    try {
      var response = await dio.get('http://localhost:5000/getmessage');

      // messages = [...response.data['result']];
      setState(() {
        messages = List.of(response.data['result']);
      });

      print('messages list : $messages');
    } catch (e) {
      print('error while getting : $e');
    }
  }

  void deletemessage(id) async {
    Dio dio = Dio();
    try {
      var response =
          await dio.delete('http://localhost:5000/deletemessage/$id');
      print('delete response : ${response.data}');
      getmessage();
    } catch (e) {
      print('error in deleting : $e');
    }
  }

  void updatemessage(id) async {
    Dio dio = Dio();
    try {
      var response = dio.put('http://localhost:5000/updatemessage/$id',
          data: {'msg': controller.text});
      getmessage();
      setState(() {
        isupdate = !isupdate;
      });
    } catch (e) {
      print('error in updating $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmessage();
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
                                '${item['msg']}\n',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // setState(() {
                                      //   messages.remove(item);
                                      // });
                                      deletemessage(item['_id']);
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
                                        controller.text = item['msg'];
                                      });
                                      setState(() {
                                        isupdate = !isupdate;
                                      });
                                      setState(() {
                                        tmpid = item['_id'];
                                      });
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
                    }),
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
                        // setState(() {
                        //   inputvalue = value;
                        // });
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
                      // ignore: unrelated_type_equality_checks
                      if (controller.text != '' && isupdate == false) {
                        postmessage();
                      }
                      if (controller.text != '' && isupdate == true) {
                        updatemessage(tmpid);
                      }
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

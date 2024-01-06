// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat_app/widgets/promptmsg.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

// ignore: must_be_immutable
class MessagesPage extends StatefulWidget {
  MessagesPage({super.key, required this.profilename});
  String profilename = '';

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // String inputvalue = 'amine';

  bool isupdate = false;
  String tmpid = '';
  String gptresponse = '';
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
      // print('response succefull');
      getmessage();
      // setState(() {
      //   inputvalue = '';
      // });
      // print('responsse.data :  ${response.data}');
      controller.clear();
    } catch (e) {
      print('error in posting from front : $e');
      // print('input value : $inputvalue');
    }
  }

  void getmessage() async {
    Dio dio = Dio();
    try {
      // var response = await dio.get('http://localhost:5000/getmessage');
      // // print('response ${response.data}');
      // // messages = [...response.data['result']];
      // setState(() {
      //   messages = List.of(response.data['result']);
      // });

      // print('messages list : $messages');
    } catch (e) {
      print('error while getting : $e');
    }
  }

  void deletemessage(id) async {
    Dio dio = Dio();
    try {
      var response =
          await dio.delete('http://localhost:5000/deletemessage/$id');
      // print('delete response : ${response.data}');
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

  void postgptprompt(ChatMessage m) async {
    Dio dio = Dio();
    try {
      
      var response = await dio.post('http://192.168.1.42:5000/chatgpt/api',
          data: {'promptresult': m.text});
//var response = await dio.post('http://192.168.1.41:5000/chatgpt/api',{data : })
      // print('posted scuucucufully');
      print('gpt response from front : ${response.data}');
      print("objeckljdsqmlfdmlkdsflmkt");
      // setState(() {

      // });

      setState(() {
        gptresponse = response.data['gptanswer'];
        messages.insert(index,
            ChatMessage(user: _user, createdAt: DateTime.now(), text: m.text));
        messages.insert(
            index++,
            ChatMessage(
                user: gptuser, createdAt: DateTime.now(), text: gptresponse));
        index++;
      });
    } catch (e) {
      print('error in posting gpt prompt $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmessage();
  }

  TextEditingController controller = TextEditingController();

  ChatUser _user = ChatUser(id: '1', firstName: 'amine', lastName: 'kadoum');
  ChatUser gptuser = ChatUser(id: "2", firstName: "gpt", lastName: "model");
  List<ChatMessage> messages = [
    // ChatMessage(
    //     text: "i am gpt model",
    //     user: ChatUser(id: "3", firstName: "gpt", lastName: "model"),
    //     createdAt: DateTime.now()),
    // ChatMessage(
    //     text: "heloow",
    //     user: ChatUser(id: "4", firstName: "gpt", lastName: "model"),
    //     createdAt: DateTime.now()),
    // ChatMessage(
    //     user: ChatUser(id: '1', firstName: 'amiofoffne', lastName: 'kadoum'),
    //     createdAt: DateTime.now(),
    //     text: "heyfmdsklqjthere"),
    // ChatMessage(
    //     text: "heloow",
    //     user: ChatUser(id: "4", firstName: "gpt", lastName: "model"),
    //     createdAt: DateTime.now()),
  ];
  int index = 0;
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
        body: DashChat(
          messageOptions: MessageOptions(
            textColor: Colors.black,
            currentUserContainerColor: Colors.purple,
            showOtherUsersAvatar: true,
            showCurrentUserAvatar: true,
          ),
          currentUser: _user,
          // typingUsers: [
          //   ChatUser(id: "3", firstName: "termai", lastName: "chaima")
          // ],
          onSend: (ChatMessage m) {
            
            postgptprompt(m);
            

            // messages.reversed.toList();
          },
          messages: messages,
        )
        // bottomNavigationBar: BottomAppBar(
        //   elevation: 0,
        //   color: Colors.blue,
        //   height: 100,
        //   child:
        // ),
        );
  }
}

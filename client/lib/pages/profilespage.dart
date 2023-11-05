import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/messages.dart';
import 'package:flutter_chat_app/widgets/categories.dart';
import 'package:flutter_chat_app/widgets/profil.dart';

class profile {
  final String name;
  final String lastmsg;
  final String profileimg;
  final int id;
  profile({
    required this.id,
    required this.name,
    required this.lastmsg,
    required this.profileimg,
  });
}

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  List allprofileslist = [
    profile(
        id: 0,
        name: 'amine kadoum',
        lastmsg: 'see you soon',
        profileimg: 'profileimg'),
    profile(
        id: 1,
        name: 'amine dermouni',
        lastmsg: 'always here to help',
        profileimg: 'profileimg'),
    profile(
        id: 2,
        name: 'manil rabia',
        lastmsg: 'give me my bag',
        profileimg: 'profileimg'),
    profile(
        id: 3,
        name: 'yasmine mekky',
        lastmsg: 'seriously ?',
        profileimg: 'profileimg'),
    profile(
        id: 3,
        name: 'soulyman djihad',
        lastmsg: 'i will be back in a minute',
        profileimg: 'profileimg'),
    profile(
        id: 3,
        name: 'mohamed mekky',
        lastmsg: 'no worry i got it',
        profileimg: 'profileimg'),
  ];
  String inputvalue = '';
  // TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 200,
        automaticallyImplyLeading: false,
        title: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    'Discussions',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputvalue = value;
                    });
                  },
                  // controller: controller,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 11, 10, 10)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 78, 78, 78)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 163, 27, 27),
                    ),
                  ),
                ),
              ),
              const Categories(),
            ],
          ),
        ),
        // title: Center(child: Text('Messages')),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60), topLeft: Radius.circular(60))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (allprofileslist.length != 0)
                ...allprofileslist
                    .where((item) => item.name
                        .toLowerCase()
                        .contains(inputvalue.toLowerCase()))
                    .map((item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagesPage(
                              profilename: item.name,
                            ),
                          ));
                    },
                    child: Profile(
                        name: item.name,
                        lastmsg: item.lastmsg,
                        profileimag: item.profileimg,
                        id: item.id),
                  );
                })
              else
                Center(child: Text('no result'))
            ],
          ),
        ),
      ),
    );
  }
}

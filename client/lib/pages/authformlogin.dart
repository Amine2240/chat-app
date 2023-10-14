import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/profilespage.dart';

class AuthFormLogin extends StatefulWidget {
  const AuthFormLogin({super.key});

  @override
  State<AuthFormLogin> createState() => _AuthFormLoginState();
}

class _AuthFormLoginState extends State<AuthFormLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
              child: SizedBox(
            width: 350,
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter user name please';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'user name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                ElevatedButton( 
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProfilesPage(),
                      ));
                    },
                    child: const Text('Log in'))
              ],
            ),
          )),
        ));
  }
}

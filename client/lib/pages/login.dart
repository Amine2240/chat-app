import 'package:flutter/material.dart';
import 'package:flutter_chat_app/pages/authformlogin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
            child: Text(
          'Chat App',
          style: TextStyle(),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthFormLogin()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.green),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    child: const Text('Log in'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.orange),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    child: const Text('Sign in'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

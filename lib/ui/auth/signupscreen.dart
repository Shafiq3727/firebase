import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutter/ui/auth/loginScreen.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:firebaseflutter/widgets/roundwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(hintText: "email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordcontroller,
              decoration: InputDecoration(hintText: "password"),
            ),
            RoundButton(
              title: "Sign up",
              ontap: () {
                _auth
                    .createUserWithEmailAndPassword(
                        email: emailcontroller.text.toString(),
                        password: passwordcontroller.text.toString())
                    .then((value) {
                }).onError((error, stackTrace) {
                  Utils().tostMeaasge(error.toString());
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text("Already have an account "),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("Login")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

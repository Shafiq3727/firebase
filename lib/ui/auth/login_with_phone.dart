import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ui/auth/verife_code.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:firebaseflutter/widgets/roundwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phonenumbercontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with phone Number")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: phonenumbercontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "+123 456 789"),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                  title: "Login",
                  ontap: () {
                    auth.verifyPhoneNumber(
                      phoneNumber: phonenumbercontroller.text,
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        Utils().tostMeaasge(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VerifyWithCode(verificationId: verificationId),
                            ));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().tostMeaasge(e.toString());
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

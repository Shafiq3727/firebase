import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ui/post/post_screen.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:firebaseflutter/widgets/roundwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class VerifyWithCode extends StatefulWidget {
  final String verificationId;
  const VerifyWithCode({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyWithCode> createState() => _VerifyWithCodeState();
}

class _VerifyWithCodeState extends State<VerifyWithCode> {
  final verifynumbercontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("verify")),
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: verifynumbercontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "6 digit code"),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundButton(
                  title: "verify",
                  ontap: () async{
                    final credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: verifynumbercontroller.text.toString());

                        try{
                          await auth.signInWithCredential(credential);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
                        }catch(e){
                          Utils().tostMeaasge(e.toString());
                        }
                  }))
        ],
      ),
    );
  }
}

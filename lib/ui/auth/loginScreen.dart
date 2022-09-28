import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseflutter/ui/auth/login_with_phone.dart';
import 'package:firebaseflutter/ui/auth/signupscreen.dart';
import 'package:firebaseflutter/ui/post/post_screen.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:firebaseflutter/widgets/roundwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  void logIn() {
    _auth
        .signInWithEmailAndPassword(
            email: emailcontroller.text.toString(),
            password: passwordcontroller.text.toString())
        .then((value) {
      Utils().tostMeaasge(value.user!.email.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ));
    }).onError((error, stackTrace) {
      Utils().tostMeaasge(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  title: "Login",
                  ontap: () {
                    logIn();
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text("dont have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("Sign Up")),
                    
                  ],
                ),
                SizedBox(
                      height: 30,
                    ),
                   InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginWithPhoneNumber(),
                            ));
                      },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black)),
                          child: Center(child: Text("Login with phone number"))),
                    )
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}

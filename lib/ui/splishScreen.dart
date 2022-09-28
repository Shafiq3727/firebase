import 'package:firebaseflutter/FireBase_servies/Splish_servise.dart';
import 'package:flutter/material.dart';

class SplishScreen extends StatefulWidget {
  const SplishScreen({Key? key}) : super(key: key);

  @override
  State<SplishScreen> createState() => _SplishScreenState();
}

class _SplishScreenState extends State<SplishScreen> {
  SplishServise servise=SplishServise();

  @override
  void initState() {
    // TODO: implement initState
    
    servise.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: Center(
    child: Text("My Firebase Project",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w500 ),),
  ),
);
  }
}
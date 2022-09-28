import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ui/auth/loginScreen.dart';
import 'package:firebaseflutter/ui/post/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplishServise{
  void isLogin(BuildContext context){

final _auth=FirebaseAuth.instance;
final _user=_auth.currentUser;
if(_user!=null){

Timer(Duration(seconds: 3), ()=>Navigator.push(
      context, MaterialPageRoute(builder: 
      (context)=>PostScreen())));

}else

    {Timer(Duration(seconds: 3), ()=>Navigator.push(
      context, MaterialPageRoute(builder: 
      (context)=>Login())));}
  }
}
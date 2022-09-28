import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:firebaseflutter/widgets/roundwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final postcontroller = TextEditingController();
  final databaeref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 4,
                controller: postcontroller,
                decoration: InputDecoration(
                    hintText: 'whats in your mind',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: "add",
                  ontap: () {
                    Navigator.pop(context);
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    databaeref
                        .child(id)
                        .set(
                            {'title': postcontroller.text.toString(), 'id': id})
                        .then((value) { Utils().tostMeaasge("added");})
                        .onError((error, stackTrace) {
                            Utils().tostMeaasge(error.toString());});
                  })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseflutter/ui/auth/loginScreen.dart';
import 'package:firebaseflutter/ui/post/add_post.dart';
import 'package:firebaseflutter/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  final searchController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Post Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().tostMeaasge(error.toString());
                });
              },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPostScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "search", border: OutlineInputBorder()),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          /*  Expanded(child: StreamBuilder(
            stream: ref.onValue,
            builder: ((context,AsyncSnapshot<DatabaseEvent> snapshot) {
return ListView.builder(
  itemCount: snapshot.data!.snapshot.children.length,
  itemBuilder: (context, index) {
  if(!snapshot.hasData){
    return CircularProgressIndicator();
  }else{
    Map<dynamic, dynamic> map=snapshot.data!.snapshot.value as dynamic;
    List
    <dynamic> list=[];
    list.clear();
    list=map.values.toList();
  

  return ListTile(title: Text(list[index]['title']
  ),
  subtitle: Text(list[index]['id']
  ),
  );}
},);            
          }))),
       */
          Expanded(
              child: FirebaseAnimatedList(
            query: ref,
            defaultChild: Text("loading"),
            itemBuilder: (context, snapshot, animation, index) {
              final title = snapshot.child('title').value.toString();

              if (searchController.text.isEmpty) {
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  title: Text("edit"),
                                  leading: Icon(
                                    Icons.edit,
                                  ),
                                  onTap: (() {
                                    Navigator.pop(context);
                                    showMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  }),
                                )),
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                    title: Text("delete"),
                                    leading: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onTap: (() {
                                      Navigator.pop(context);
                                      ref.child(snapshot.child('id').value.toString()).remove();
                                    }))),
                          ]),
                );
              } else if (title.toLowerCase().contains(
                  searchController.text.toLowerCase().toLowerCase())) {
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                );
              } else {
                return Container();
              }
            },
          ))
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("cancel")),
            TextButton(
                onPressed: () {
                            Navigator.pop(context);

                  ref
                      .child(id)
                      .update({'title': editController.text.toString()})
                      .then((value) => {Utils().tostMeaasge("updated")})
                      .onError((error, stackTrace) =>
                          {
                            Utils().tostMeaasge(error.toString()),
                          });
                },
                child: Text("update")),
          ],
        );
      },
    );
  }
}

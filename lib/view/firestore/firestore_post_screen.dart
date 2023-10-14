import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/firestore/Firestore_add_post.dart';
import 'package:firebase_demo/view/post/add_post.dart';
import 'package:firebase_demo/view/post/update_post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/view/auth/login_screen.dart';
import 'package:get/get.dart';

class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({super.key});

  @override
  State<FirestorePostScreen> createState() => _FirestorePostScreenState();
}

class _FirestorePostScreenState extends State<FirestorePostScreen> {
  final _serchController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Post Screen'),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Clear All')),
          IconButton(
              onPressed: () {
                final _auth = FirebaseAuth.instance;
                _auth.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    )));
              },
              icon: Icon(Icons.login_outlined)),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomeTextField(
            borderColor: Colors.blueGrey,
            controller: _serchController,
            errorText: '',
            hintText: 'Search',
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Expanded(
            child: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (_serchController.text.trim().isEmpty) {
                    return ListTile(
                      onTap: () {},
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                      // trailing: ,
                    );
                  } else if (snapshot.data!.docs[index]['name']
                      .toLowerCase()
                      .toString()
                      .toLowerCase()
                      .contains(_serchController.text
                          .trim()
                          .toLowerCase()
                          .toString())) {
                    return ListTile(
                      onTap: () {},
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                      // trailing: ,
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return Utils.toastMessage('Erro');
            }
          },
          stream: firestore.snapshots(),
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => FirestoreAddPost(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

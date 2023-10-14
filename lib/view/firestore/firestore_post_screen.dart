import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view/firestore/Firestore_add_post.dart';
import 'package:firebase_demo/view/firestore/details_pagae.dart';
import 'package:firebase_demo/view/home_screen.dart';
import 'package:firebase_demo/view/post/add_post.dart';
import 'package:firebase_demo/view/post/update_post.dart';
import 'package:firebase_demo/view/firestore/upload_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final firebaseStorage = FirebaseStorage.instance;
  final _nameController = TextEditingController();
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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          snapshot.data!.docs[index]['url'].toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Get.to(DetailsScreen(
                            url: snapshot.data!.docs[index]['url'].toString(),
                            name:
                                snapshot.data!.docs[index]['name'].toString()));
                      },
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              final _updateController = TextEditingController(
                                  text: snapshot.data!.docs[index]['name']
                                      .toString());
                              Get.back();
                              showDialog(
                                  builder: (context) => AlertDialog(
                                          semanticLabel: 'UPDATE',
                                          actions: [
                                            TextField(
                                              controller: _updateController,
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      firestore
                                                          .doc(snapshot.data!
                                                              .docs[index]['id']
                                                              .toString())
                                                          .update({
                                                        'name':
                                                            _updateController
                                                                .text
                                                                .trim()
                                                                .toString()
                                                      }).then((value) {
                                                        Utils.toastMessage(
                                                            'Updated');
                                                        Get.back();
                                                      }).onError((error,
                                                                  stackTrace) =>
                                                              Utils.toastMessage(
                                                                  error
                                                                      .toString()));
                                                    },
                                                    child: Text('Update')),
                                              ],
                                            ),

                                            // applicationName: 'UPDATE',
                                          ]),
                                  context: context);
                            },
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          )),
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              firebaseStorage
                                  .ref('/foldername')
                                  .child(snapshot.data!.docs[index]['id']
                                      .toString())
                                  .delete()
                                  .then((value) => firestore
                                          .doc(snapshot.data!.docs[index]['id']
                                              .toString())
                                          .delete()
                                          .then((value) {
                                        Utils.toastMessage('Delete');
                                      }).onError((error, stackTrace) =>
                                              Utils.toastMessage(
                                                  error.toString())));
                              Get.back();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('delete'),
                          )),
                        ],
                      ),
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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Image.network(
                          snapshot.data!.docs[index]['url'].toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Get.to(DetailsScreen(
                            url: snapshot.data!.docs[index]['url'].toString(),
                            name:
                                snapshot.data!.docs[index]['name'].toString()));
                      },
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              final _updateController = TextEditingController(
                                  text: snapshot.data!.docs[index]['name']
                                      .toString());
                              Get.back();
                              showDialog(
                                  builder: (context) => AlertDialog(
                                          semanticLabel: 'UPDATE',
                                          actions: [
                                            TextField(
                                              controller: _updateController,
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      firestore
                                                          .doc(snapshot.data!
                                                              .docs[index]['id']
                                                              .toString())
                                                          .update({
                                                        'name':
                                                            _updateController
                                                                .text
                                                                .trim()
                                                                .toString()
                                                      }).then((value) {
                                                        Utils.toastMessage(
                                                            'Updated');
                                                        Get.back();
                                                      }).onError((error,
                                                                  stackTrace) =>
                                                              Utils.toastMessage(
                                                                  error
                                                                      .toString()));
                                                    },
                                                    child: Text('Update')),
                                              ],
                                            ),

                                            // applicationName: 'UPDATE',
                                          ]),
                                  context: context);
                            },
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          )),
                          PopupMenuItem(
                              child: ListTile(
                            onTap: () {
                              firebaseStorage
                                  .ref('/foldername')
                                  .child(snapshot.data!.docs[index]['id']
                                      .toString())
                                  .delete()
                                  .then((value) => firestore
                                          .doc(snapshot.data!.docs[index]['id']
                                              .toString())
                                          .delete()
                                          .then((value) {
                                        Utils.toastMessage('Delete');
                                      }).onError((error, stackTrace) =>
                                              Utils.toastMessage(
                                                  error.toString())));
                              Get.back();
                            },
                            leading: Icon(Icons.delete),
                            title: Text('delete'),
                          )),
                        ],
                      ),
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
            builder: (context) =>
                UploadImageScreen(nameController: _nameController),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

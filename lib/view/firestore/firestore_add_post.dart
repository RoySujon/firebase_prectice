import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_demo/data/utils/utils.dart';

class FirestoreAddPost extends StatefulWidget {
  const FirestoreAddPost({super.key});
  @override
  State<FirestoreAddPost> createState() => _FirestoreAddPostState();
}

class _FirestoreAddPostState extends State<FirestoreAddPost> {
  final _noteController = TextEditingController();
  final _phoneController = TextEditingController();
  final dbReference = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomeTextField(
              borderColor: Colors.blueGrey,
              controller: _noteController,
              errorText: 'errorText',
              hintText: 'Enter your name here',
              labelText: 'Name',
            ),
            SizedBox(
              height: 34,
            ),
            RoundButton(
              color: Colors.green,
              text: 'Submit',
              onTap: () {
                var id = DateTime.now().millisecondsSinceEpoch.toString();
                if (_noteController.text.trim().isEmpty) {
                  Utils.toastMessage('Enter Something');
                } else {
                  dbReference.doc(id.toString()).set({
                    'id': id,
                    'name': _noteController.text.trim().toString(),
                  }).then((value) {
                    Utils.toastMessage('Sucess');
                    Get.back();
                  }).onError((error, stackTrace) {
                    if (kDebugMode) {
                      print(error);
                    }
                    return Utils.toastMessage(error.toString());
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

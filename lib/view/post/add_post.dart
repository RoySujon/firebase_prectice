import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../data/utils/utils.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _noteController = TextEditingController();
  final _phoneController = TextEditingController();
  final dbReference = FirebaseDatabase.instance.ref('DataTable');

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
            CustomeTextField(
              borderColor: Colors.blueGrey,
              controller: _phoneController,
              errorText: 'errorText',
              hintText: 'Enter your phone no here',
              labelText: 'Phone',
            ),
            SizedBox(
              height: 34,
            ),
            RoundButton(
              color: Colors.green,
              text: 'Submit',
              onTap: () {
                var id = DateTime.now().millisecondsSinceEpoch.toString();
                if (_noteController.text.trim().isEmpty ||
                    _phoneController.text.trim().isEmpty ||
                    _phoneController.text.trim().length != 11) {
                  Utils.toastMessage('Enter Something');
                } else {
                  dbReference.child(id.toString()).set({
                    'id': id,
                    'name': _noteController.text.trim().toString(),
                    'phone': '+88' + _phoneController.text.trim().toString()
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

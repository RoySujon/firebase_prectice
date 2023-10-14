import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:get/route_manager.dart';

class FirestoreUpdatePost extends StatefulWidget {
  const FirestoreUpdatePost({super.key, required this.text, required this.id});
  final String text;
  final String id;
  @override
  State<FirestoreUpdatePost> createState() => _FirestoreUpdatePostState();
}

class _FirestoreUpdatePostState extends State<FirestoreUpdatePost> {
  final dbReference = FirebaseDatabase.instance.ref('DataTable');
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _noteController.text = widget.text.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomeTextField(
              controller: _noteController,
              maxLine: 5,
              fillColor: Colors.grey,
              errorText: 'errorText',
              hintText: 'Enter the note here...',
            ),
            SizedBox(
              height: 34,
            ),
            RoundButton(
              color: Colors.green,
              text: 'Submit',
              onTap: () {
                dbReference
                    .child(widget.id)
                    .update({
                      'name': _noteController.text.trim().toString(),
                    })
                    .then((value) => Get.back())
                    .onError((error, stackTrace) {
                      if (kDebugMode) {
                        print(error);
                      }
                      return Utils.toastMessage(error.toString());
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

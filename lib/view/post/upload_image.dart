import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/Utils/utils.dart';
import 'package:firebase_demo/data/utils/utils.dart';
import 'package:firebase_demo/view_model/services/image_picker_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});
  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  final imageService = Get.put(PickImagerService());
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final ref = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    print('object');
    final _controller =
        Provider.of<PickImagerServiceProvider>(context, listen: false);

    final _nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Upload Image'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomeTextField(
              controller: _nameController,
              hintText: 'Enter your name',
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
              errorText: 'errorText',
              borderColor: Colors.blueGrey,
            ),
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Consumer<PickImagerServiceProvider>(
                  builder: (context, value, child) => InkWell(
                    onTap: () => value.gallaryImage(),
                    child: value.imagePath.isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.red, width: 6)),
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.red,
                              size: 100,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: FileImage(
                                    File(value.imagePath.toString()).absolute),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 34),
            RoundButton(
              text: 'Upload Image',
              onTap: () async {
                if (_nameController.text.trim().isNotEmpty) {
                  var id = DateTime.now().millisecondsSinceEpoch.toString();
                  print(id);
                  Reference _referance =
                      FirebaseStorage.instance.ref('/foldername/' + id);
                  UploadTask _uploadTask =
                      _referance.putFile(File(_controller.imagePath).absolute);

                  Future.value(_uploadTask).then((value) async {
                    var newUrl = await _referance.getDownloadURL();
                    Utils.toastMessage(newUrl);
                    print(newUrl);
                    ref
                        .doc(id)
                        .set({
                          'url': newUrl.toString(),
                          'id': id.toString(),
                          'name': _nameController.text.trim().toString()
                        })
                        .then((value) => Utils.toastMessage('Sucess'))
                        .onError((error, stackTrace) =>
                            Utils.toastMessage(error.toString()));
                    Get.back();
                  }).onError((error, stackTrace) {
                    Utils.toastMessage(error.toString());
                  });
                } else {
                  Utils.toastMessage('Enter your name');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

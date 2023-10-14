import 'package:firebase_demo/Utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickImagerService extends GetxController {
  RxString imagePath = ''.obs;
  final _picker = ImagePicker();

  Future gallaryImage() async {
    final _pickImage = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickImage != null) {
      imagePath.value = _pickImage.path;
    } else {
      Utils.toastMessage('Not Select');
    }
  }
}

class PickImagerServiceProvider extends ChangeNotifier {
  String _imagePath = '';
  String get imagePath => _imagePath;
  final _picker = ImagePicker();

  Future gallaryImage() async {
    final _pickImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 500,
        maxWidth: 500);
    if (_pickImage != null) {
      _imagePath = _pickImage.path;
      notifyListeners();
    } else {
      Utils.toastMessage('Not Select');
    }
  }
}

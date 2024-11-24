import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier {
  //firebase storage

  final firebaseStorage = FirebaseStorage.instance;
  /*
  images are stores in firebase as download URL's

  */
  List<String> _imageUrls = [];
  //loading
  bool _isLoading = false;
  //uploading
  bool _isUploading = false;
  /*
    getters
  */

  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  /*
  READ
  
   */

  Future<void> fetchImages() async {
    //start loading...
    _isLoading = true;

    //get the list under :uploaded_images/
    final ListResult result =
        await firebaseStorage.ref('uploaded_images/').listAll();
    //get the downloaded urls fro each image
    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    //update urls
    _imageUrls = urls;
    //loading finished
    _isLoading = false;

    //update ui
    notifyListeners();
  }

  /*
    DELETE IMAGE


   */
  Future<void> deleteImages(String imageUrl) async {
    try {
      //remove form local list
      _imageUrls.remove(imageUrl);

      //get path name and delete
      final String path = extractPathFromUrl(imageUrl);
      await firebaseStorage.ref(path).delete();
    } catch (e) {
      //handle error
      print("Error deleting image $e");
    }
    //update ui
    notifyListeners();
  }

  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);
    //extracting part of url we need
    String encodedPath = uri.pathSegments.last;

    //url decoding the path
    return Uri.decodeComponent(encodedPath);
  }

  /*
   UPLOAD IMAGE
  */

  Future<void> uploadImage() async {
    //start upload
    _isUploading = true;
    notifyListeners();
    //pick an image
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    File file = File(image.path);
    try {
      //define the path in storage
      String filePath = 'uploaded_images/${DateTime.now()}.png';

      //upload file to firebase storage
      await firebaseStorage.ref(filePath).putFile(file);

      //after uploading.. fetch download url
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      //update the image url list and ui
      _imageUrls.add(downloadUrl);
      notifyListeners();
    } catch (e) {
      print("Error uploading..$e");
    } finally {
      _isLoading = true;
      notifyListeners();
    }
  }
}

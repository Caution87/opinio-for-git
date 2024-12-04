import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:opinio/pages/home_page.dart';
class PostDebatePage extends StatefulWidget {
  @override
    _PostDebatePageState createState() => _PostDebatePageState();
}

class _PostDebatePageState extends State<PostDebatePage> {
    final TextEditingController debateContentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? _selectedImage;
  bool _isUploading = false;

  // Image Picker
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    } else {
      _selectedImage = null;
    }
  }

  // Upload image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;
  setState(() {
      _isUploading = true;
    });

    try {
      final String filePath =
          'debate_images/${DateTime.now().millisecondsSinceEpoch}.png';
      final Reference ref = FirebaseStorage.instance.ref().child(filePath);

      // Upload image
      await ref.putFile(_selectedImage!);

      // Get download URL
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Post Debate
  void postDebate(String imageUrl) {
    if (debateContentController.text.isNotEmpty) {
        // Store in Firestore
      FirebaseFirestore.instance.collection("debates").add({
        'UserEmail': currentUser.email,
        'title': debateContentController.text,
        'timestamp': Timestamp.now(),
        'likes': [],
        'forOpinions': [],
        'againstOpinions': [],
         'likeCount': 0,
        'imageUrl': imageUrl, // Include imageUrl
      });
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    debateContentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Debate"),
        centerTitle: true,
         ),
      body: Column(
        children: [
          Container(
               padding: const EdgeInsets.all(8.0),
            child: Text("Posting as: ${currentUser.email!}"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: debateContentController,
                  decoration: InputDecoration(
                    hintText: "Enter your debate topic",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: _selectedImage == null
                        ? Icon(Icons.add_a_photo, color: Colors.grey[700])
                        : Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.red)),
                  onPressed: _isUploading
                      ? null
                      : () async {
                          // Upload the image and get its URL
                          String? imageUrl = await _uploadImage();

                          // If the image is uploaded successfully, post the debate
                          if (imageUrl != null) {
                            postDebate(imageUrl);
                          } else {
                            // Handle the case where image upload fails
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to upload image.')),
                            );
                          }
                        },
                  child: _isUploading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      : Text("Post"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
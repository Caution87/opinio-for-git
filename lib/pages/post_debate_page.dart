import 'package:flutter/material.dart';
import 'package:opinio/components/my_text_field.dart';

class PostDebatePage extends StatefulWidget {
  const PostDebatePage({super.key});

  @override
  State<PostDebatePage> createState() => _PostDebatePageState();
}

class _PostDebatePageState extends State<PostDebatePage> {
  //textController
  final debateContentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Debate"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyTextField(
            controller: debateContentController,
            hintText: "",
            obscureText: false),
      ),
    );
  }
}

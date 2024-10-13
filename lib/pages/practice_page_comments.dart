import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/services/firestore.dart';

class PracticePageComments extends StatefulWidget {
  final String debateId;
  const PracticePageComments({super.key, required this.debateId});

  @override
  State<PracticePageComments> createState() => _PracticePageCommentsState();
}

class _PracticePageCommentsState extends State<PracticePageComments> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Practice Page Comments"),
      ),
      body: StreamBuilder(
        stream: firestoreService
            .getCommentsStream(widget.debateId), // Use widget.debateId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No comments yet."));
          }

          final comments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              String content = comment['content'];
              Timestamp timestamp = comment['timestamp'];

              return ListTile(
                title: Text(content),
                subtitle:
                    Text(DateFormat('MMM dd, yyyy').format(timestamp.toDate())),
              );
            },
          );
        },
      ),
    );
  }
}

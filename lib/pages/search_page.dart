import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:opinio/pages/debate_page.dart'; // Don't forget this import!

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        centerTitle: true,
        //backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      searchQuery = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchDebates(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No debates found.'));
                }

                final debates = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: debates.length,
                  itemBuilder: (context, index) {
                    var debate = debates[index];
                    Map<String, dynamic> data =
                        debate.data() as Map<String, dynamic>;

                    String title = data['title'] ?? '';
                    Timestamp timestamp = data['timestamp'];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DebatePage(
                              debateId: debate.id,
                              imageUrl: debate['imageUrl'] ?? '',
                              title: title,
                              forOpinions:
                                  List<String>.from(data['forOpinions'] ?? []),
                              againstOpinions: List<String>.from(
                                  data['againstOpinions'] ?? []),
                            ),
                          ),
                        );
                      },
                      child: DebateTile(
                        timestamp: DateFormat('MMM dd, yyyy')
                          .format(timestamp.toDate())
                          .toString(),
                        title: title,
                        likes: List<String>.from(data['likes'] ?? []),
                        debateId: debate.id,
                        forOpinions:
                            List<String>.from(data['forOpinions'] ?? []),
                        againstOpinions:
                            List<String>.from(data['againstOpinions'] ?? []), imageUrl: debate['imageUrl'] ?? '',
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Stream<QuerySnapshot> searchDebates(String query) {
  if (query.isNotEmpty) {
    // Search with Firestore query using "title" field
    return FirebaseFirestore.instance
        .collection('debates')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots();
  } else {
    // Return all debates if search query is empty
    return FirebaseFirestore.instance
        .collection('debates')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

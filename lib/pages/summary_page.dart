// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/message_widget.dart';
import 'package:opinio/pages/env_loader.dart';

class Summarypage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String name;
  final String debateId;
  final List<String> forOpinions;
  final List<String> againstOpinions;
  const Summarypage(
      {super.key,
      required this.title,
      required this.name,
      required this.debateId,
      required this.forOpinions,
      required this.againstOpinions, required this.imageUrl});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  //var _isSelectedFor = false;
  //var _isSelectedAgainst = false;

  bool isLiked = false;
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFieldFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _loading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Env.apiKey ?? '', // Use the loaded API key here
    );
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth_page');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 36,
            )),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
          //Till image to for against
          children: [
            //Image
            Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                          image: widget.imageUrl.isNotEmpty
                              ? NetworkImage(widget.imageUrl) // Load from Firebase
                              : AssetImage("lib/Opinio_Images/placeholder.png")
                                  as ImageProvider, // Default placeholder
                          fit: BoxFit.cover,
                        ),
                borderRadius:
                    BorderRadius.circular(20), // Added rounded corners
                boxShadow: [
                  // Added shadow for elevation effect
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Statement
            // Text(widget.statement),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 10),
            //Opinion summary stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DebatePageButton(
                  imageUrl: widget.imageUrl,
                  shouldColor: false,
                  number: 0,
                  name: 'OPINIONS',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: widget.againstOpinions,
                ),
                //Space
                const SizedBox(
                  width: 5,
                ),
                DebatePageButton(
                  imageUrl: widget.imageUrl,
                  shouldColor: true,
                  number: 1,
                  name: 'SUMMARY',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: widget.againstOpinions,
                ),
                const SizedBox(
                  width: 5,
                ),
                DebatePageButton(
                  imageUrl: widget.imageUrl,
                  shouldColor: false,
                  number: 2,
                  name: 'STATISTICS',
                  debateId: widget.debateId,
                  title: widget.title,
                  forOpinions: widget.forOpinions,
                  againstOpinions: widget.againstOpinions,
                ),
              ],
            ),
            const SizedBox(height: 10),
            //chats and all
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                    itemCount: _chatSession.history.length,
                    itemBuilder: (context, index) {
                      final Content content =
                          _chatSession.history.toList()[index];
                      final text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return Padding(
                        // Added padding for chat messages
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MessageWidget(
                              text: text,
                              isFromUser: content.role == 'user',
                            ),
                            SizedBox(
                                height: 10), // Added space between messages
                            if (content.role == 'gemini')
                              Container(
                                  // Adding container for colored Gemini reply
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 114, 160,
                                        196), // Background color for Gemini reply
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 110, 223,
                                          92), // Text color for Gemini reply
                                    ),
                                  ))
                          ],
                        ),
                      );
                    })),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    // Added padding for input row
                    child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      autofocus: true,
                      focusNode: _textFieldFocus,
                      decoration: textFieldDecoration(),
                      controller: _textController,
                      onSubmitted: _sendChatMessage,
                    )),
                    SizedBox(
                      height: 15,
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () => _sendChatMessage(_textController.text),
                      child:
                          _loading ? CircularProgressIndicator() : Text('Send'),
                    ),
                  ],
                )))
          ]),
    );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: 'What do you wan\'t to know?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ));
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });
    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No response');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 750),
              curve: Curves.easeOutCirc,
            ));
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Something went wrong'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}

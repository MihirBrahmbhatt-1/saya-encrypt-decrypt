import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../utility/encrypt_decrypt.dart';

class DecryptScreen extends StatefulWidget {
  const DecryptScreen({super.key});

  @override
  State<DecryptScreen> createState() => _DecryptScreenState();
}

class _DecryptScreenState extends State<DecryptScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController encryptedController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  String decryptedText = "";
  String searchQuery = "";

  late AnimationController _animationController;
  late Animation<Color?> _highlightColor;

  List<int> matchIndexes = [];
  int currentMatch = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _highlightColor = ColorTween(
      begin: Colors.yellow.withValues(alpha: 0.3),
      end: Colors.yellow.withValues(alpha: 0.8),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    encryptedController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // Your real decrypt logic
  String decrypt(String input) {
    String decryptedString = '';
    decryptedString = decryptApiResponse(input.toString());
    return decryptedString;
  }

  String prettyJson(String rawJson) {
    try {
      final jsonObject = json.decode(rawJson);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      return "Invalid JSON!";
    }
  }

  void updateMatches() {
    matchIndexes.clear();
    currentMatch = 0;

    if (searchQuery.isEmpty || decryptedText.isEmpty) return;

    String lowerText = decryptedText.toLowerCase();
    String lowerQuery = searchQuery.toLowerCase();

    int start = 0;
    while (true) {
      int index = lowerText.indexOf(lowerQuery, start);
      if (index < 0) break;
      matchIndexes.add(index);
      start = index + lowerQuery.length;
    }

    if (matchIndexes.isNotEmpty) currentMatch = 1;
  }

  void nextMatch() {
    if (matchIndexes.isEmpty) return;
    setState(() {
      currentMatch = (currentMatch % matchIndexes.length) + 1;
    });
  }

  void prevMatch() {
    if (matchIndexes.isEmpty) return;
    setState(() {
      currentMatch =
          (currentMatch - 2 + matchIndexes.length) % matchIndexes.length + 1;
    });
  }

  Widget buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: TextStyle(fontSize: 16, fontFamily: "monospace"),
      );
    }

    List<InlineSpan> spans = [];
    int start = 0;
    String lowerText = text.toLowerCase();
    String lowerQuery = query.toLowerCase();

    int matchCounter = 0;

    while (true) {
      int index = lowerText.indexOf(lowerQuery, start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      matchCounter++;
      bool isCurrent = (matchCounter == currentMatch);

      spans.add(
        WidgetSpan(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                color: isCurrent
                    ? Colors.orangeAccent.withValues(alpha: 0.7)
                    : _highlightColor.value,
                child: Text(
                  text.substring(index, index + query.length),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "monospace",
                  ),
                ),
              );
            },
          ),
        ),
      );

      start = index + query.length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${matchIndexes.length} result${matchIndexes.length == 1 ? '' : 's'} found"
          "${matchIndexes.isNotEmpty ? ' - $currentMatch/${matchIndexes.length}' : ''}",
          style: TextStyle(fontSize: 14, color: Colors.blueGrey),
        ),
        SizedBox(height: 8),
        Text.rich(
          TextSpan(children: spans),
          style: TextStyle(fontSize: 16, fontFamily: "monospace"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Hero(tag:'decrypt-tag', child: Text("Decrypt JSON", style: TextStyle(color: AppColors.black, fontSize: 18.0),))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: encryptedController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Paste encrypted code here",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String trimmedInput = encryptedController.text.trim();
                  if (trimmedInput.isNotEmpty) {
                    setState(() {
                      decryptedText = prettyJson(decrypt(trimmedInput));
                      updateMatches();
                    });
                  }
                },
                child: Text("Decrypt"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: decryptedText.isNotEmpty
                        ? () {
                            Clipboard.setData(
                              ClipboardData(text: decryptedText),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Copied to clipboard")),
                            );
                          }
                        : null,
                  ),
                ],
              ),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search in JSON...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.trim();
                    updateMatches();
                  });
                },
              ),
              SizedBox(height: 16),
              if (matchIndexes.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: prevMatch,
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: nextMatch,
                    ),
                  ],
                ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: decryptedText.isEmpty
                    ? Text(
                        "Decrypted text will appear here",
                        style: TextStyle(fontSize: 16, fontFamily: "monospace"),
                      )
                    : buildHighlightedText(decryptedText, searchQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

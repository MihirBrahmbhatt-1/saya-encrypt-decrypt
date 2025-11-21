import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../const/app_colors.dart';
import '../utility/encrypt_decrypt.dart';

class EncryptScreen extends StatefulWidget {
  const EncryptScreen({super.key});

  @override
  State<EncryptScreen> createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController inputController = TextEditingController();

  String encryptedText = "";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  String encrypt(String input) {
    return encryptInputParams(input.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Hero(tag:'encrypt-tag', child: Text("Encrypt Text", style: TextStyle(color: AppColors.black, fontSize: 18.0),))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: inputController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Enter or paste text here",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String trimmedInput = inputController.text.trim();
                  if (trimmedInput.isNotEmpty) {
                    setState(() {
                      encryptedText = encrypt(trimmedInput);
                    });
                  }
                },
                child: Text("Encrypt"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: encryptedText.isNotEmpty
                        ? () {
                            Clipboard.setData(
                              ClipboardData(text: encryptedText),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Copied to clipboard")),
                            );
                          }
                        : null,
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
                child: encryptedText.isEmpty
                    ? Text(
                        "Encrypted text will appear here",
                        style: TextStyle(fontSize: 16, fontFamily: "monospace"),
                      )
                    : Text(
                        encryptedText.toString(),
                        style: TextStyle(fontSize: 16, fontFamily: "monospace"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

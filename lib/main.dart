import 'package:flutter/material.dart';

import 'const/app_colors.dart';
import 'screen/decrypt_screen.dart';
import 'screen/encrypt_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encrypt Decrypt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
      home: const MyHomePage(title: 'Encrypt Decrypt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => EncryptScreen()));

              },
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.enhanced_encryption_outlined, size: 32),
                      SizedBox(width: 16),
                      Hero(tag: 'encrypt-tag', child: Text("Encrypt", style: TextStyle(fontSize: 18, color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => DecryptScreen()));
              },
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.no_encryption_gmailerrorred_outlined, size: 32),
                      SizedBox(width: 16),
                      Hero(tag:'decrypt-tag', child: Text("Decrypt", style: TextStyle(fontSize: 18, color: AppColors.black))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

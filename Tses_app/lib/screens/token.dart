import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  String idToken = "No token available";

  Future<void> getIdToken() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String? token = await user.getIdToken();
        setState(() {
          idToken = token!;
        });
      } else {
        setState(() {
          idToken = "No user signed in";
        });
      }
    } catch (e) {
      setState(() {
        idToken = "Error getting ID token";
      });
      print("Error getting ID token: $e");
    }
  }

    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        appBar: AppBar(
          title: Text('Firebase ID Token Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  getIdToken();
                },
                child: Text('Get ID Token'),
              ),
              SizedBox(height: 16.0),
              Text(
                'ID Token: $idToken',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
  }
}

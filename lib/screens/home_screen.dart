import 'package:flutter/material.dart';
import 'package:handwritten_text_transcriber/screens/camera_screen.dart';
import 'package:handwritten_text_transcriber/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Handwritten Text Transcriber'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              },
              child: Text('Capture Image'),
            ),
            SizedBox(height: 20),
            Text('Transcribed Text will appear here'),
          ],
        ),
      ),
    );
  }
}

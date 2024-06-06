import 'package:flutter/material.dart';

class JournalDetailScreen extends StatelessWidget {
  final String title;
  final String mood;
  final String content;

  JournalDetailScreen({
    required this.title,
    required this.mood,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  mood,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              content,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CreateJournalScreen extends StatefulWidget {
  @override
  _CreateJournalScreenState createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  String? selectedMood;

  final List<String> moods = [
    '😀',
    '😁',
    '😂',
    '😃',
    '😄',
    '😅'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Journal'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Save action
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: selectedMood == mood ? Colors.blue : Colors.grey[200],
                    child: Text(
                      mood,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your story',
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
            ),
          ],
        ),
      ),
    );
  }
}

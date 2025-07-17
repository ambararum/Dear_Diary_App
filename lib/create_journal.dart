import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateJournalScreen extends StatefulWidget {
  @override
  _CreateJournalScreenState createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  String? selectedMood;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
              _saveJournal();
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
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _contentController,
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

  void _saveJournal() {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();
    if (title.isNotEmpty && content.isNotEmpty && selectedMood != null) {
      FirebaseFirestore.instance.collection('journals').add({
        'title': title,
        'mood': selectedMood!,
        'content': content,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'createdAt': DateTime.now(),
      }).then((value) {
        // Jurnal berhasil disimpan, bisa tambahkan navigasi atau feedback lain jika diperlukan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Journal saved successfully')),
        );
        // Bersihkan input setelah disimpan
        _titleController.clear();
        _contentController.clear();
        setState(() {
          selectedMood = null;
        });
      }).catchError((error) {
        // Tangani kesalahan jika gagal menyimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save journal: $error')),
        );
      });
    } else {
      // Tampilkan pesan jika ada input yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }
}

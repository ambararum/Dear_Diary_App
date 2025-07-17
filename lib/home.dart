import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/sign_in');
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return _buildLoggedInUI(context);
          } else {
            return _buildLoggedOutUI(context);
          }
        }
      },
    );
  }

  Widget _buildLoggedOutUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dear Diary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedInUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dear Diary'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        // Tampilan jurnal pengguna
      ),
    );
  }

  void _saveJournal(String title, String mood, String content) {
    FirebaseFirestore.instance.collection('journals').add({
      'title': title,
      'mood': mood,
      'content': content,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'createdAt': DateTime.now(),
    });
  }

  Stream<QuerySnapshot> _getUserJournals() {
    return FirebaseFirestore.instance
        .collection('journals')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}

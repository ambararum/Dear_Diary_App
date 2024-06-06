import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/assets/dear-diary-high-resolution-logo.png',
              width: 200, // Set the desired width
              height: 200,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full width
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}

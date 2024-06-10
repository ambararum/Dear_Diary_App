import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://example.com/profile-pic.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Dahayu Anindya',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'dahayu@example.com | 012345678912',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit Profile Information'),
                  onTap: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  onTap: () {
                    Navigator.pushNamed(context, '/language');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.brightness_6),
                  title: Text('Theme'),
                  trailing: Text('Light mode'),
                ),
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Privacy Policy'),
                  onTap: () {
                    Navigator.pushNamed(context, '/privacyPolicy');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Journals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/my_journals');
          }
        },
      ),
    );
  }
}

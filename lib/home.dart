import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dear Diary'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hi, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Something good will happen to you today.'),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('😀'),
                      ),
                      title: Text('Blue Day'),
                      subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('😃'),
                      ),
                      title: Text('Blue Day'),
                      subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/my_journals');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create_journal');
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyJournalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Journals'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('😀'),
              ),
              title: Text('Blue Day'),
              subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/journal_detail',
                  arguments: {
                    'title': 'Blue Day',
                    'mood': '😀',
                    'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  },
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_journal');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete action
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('😃'),
              ),
              title: Text('Blue Day'),
              subtitle: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/journal_detail',
                  arguments: {
                    'title': 'Blue Day',
                    'mood': '😃',
                    'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  },
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_journal');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete action
                    },
                  ),
                ],
              ),
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}

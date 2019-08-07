import 'package:flutter/material.dart';

class UserAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'user data',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('add user');
        },
        icon: Icon(Icons.add),
        label: Text("Add User"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Show Users'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text('Add user'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Subscription'),
            ),
          ],
          currentIndex: 1,
          onTap: (int index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/');
                break;
              case 1:
                break;
              case 2:
                Navigator.pushNamed(context, '/subscription');
                break;
            }
          },
        ),
      ),
    );
  }
}

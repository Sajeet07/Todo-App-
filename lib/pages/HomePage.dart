import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/pages/LogIn.dart';

import 'package:firebasedemo/pages/SignUpPage.dart';
import 'package:firebasedemo/ButtomNavigationbarPages/AddTodo.dart';
import 'package:firebasedemo/ButtomNavigationbarPages/page1.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Page1(),
    const AddTodo(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 50, 230, 65),
        appBar: AppBar(
          elevation: 5,
          backgroundColor: const Color.fromARGB(255, 50, 230, 65),
          title: const Text(
            "Today's Schedule",
            style: TextStyle(
                fontSize: 29, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LogInPage()));
                },
                icon: const Icon(Icons.logout)),
            const SizedBox(
              width: 35,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/sajit_avatar.jpg"),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  "Tuesday 21",
                  style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}

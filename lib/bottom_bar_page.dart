import 'package:flutter/material.dart';
import 'package:testflutterapp/home/home_screen.dart';

import 'package:testflutterapp/user_profile/user_profile_screen.dart';

class BottomBarScreen extends StatelessWidget {
  final int indexedPage;

  const BottomBarScreen({required this.indexedPage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBarPage(idxPage: indexedPage),
    );
  }
}

class BottomBarPage extends StatefulWidget {
  final int idxPage;

  const BottomBarPage({required this.idxPage});

  @override
  State<BottomBarPage> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBarPage> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    UserProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.idxPage;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

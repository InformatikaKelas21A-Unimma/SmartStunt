import 'package:example/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'immunReminder.dart';
import 'rooms.dart';
import 'setting.dart';

class MainPage extends StatefulWidget {
  final String? documentId;

  const MainPage({Key? key, this.documentId}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages(_selectedIndex) => [
        DashboardPage(documentId: widget.documentId),
        ImmunReminderPage(),
        RoomsPage(),
        SettingPage(),
      ];

  @override
  Widget build(BuildContext context) {
    List<Widget> currentPages = pages(_selectedIndex);
    return Scaffold(
      body: currentPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedItemColor: greenColor,
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: "Reminder",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble),
            label: "Consultation",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

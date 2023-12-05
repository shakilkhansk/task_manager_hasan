import 'package:flutter/material.dart';
import 'package:task_manager_hasan/Screen/Home/CancelTaskPage.dart';

import 'CompleteTaskPage.dart';
import 'NewTaskPage.dart';
import 'PendingTaskPage.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int myIndex = 0;
  List<Widget> _myWidget = [
    NewTaskPage(),
    PendingTaskPage(),
    CompleteTaskPage(),
    CancelTaskPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _myWidget[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.new_label_outlined),label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.pending),label: 'Process'),
          BottomNavigationBarItem(icon: Icon(Icons.done),label: 'Complete'),
          BottomNavigationBarItem(icon: Icon(Icons.close),label: 'Canceled'),
        ],
      ),
    );
  }
}

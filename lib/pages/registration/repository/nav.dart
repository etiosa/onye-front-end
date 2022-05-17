// ignore_for_file: unnecessary_const


import 'package:flutter/material.dart';
import 'package:onye_front_ened/pages/dashboard.dart';

class ScreenNavigator extends StatefulWidget {
  @override
  _ScreenNavigatorState createState() => _ScreenNavigatorState();
}

void _nextPageNerxt() {
  //Nav
}

//route latter on

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int _selectedIndex = 0;

  final _screens = [
  
   
    const Dashboard()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 249, 249, 251),
        body: Stack(
          children: _screens
              .asMap()
              .map(
                (i, screen) => MapEntry(
                  i,
                  Offstage(
                    child: screen,
                    offstage: _selectedIndex != i,
                  ), // every screen will be render but only selected one will be visible
                ),
              )
              .values
              .toList(),
        ), // only rendering the screen we clicked on  _screens[_selectedIndex], have this way, it will lose navigation stack whenver we change screen
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          showUnselectedLabels: true,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: Color.fromARGB(255, 121, 113, 234),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          items: const <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.home,
                  size: 16,
                  color: const Color.fromARGB(255, 107, 116, 130),
                ),
              ),
              label: 'Home',
              activeIcon: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.home,
                  size: 18,
                  color: const Color.fromARGB(255, 121, 113, 234),
                ),
              ),
              backgroundColor: Colors.red,
            ),
            const BottomNavigationBarItem(
                icon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.settings,
                    size: 16,
                    color: const Color.fromARGB(255, 107, 116, 130),
                  ),
                ),
                label: 'Seeting',
                activeIcon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.settings,
                    size: 18,
                    color: const Color.fromARGB(255, 121, 113, 234),
                  ),
                )),
            const BottomNavigationBarItem(
                icon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.notifications,
                    size: 16,
                    color: const Color.fromARGB(255, 107, 116, 130),
                  ),
                ),
                label: 'Notification',
                activeIcon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.notifications,
                    size: 18,
                    color: const Color.fromARGB(255, 121, 113, 234),
                  ),
                )),
            const BottomNavigationBarItem(
                icon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.hardware,
                    size: 16,
                    color: const Color.fromARGB(255, 107, 116, 130),
                  ),
                ),
                label: 'Maintenance',
                activeIcon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.hardware,
                    size: 18,
                    color: const Color.fromARGB(255, 121, 113, 234),
                  ),
                )),
            const BottomNavigationBarItem(
                icon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.description,
                    size: 16,
                    color: const Color.fromARGB(255, 107, 116, 130),
                  ),
                ),
                label: 'Ledger',
                activeIcon: const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.description,
                    size: 18,
                    color: const Color.fromARGB(255, 121, 113, 234),
                  ),
                )),
          ],
        ));
  }
}

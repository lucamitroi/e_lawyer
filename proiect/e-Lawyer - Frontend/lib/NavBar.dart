import 'package:first_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'MenuPage.dart';

class NavBar extends StatefulWidget {
  NavBar({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Future<bool> _onWillPop() async {
    return false;
  }

  int _index = 1;
  void changeTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      MenuPage(),
      HomePage(),
      ProfilePage(),
    ];
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: _index,
            children: screens,
          ),
          resizeToAvoidBottomInset: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.0),
          bottomNavigationBar: BottomAppBar(
            child: BottomNavigationBar(
                currentIndex: _index,
                onTap: (index) => changeTab(index),
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                    ),
                    label: 'Meniu',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    label: 'Acasă',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    label: 'Profil',
                  )
                ]),
          ),
        ));
  }
}

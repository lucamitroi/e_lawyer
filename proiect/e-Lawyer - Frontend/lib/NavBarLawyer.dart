import 'package:flutter/material.dart';
import 'HomePageLaywer.dart';
import 'ProfilePage.dart';

class NavBarLawyer extends StatefulWidget {
  NavBarLawyer({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _NavBarLawyerState createState() => _NavBarLawyerState();
}

class _NavBarLawyerState extends State<NavBarLawyer> {
  Future<bool> _onWillPop() async {
    return false;
  }

  int _index = 0;
  void changeTab(int index) {
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePageLawyer(),
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

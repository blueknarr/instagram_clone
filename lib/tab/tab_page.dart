import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/search/search_page.dart';

import 'account/account_page.dart';
import 'home/home_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;

  /// home, search, account page를 리스트로 담을 것이다.
  final _pages = [
    const HomePage(),
    const SearchPage(),
    AccountPage(),
    ProfileScreen(
      providers: [
        EmailAuthProvider(),
      ],
      avatarSize: 24,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// _currentIndex에 따라 body에서 보여주는 page 전환
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        /// item이 3개 이상이면 흰색 배경이라 방지 옵션
        type: BottomNavigationBarType.fixed,

        /// bottomNavigationBar에 currentIndex 속성이 있다.
        currentIndex: _currentIndex,

        /// Icon을 터치 했을 때, index 값이 변하고 화면 갱신
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

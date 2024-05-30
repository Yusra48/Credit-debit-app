import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter_application_1/Controller/home/Expensepage.dart';
import 'package:flutter_application_1/Controller/home/Mycards.dart';
import 'package:flutter_application_1/Controller/home/homeView.dart';

class MyNavigationbar extends StatefulWidget {
  const MyNavigationbar({super.key});

  @override
  State<MyNavigationbar> createState() => _MyNavigationbarState();
}

class _MyNavigationbarState extends State<MyNavigationbar> {
  late int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    ExpenseView(),
    MyCardsPage(),
    // AddPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _pages[_currentIndex],
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(bottom: 30),
              child: FloatingNavbar(
                onTap: _onTap,
                currentIndex: _currentIndex,
                items: [
                  FloatingNavbarItem(icon: Icons.home, title: 'Home'),
                  FloatingNavbarItem(icon: Icons.bar_chart, title: 'Expense'),
                  FloatingNavbarItem(icon: Icons.credit_card, title: 'Cards'),
                  FloatingNavbarItem(icon: Icons.add, title: 'Add'),
                ],
                backgroundColor: Colors.black,
                elevation: 3,
                selectedBackgroundColor: Colors.transparent,
                selectedItemColor: const Color(0xFF36738F),
                unselectedItemColor: const Color(0xFFD7E4EB),
                fontSize: 12,
                iconSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

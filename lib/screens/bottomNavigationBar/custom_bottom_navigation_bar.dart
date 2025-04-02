import 'package:bingo_project/AppConstData/app_colors.dart';
import 'package:bingo_project/screens/driving/driving_screen.dart';
import 'package:bingo_project/screens/home_screen/home_screen.dart';
import 'package:bingo_project/screens/login/login_screen.dart';
import 'package:bingo_project/screens/theory_page/theory_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  // List of screens for each tab
  final List<Widget> _screens = [
    HomeScreen(),
    DrivingScreen(),
    const TheoryScreen(),

    const LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(

        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // Shadow color
              blurRadius: 10, // Softens the shadow
              offset: Offset(0, 0.2), // Moves the shadow upwards
            ),
          ],
          
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: BottomNavigationBar(

          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

          type: BottomNavigationBarType.fixed,
          elevation: 0, // Removes shadow
          items: List.generate(4, (index) {
            final icons = [
              Icons.home,
              Icons.drive_eta,
              Icons.book,
              Icons.settings
            ];
            final labels = ['Home', 'Driving', 'Theory', 'Setting'];

            return BottomNavigationBarItem(

              icon: Column(
                children: [
                  if (_selectedIndex == index)
                    Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icons[index],
                        color: Colors.green,
                      ),
                    )
                  else
                    Icon(
                      icons[index],
                    ),
                ],
              ),
              label: labels[index],

            );
          }),
        ),
      ),
    );
  }
}
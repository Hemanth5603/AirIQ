import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/views/tabs/doctor.dart';
import 'package:hackoverflow_mobile/views/tabs/home_screen.dart';
import 'package:hackoverflow_mobile/views/tabs/precautions.dart';
import 'package:hackoverflow_mobile/views/tabs/profile.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TabItem> _navBarItems() {
  return [
    TabItem(icon: Icons.home, title: "Home"),
    TabItem(icon: Icons.search, title: "Search"),
    TabItem(icon: Icons.settings, title: "Settings"),
    TabItem(icon: Icons.person, title: "Profile"),
  ];
}

static List<BottomNavigationBarItem> tabs = const [
      BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('icons/home.png')),
          activeIcon: ImageIcon(AssetImage('icons/home.png')),
          label: 'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.list_rounded),
        activeIcon: Icon(Icons.list_rounded),
        label: 'Precautions'
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('icons/search.png')),
        activeIcon: ImageIcon(AssetImage('icons/search.png')),
        label: 'Doctor'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        activeIcon: Icon(Icons.person_rounded),
        label: 'Profile'
      )
   ];
      int selectedIndex = 0;

List<Widget> pages = [
  HomeScreen(),
  PrecautionsPage(),
  DoctorScreen(),
  ProfileScreen(),
];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
 

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Constants.getColor(52),
          unselectedItemColor: Color.fromARGB(255, 220, 220, 220),
          elevation: 10,
          currentIndex: selectedIndex,
          onTap: (value){
            setState(() {
    
              selectedIndex = value;
            });
            
          },
          items:tabs
         ),
      body:  pages[selectedIndex],
      
  
    );
  }
}
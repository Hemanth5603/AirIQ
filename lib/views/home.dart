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
  ];
}

 List<Widget> pages = [
      HomeScreen(),
      PrecautionsPage(),
      DoctorScreen(),
  ];
  void onChange(index){
  setState(() {
    selectedIndex = index;
  });
  
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
        icon: Icon(Icons.shopping_cart_rounded),
        activeIcon: Icon(Icons.shopping_cart_rounded),
        label: 'Market Place'
      ),
   ];
      int selectedIndex = 0;




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
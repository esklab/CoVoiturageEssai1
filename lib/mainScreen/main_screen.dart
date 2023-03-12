import 'package:flutter/material.dart';
import 'package:uberme/tabPages/earning_tab.dart';
import 'package:uberme/tabPages/home_tab.dart';
import 'package:uberme/tabPages/profile_page.dart';
import 'package:uberme/tabPages/ratings_pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{
  TabController? tabController;
  int selectedIndex =0;

  onItemClicked(int index){
    setState(() {
      selectedIndex =index;
      tabController!.index =selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController =TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: "Revenus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Etoile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Compte",
          ),
        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white ,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}

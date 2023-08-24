import 'package:casual/ui/activity/activityScreen.dart';
import 'package:casual/ui/home_screen.dart';
import 'package:casual/ui/profile_screen.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const Text("Search"),
    const Text("Rewards"),
    const ActivityScreen(),
    const ProfileScreen()
  ];

  _onItemTabbed(int index){
    _pageController.jumpToPage(index);
  }

  _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color(0Xff111E28),
        foregroundColor: Colors.white,
        title: const Center(child: Text("Casual")),
        actions: [
          IconButton(onPressed: () {
            Constants.showLogoutDialog(context);
          }, icon: const Icon(Icons.power_settings_new))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 150,
            height: 30,
            // color: Colors.purple,
            child: Stack(
              children: [
                IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Constants.showFlutterToast("Notifications", Colors.orange);
                  },
                ),
                Positioned(
                  child: Stack(
                    children: const [
                      Positioned(
                        top: 4.0,
                        right: 0,
                        child: Icon(
                          size: 15,
                          Icons.brightness_1,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTabbed,
        selectedIconTheme: const IconThemeData(
          color: Color(0Xff111E28),
        ),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: selectedIndex,
        elevation: 100,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: const Color(0xFF526480),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_off_sharp),
            label: "search",
            activeIcon: Icon(Icons.search)
          ),
          BottomNavigationBarItem(
              label: "rewards",
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet)
          ),
          BottomNavigationBarItem(
              label: "activity",
              icon: Icon(Icons.local_activity_outlined),
              activeIcon: Icon(Icons.local_activity)
          ),
          BottomNavigationBarItem(
              label: "profile",
              icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle)
          )
        ],
      ),
    );
  }
}

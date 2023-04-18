import 'package:casual/ui/home_screen.dart';
import 'package:casual/ui/profile_screen.dart';
import 'package:casual/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;
  PageController _pageController = PageController();

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text("Rewards"),
    ProfileScreen()
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
        title: Center(child: Text("Casual")),
        actions: [
          IconButton(onPressed: () {
            Constants.showLogoutDialog(context);
          }, icon: Icon(Icons.power_settings_new))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: 150,
            height: 30,
            // color: Colors.purple,
            child: Stack(
              children: [
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Constants.showFlutterToast("Notifications", Colors.orange);
                  },
                ),
                Positioned(
                  child: Stack(
                    children: [
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
        children: _widgetOptions,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
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
        unselectedItemColor: Color(0xFF526480),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: "home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label: "rewards",
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet)
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

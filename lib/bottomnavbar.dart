import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kisma_livescore/screens/home/homeScreen.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/screens/events/myevents.dart';
import 'package:kisma_livescore/screens/home/socket/WebSocketService.dart';
import 'package:kisma_livescore/screens/series/seriespage.dart';
import 'package:kisma_livescore/screens/settings/settings.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required BuildContext menuScreenContext})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();

}

class _DashboardState extends State<Dashboard> {
  // late WebSocketService webSocketService;


  @override
  void initState() {
    // Initialize WebSocket service
    // webSocketService = WebSocketService();
    // Activate WebSocket client
    // webSocketService.activate();
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // Disconnect WebSocket service
  //   webSocketService.disconnect();
  // }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> buildScreens() {
    //  return [const HomeScreen(), MyEventsScreen(), SeriesScreen(), SettingsScreen()];
      return [const HomeScreen(), SettingsScreen()];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          // icon:Icon(Icons.home),
          icon: Icon(
            MyFlutterApp.home,
            // size: 32,
          ),
          title: ("Home"),
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
          contentPadding: 0, // Remove internal padding
        ),
      /*  PersistentBottomNavBarItem(
          icon: const Icon(MyFlutterApp.calendar),
          title: ("My Events"),
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
          contentPadding: 0, // Remove internal padding
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            MyFlutterApp.series,
          ),
          title: "Series",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
          contentPadding: 0, // Remove internal padding
        ),*/
        PersistentBottomNavBarItem(
          icon: const Icon(
            MyFlutterApp.setting,
          ),
          title: "Settings",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
          contentPadding: 0, // Remove internal padding
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: AppBar(
      //     iconTheme: const IconThemeData(color: Colors.white),
      //     // toolbarHeight: 106,
      //     backgroundColor: Colors.transparent,
      //     automaticallyImplyLeading: false,
      //     leading: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset(
      //         "assets/images/livescore.png",
      //         fit: BoxFit.fitWidth,
      //       ),
      //     ),
      //     elevation: 0.0,
      //     leadingWidth: 140,
      //     actions: [
      //       Image.asset(
      //         "assets/images/notification.png",
      //         height: 24,
      //         width: 24,
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //     ],
      //   ),
      // ),

      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        items: navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        padding: const EdgeInsets.only(top: 8),
        //    hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          //  borderRadius: BorderRadius.circular(50.0),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          colorBehindNavBar: Color(0xff3d3E68),

        ),
        //  popAllScreensOnTapOfSelectedTab: false,
        //  popActionScreens: PopActionScreensType.all,
        //   itemAnimationProperties: const ItemAnimationProperties(
        //     // Navigation Bar's items animation properties.
        //     duration: Duration(milliseconds: 200),
        //     curve: Curves.ease,
        //   ),
        //   screenTransitionAnimation: const ScreenTransitionAnimation(
        //     // Screen transition animation on change of selected tab.
        //     animateTabTransition: true,
        //     curve: Curves.ease,
        //     duration: Duration(milliseconds: 200),
        //   ),
        navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
    );
  }
}

/*class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required BuildContext menuScreenContext})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> buildScreens() {
      return [const HomeScreen(), MyEventsScreen(), SeriesScreen(), SettingsScreen()];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          // icon:Icon(Icons.home),
          icon: Icon(
            MyFlutterApp.home,
            // size: 32,
          ),
          title: ("Home"),
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(MyFlutterApp.calendar),
          title: ("My Events"),
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            MyFlutterApp.series,
          ),
          title: "Series",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            MyFlutterApp.setting,
          ),
          title: "Settings",
          textStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Colors.white,
          ),
          activeColorPrimary: const Color(0xFF001548),
          inactiveColorPrimary: Color(0xff96A0B7),
        ),
      ];
    }

    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60.0),
      //   child: AppBar(
      //     iconTheme: const IconThemeData(color: Colors.white),
      //     // toolbarHeight: 106,
      //     backgroundColor: Colors.transparent,
      //     automaticallyImplyLeading: false,
      //     leading: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset(
      //         "assets/images/livescore.png",
      //         fit: BoxFit.fitWidth,
      //       ),
      //     ),
      //     elevation: 0.0,
      //     leadingWidth: 140,
      //     actions: [
      //       Image.asset(
      //         "assets/images/notification.png",
      //         height: 24,
      //         width: 24,
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //     ],
      //   ),
      // ),

      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        // margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        items: navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
    //    hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
        //  borderRadius: BorderRadius.circular(50.0),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          colorBehindNavBar: Color(0xff3d3E68),

        ),
      //  popAllScreensOnTapOfSelectedTab: false,
      //  popActionScreens: PopActionScreensType.all,
      //   itemAnimationProperties: const ItemAnimationProperties(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 200),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: const ScreenTransitionAnimation(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     curve: Curves.ease,
      //     duration: Duration(milliseconds: 200),
      //   ),
        navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
    );
  }
}*/

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/events/myeventdays/myallevents.dart';

class MyEventsDaysScreen extends StatefulWidget {
  const MyEventsDaysScreen({super.key});

  @override
  State<MyEventsDaysScreen> createState() => _MyEventsDaysScreenState();
}

class _MyEventsDaysScreenState extends State<MyEventsDaysScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  int _currentIndex = 0;
  @override
  void initState() {
    _controller = TabController(length: 5, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: AppBar(
              backgroundColor: Color(0xff001548),
              bottom: ButtonsTabBar(
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                radius: 30,
                height: 35,
                unselectedBackgroundColor: Colors.white,
                decoration: BoxDecoration(color: neonColor),
                controller: _controller,
                tabs: [
                  Tab(
                    // height: 20,
                    child: Text(
                      'All',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Men',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'T20',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'ODI',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Int.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                // first tab bar view widget
                MyAllEventsScreen(),

                // second tab bar viiew widget
                Container(
                  color: Colors.pink,
                  child: Center(
                    child: Text(
                      'Car',
                    ),
                  ),
                ),
                Container(
                  color: Colors.pink,
                  child: Center(
                    child: Text(
                      'Car',
                    ),
                  ),
                ),
                Container(
                  color: Colors.pink,
                  child: Center(
                    child: Text(
                      'Car',
                    ),
                  ),
                ),
                Container(
                  color: Colors.pink,
                  child: Center(
                    child: Text(
                      'Car',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

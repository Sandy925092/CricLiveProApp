import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesSquadScreen extends StatefulWidget {
  const SeriesSquadScreen({super.key});

  @override
  State<SeriesSquadScreen> createState() => _SeriesSquadScreenState();
}

class _SeriesSquadScreenState extends State<SeriesSquadScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  int _currentIndex = 0;

  void initState() {
    _controller = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 8.h,
            child: AppBar(
              backgroundColor: bgColor,
              bottom: ButtonsTabBar(
                center: false,
                contentPadding: EdgeInsets.symmetric(horizontal: 40),
                radius: 10,
                height: 7.h,
                unselectedBackgroundColor:
                    const Color.fromARGB(255, 226, 226, 226),
                decoration: BoxDecoration(color: neonColor),
                controller: _controller,
                tabs: [
                  Tab(
                    // height: 20,
                    child: Text(
                      'IND 146-2 (20.0)',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'AUS 000-0 (00.0)',
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
                Container(

                    // color: Colors.pink,
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                          itemCount: 9,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'R Sharma (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      3.h.heightBox,
                      Text(
                        'Bench',
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ).pOnly(left: 10),
                      GridView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'R Sharma (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      3.h.heightBox,
                      Text(
                        'Support Staff',
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ).pOnly(left: 10),
                      GridView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'R Sharma (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      2.h.heightBox
                    ],
                  ),
                )),
                // second tab bar viiew widge
                Container(

                    // color: Colors.pink,
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                          itemCount: 9,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S Smith (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      3.h.heightBox,
                      Text(
                        'Bench',
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ).pOnly(left: 10),
                      GridView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S Smith (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      3.h.heightBox,
                      Text(
                        'Support Staff',
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ).pOnly(left: 10),
                      GridView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 2.5),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff001548),
                                    child: Image.asset(
                                      'assets/images/batternew.png',
                                      scale: 3,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'S Smith (c)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/bat.png',
                                            scale: 3,
                                          ),
                                          1.w.widthBox,
                                          Text('WK')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                      2.h.heightBox
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

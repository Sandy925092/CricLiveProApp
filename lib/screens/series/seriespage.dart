import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/screens/series/seriesmatches.dart';
import 'package:kisma_livescore/screens/series/seriesoverview.dart';
import 'package:kisma_livescore/screens/series/seriessquad.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  int _currentIndex = 0;

  void initState() {
    _controller = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff001548).withOpacity(0.7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff001548),

                // border: Border.all(color: txtGrey),
                // borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                    width: 100.w,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            'assets/images/afgvsnzw.png',
                            scale: 4,
                          );
                        }),
                  ),
                  Text(
                    'IND vs AUS 2023 ',
                    style: TextStyle(
                        color: neonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ).pOnly(left: 10),
                  1.h.heightBox,
                  Container(
                    height: 0.6.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                        color: neonColor,
                        borderRadius: BorderRadius.circular(10)),
                  ).pOnly(left: 10),
                ],
              ),
            ),
            Container(
              // margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Color(0xff001548).withOpacity(0.7),
                // border: Border.all(color: txtGrey),
                // borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  1.h.heightBox,
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(),
                  //     Text(
                  //       '1st T20',
                  //       style: TextStyle(
                  //           color: txtGrey,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //     Container()
                  //   ],
                  // ),
                  1.h.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/indiaflag.png',
                            scale: 3,
                          ),
                          1.heightBox,
                          Text(
                            'India',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: neonColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    '146/2',
                                    style: TextStyle(
                                        color: Color(0xff001648),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Text(
                                ' : 175',
                                style: TextStyle(
                                    color: Color(0xffE4E5E9),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          1.heightBox,
                          Text(
                            '39.2/45 ov',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/ausflag.png',
                            scale: 3,
                          ),
                          1.heightBox,
                          Text(
                            'Australia',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ).pSymmetric(h: 15),
                  1.h.heightBox
                ],
              ).pSymmetric(h: 10),
            ).pOnly(bottom: 1),
            SizedBox(
              height: 50,
              child: AppBar(
                backgroundColor: Color(0xff001548).withOpacity(0.7),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(20),
                  child: ButtonsTabBar(
                    center: false,
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
                          'Overview',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Tab(
                        // height: 20,
                        child: Text(
                          'Matches',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Tab(
                        // height: 20,
                        child: Text(
                          'Squads',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ).objectCenterLeft(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  // first tab bar view widget
                  SeriesOverviewScreen(),

                  // second tab bar viiew widget
                  SeriesMatchesScreen(),
                  SeriesSquadScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

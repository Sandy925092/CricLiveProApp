import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/events/myeventseries/myeventseriesdetailsmatches.dart';
import 'package:kisma_livescore/events/myeventseries/myeventseriesdetailsoverview.dart';
import 'package:kisma_livescore/series/seriesmatches.dart';
import 'package:kisma_livescore/series/seriessquad.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class MyEventSeriesDetailScreen extends StatefulWidget {
  const MyEventSeriesDetailScreen({super.key});

  @override
  State<MyEventSeriesDetailScreen> createState() =>
      _MyEventSeriesDetailScreenState();
}

class _MyEventSeriesDetailScreenState extends State<MyEventSeriesDetailScreen>
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColors,
            elevation: 0.0,
            leadingWidth: 30,
            centerTitle: false,
            title: commonText(
                    data: "Zim vs Bgd Series",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    color: Colors.white)
                .p(10),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  "assets/images/backicon.png",
                  height: 0,
                ),
              ),
            )),
      ),
      body: Column(
        children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      '1st T20',
                      style: TextStyle(
                          color: txtGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Container()
                  ],
                ),
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
                          'Team Name 1',
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
                                  'TN1 Won',
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
                          'Team Name 2',
                          style: TextStyle(
                              color: Color(0xffE4E5E9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ).pSymmetric(h: 10),
          ),
          SizedBox(
            height: 50,
            child: AppBar(
              backgroundColor: Color(0xff001548).withOpacity(0.7),
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
                  // Tab(
                  //   // height: 20,
                  //   child: Text(
                  //     'Stats',
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                // first tab bar view widget
                MyEventSeriesDetailsOverviewScreen(),

                // second tab bar viiew widget
                SeriesMatchesScreen(),
                SeriesSquadScreen(),
                // Container(
                //   color: Colors.pink,
                //   child: Center(
                //     child: Text(
                //       'Car',
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/lineall16.dart';
import 'package:kisma_livescore/home/linebat8.dart';
import 'package:kisma_livescore/home/lineupar2.dart';
import 'package:kisma_livescore/home/lineupbowl6.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LineUpDetails extends StatefulWidget {
  const LineUpDetails({Key? key}) : super(key: key);

  @override
  State<LineUpDetails> createState() => _LineUpDetailsState();
}

class _LineUpDetailsState extends State<LineUpDetails>  with TickerProviderStateMixin {

  TabController? _controller;
  int _currentIndex = 0;

  void initState() {
    _controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 35,
            color: greyColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                commonText(
                    data: "CRR: 9.04",
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    color: primaryColors),
                commonText(
                    data: "RRR: 7.57",
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    color: primaryColors),
                commonText(
                    data: "TN1 needs 00 run in 00 balls to win",
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    color: primaryColors),
              ],
            ),
          ),
          SizedBox(
            height: 40,
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
                      'All 16',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Bat 8',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  Tab(
                    // height: 20,
                    child: Text(
                      'Bowl 6',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  Tab(
                    // height: 20,
                    child: Text(
                      'AR 2',
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
                LineAll16(),
                LineBat8(),
                LineUpBowl6(),
                LineUpAr2(),

              ],
            ),
          ),







        ],
      ),
    );
  }
}




import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/linedetails.dart';
import 'package:kisma_livescore/home/livematchdetailsfirst.dart';
import 'package:kisma_livescore/home/livescoreddetails.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveMatchDetails extends StatefulWidget {
  const LiveMatchDetails({Key? key}) : super(key: key);

  @override
  State<LiveMatchDetails> createState() => _LiveMatchDetailsState();
}

class _LiveMatchDetailsState extends State<LiveMatchDetails>
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
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Live",
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
          ),
        ),
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
                3.h.heightBox,
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
                    ).pOnly(left: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: neonColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        '146/2',
                        style: TextStyle(
                            color: Color(0xff001648),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ).pOnly(left: 10, right: 10, top: 4, bottom: 4),
                    ),
                    Text(
                      '12.1',
                      style: TextStyle(
                          color: Color(0xffE4E5E9),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    1.heightBox,
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: buttonColors),
                      ),
                      child: commonText(
                              data: "14",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: buttonColors)
                          .p(20),
                    )
                  ],
                ),
                commonText(
                    data: "Target: 168",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    color: white),
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
                      'Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Scorecard',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Lineup',
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
                LiveMatchDetailsFirst(),
                LiveScoredDetails(),
                LineUpDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

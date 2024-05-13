import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/screens/home/linedetails.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesMatchScorecardScreen extends StatefulWidget {
  const SeriesMatchScorecardScreen({super.key});

  @override
  State<SeriesMatchScorecardScreen> createState() =>
      _SeriesMatchScorecardScreenState();
}

class _SeriesMatchScorecardScreenState extends State<SeriesMatchScorecardScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  TabController? _controller2;
  int _currentIndex = 0;
  int _currentIndex2 = 0;
  var students = {
    "id": ['123', '456', '789'],
    "firstName": ["old", "gold", "silver"],
    "surName": ["new", 'newwww', "newest"]
  };

  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller2 = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "ENG vs IND Matches",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              "assets/images/backicon.png",
              height: 0,
            ),
          ).onTap(() {
            Navigator.of(context).pop();
          }),
        ),
      ),
      body: SafeArea(
        child: Column(
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
                  2.h.heightBox,
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
                          ),
                          Text(
                            '350/5',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 14,
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
                          1.h.heightBox,
                          Text(
                            'Australia',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '300/5',
                            style: TextStyle(
                                color: Color(0xffE4E5E9),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    ],
                  ).pSymmetric(h: 20),
                ],
              ).pSymmetric(h: 10),
            ),
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
                  ).objectCenterLeft(),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  // first tab bar view widget
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(color: Color(0xffE4E5E9)),
                          child: Row(
                            children: [
                              Text('CRR: 9.04',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700)),
                              Spacer(),
                              Text('India won by 8 wickets',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700))
                            ],
                          ).pSymmetric(h: 10),
                        ),
                        SizedBox(
                          height: 8.h,
                          child: AppBar(
                            backgroundColor: bgColor,
                            bottom: ButtonsTabBar(
                              center: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 30),
                              radius: 10,
                              height: 7.h,
                              unselectedBackgroundColor:
                                  const Color.fromARGB(255, 226, 226, 226),
                              decoration: BoxDecoration(color: neonColor),
                              controller: _controller2,
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
                            child:
                                TabBarView(controller: _controller2, children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Batter",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "B",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "4s",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "6s",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "S/R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'N.Name',
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                        'c Chaudhary\nb Jordan',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('39',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '6',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '156.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'N.Name',
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                        'c Chaudhary\nb Jordan',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('39',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '6',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '156.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('1',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '50.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('1',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '50.00',
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                ).pSymmetric(h: 10),
                                2.h.heightBox,
                                Row(
                                  children: [
                                    Text('Extras:',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    Spacer(),
                                    Text('5(b 4, lb 1, w 0, nb 0, p 0)',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))
                                  ],
                                ).pSymmetric(h: 20),
                                3.h.heightBox,
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Bowling",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "O",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "M",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "W",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "E/R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('7.0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3.71',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('25',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2.80',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('7.0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3.71',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('25',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2.80',
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ).pSymmetric(h: 10),
                                3.h.heightBox,
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Fall Of Wickets",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Score",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Over",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '84-1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '17.3',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '99-2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25.1',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '100-3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26.3',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '102-4',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29.2',
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ).pSymmetric(h: 10),
                                3.h.heightBox,
                                Text('Partnership',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))
                                    .pSymmetric(h: 10),
                                2.h.heightBox,
                                Row(
                                  children: [
                                    Text('Batter - 1',
                                        style: TextStyle(
                                            color: Color(0xff96A0B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    Spacer(),
                                    Text('Batter - 2',
                                        style: TextStyle(
                                            color: Color(0xff96A0B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ).pSymmetric(h: 10),
                                1.h.heightBox,
                                ListView.builder(
                                    itemCount: 3,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('1st Wicket',
                                                style: TextStyle(
                                                    color: Color(0xff96A0B7),
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            0.5.h.heightBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('R.Sharma',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    0.5.h.heightBox,
                                                    Text('47(61)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/partnership2.png',
                                                      scale: 3.5,
                                                    ),
                                                    1.w.widthBox,
                                                    Text('84 (105)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text('Jaiswal',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text('37(44)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ).pSymmetric(h: 10, v: 10),
                                      ).pSymmetric(h: 10);
                                    }),
                                2.h.heightBox
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Batter",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "B",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "4s",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "6s",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "S/R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'N.Name',
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                        'c Chaudhary\nb Jordan',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('39',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '6',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '156.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'N.Name',
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.keyboard_arrow_down,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                        'c Chaudhary\nb Jordan',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('39',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '6',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '156.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('1',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '50.00',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('1',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '-',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '50.00',
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                ).pSymmetric(h: 10),
                                2.h.heightBox,
                                Row(
                                  children: [
                                    Text('Extras:',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                    Spacer(),
                                    Text('5(b 4, lb 1, w 0, nb 0, p 0)',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))
                                  ],
                                ).pSymmetric(h: 20),
                                3.h.heightBox,
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Bowling",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "O",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "M",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "W",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "E/R",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('7.0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3.71',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('25',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2.80',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('7.0',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3.71',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text('25',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '2.80',
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ).pSymmetric(h: 10),
                                3.h.heightBox,
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(2),
                                  },
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                          color: bgColor, width: 10.0)),
                                  children: [
                                    //This table row is for the table header which is static
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          "Fall Of Wickets",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: white),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Score",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Over",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: white),
                                          ),
                                        ),
                                      ),
                                    ]),

                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '84-1',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '17.3',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '99-2',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '25.1',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '100-3',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '26.3',
                                              ),
                                            ),
                                          ),
                                        ]),
                                    TableRow(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 6),
                                            child: Text(
                                              'N.Name',
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '102-4',
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: Text(
                                                '29.2',
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ).pSymmetric(h: 10),
                                3.h.heightBox,
                                Text('Partnership',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))
                                    .pSymmetric(h: 10),
                                2.h.heightBox,
                                Row(
                                  children: [
                                    Text('Batter - 1',
                                        style: TextStyle(
                                            color: Color(0xff96A0B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500)),
                                    Spacer(),
                                    Text('Batter - 2',
                                        style: TextStyle(
                                            color: Color(0xff96A0B7),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ).pSymmetric(h: 10),
                                1.h.heightBox,
                                ListView.builder(
                                    itemCount: 3,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('1st Wicket',
                                                style: TextStyle(
                                                    color: Color(0xff96A0B7),
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            0.5.h.heightBox,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('R.Sharma',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    0.5.h.heightBox,
                                                    Text('47(61)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/partnership2.png',
                                                      scale: 3.5,
                                                    ),
                                                    1.w.widthBox,
                                                    Text('84 (105)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text('Jaiswal',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text('37(44)',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ).pSymmetric(h: 10, v: 10),
                                      ).pSymmetric(h: 10);
                                    }),
                                2.h.heightBox
                              ],
                            ),
                          ),
                        ]))
                      ],
                    ),
                  ),
                  LineUpDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

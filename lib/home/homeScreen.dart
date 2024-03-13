import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/finished/finishscreen.dart';
import 'package:kisma_livescore/home/foryou/foryou.dart';
import 'package:kisma_livescore/home/livematchdetails.dart';
import 'package:kisma_livescore/home/livescreen.dart';
import 'package:kisma_livescore/home/searchscreen.dart';
import 'package:kisma_livescore/home/upcoming/upcomingmatchesscreen.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List tabList = ["Live,For You,Upcoming, Finished"];
  String selectedTab = "Live";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: disableColors,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57.0),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: primaryColors,
              elevation: 0.0,
              leadingWidth: 130,
              centerTitle: false,
              actions: [
                GestureDetector(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const SearchScreen(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Icon(Icons.search, color: buttonColors),
                  ),
                )
              ],
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  "assets/images/appicon.png",
                  height: 40,
                ),
              ),
            ),
            // Divider(
            //   thickness: 1,
            //   color: Colors.white,
            // )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColors,
            bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(.0), // Adjust the height here
              child: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicatorColor: buttonColors,
                labelColor: buttonColors,
                unselectedLabelColor: disableColors,
                indicatorWeight: 3.0,
                dividerColor: buttonColors,
                tabs: [
                  Tab(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      commonText(
                        data: "Live",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                      1.w.widthBox,
                      Container(
                        width: 5.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: buttonColors),
                        child: Center(
                          child: commonText(
                            data: "1",
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: black,
                          ),
                        ),
                      ).p(2)
                    ],
                  )), // Changed from icon to text

                  Tab(
                      child: commonText(
                    data: "For You",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                  )),

                  Tab(
                      child: commonText(
                    overflow: TextOverflow.ellipsis,
                    data: "Upcoming",
                    fontSize: 14,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                  )),

                  Tab(
                      child: commonText(
                    data: "Finished",
                    fontSize: 14,
                    maxLines: 1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                  )),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              LiveScreen(),
              ForYou(),
              UpcomingMatchScreen(),
              FinishedScreen()
            ],
          ),
        ),
      ),

      // Column(
      //   children: [
      //
      //     Container(
      //         width: double.infinity,
      //         decoration: BoxDecoration(color: primaryColors),
      //         child: Column(
      //           children: [
      //             Divider(
      //               thickness: 1,
      //               color: buttonColors.withOpacity(0.2),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(top : 8.0),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Column(
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {
      //                           setState(() {
      //                             selectedTab == "Live";
      //                           });
      //                         },
      //                         child: selectedTab == "Live"
      //                             ? commonText(
      //                           data: "Live",
      //                           fontSize: 14,
      //                           fontWeight: FontWeight.w500,
      //                           fontFamily: "Poppins",
      //                           color: buttonColors,
      //                         )
      //                             : commonText(
      //                             data: "Live",
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: "Poppins",
      //                             color: disableColors),
      //                       ),
      //                       SizedBox(
      //                         height: 12,
      //                       ),
      //                       selectedTab == "Live"
      //                           ? Container(
      //                         height: 3.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: Color(0xFF95E53C),
      //                         ),
      //                       )
      //                           : Container(
      //                         height: 2.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: transparent,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {
      //                           setState(() {
      //                             selectedTab = "For You";
      //                           });
      //                         },
      //                         child: selectedTab == "For You"
      //                             ? commonText(
      //                             data: "For You",
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: "Poppins",
      //                             color: buttonColors)
      //                             : commonText(
      //                             data: "For You",
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: "Poppins",
      //                             color: disableColors),
      //                       ),
      //                       SizedBox(
      //                         height: 12,
      //                       ),
      //                       selectedTab == "For You"
      //                           ? Container(
      //                         height: 3.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: Color(0xFF95E53C),
      //                         ),
      //                       )
      //                           : Container(
      //                         height: 2.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: transparent,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {
      //                           setState(() {
      //                             selectedTab = "Upcoming";
      //                           });
      //                         },
      //                         child: selectedTab == "Upcoming"
      //                             ? commonText(
      //                             data: "Upcoming",
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: "Poppins",
      //                             color: buttonColors)
      //                             : commonText(
      //                             data: "Upcoming",
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: "Poppins",
      //                             color: disableColors),
      //                       ),
      //                       SizedBox(
      //                         height: 12,
      //                       ),
      //                       selectedTab == "Upcoming"
      //                           ? Container(
      //                         height: 3.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: Color(0xFF95E53C),
      //                         ),
      //                       )
      //                           : Container(
      //                         height: 2.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color:transparent,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Column(
      //                     children: [
      //                       GestureDetector(
      //                         onTap: () {
      //                           setState(() {
      //                             selectedTab = "Finished";
      //                           });
      //                         },
      //                         child: selectedTab == "Finished"
      //                             ? commonText(
      //                           data: "Finished",
      //                           fontSize: 14,
      //                           fontWeight: FontWeight.w500,
      //                           fontFamily: "Poppins",
      //                           color: buttonColors,
      //                         )
      //                             : commonText(
      //                           data: "Finished",
      //                           fontSize: 14,
      //                           fontWeight: FontWeight.w500,
      //                           fontFamily: "Poppins",
      //                           color: disableColors,
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 12,
      //                       ),
      //                       selectedTab == "Finished"
      //                           ? Container(
      //                         height: 3.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: Color(0xFF95E53C),
      //                         ),
      //                       )
      //                           : Container(
      //                         height: 2.3,
      //                         width: 80,
      //                         decoration: BoxDecoration(
      //                           color: transparent,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         )),
      //
      //   ],
      // ),
    );
  }
}

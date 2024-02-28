import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/foryou.dart';
import 'package:kisma_livescore/home/livescreen.dart';
import 'package:kisma_livescore/utils/colorfile.dart';

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
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 130,
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(Icons.search, color: buttonColors),
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
                indicatorColor: buttonColors,
                labelColor: buttonColors,
                unselectedLabelColor: disableColors,
                indicatorWeight: 3.0,
                dividerColor: buttonColors,
                tabs: [
                  Tab(
                      child: commonText(
                    data: "Live 1",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
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
              Center(child: Text('Settings')),
              Center(child: Text('Settings')),
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

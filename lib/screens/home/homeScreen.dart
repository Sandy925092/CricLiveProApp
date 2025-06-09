import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/screens/home/finished/finishscreen.dart';
import 'package:kisma_livescore/screens/home/foryou/foryou.dart';
import 'package:kisma_livescore/screens/home/live/livescreen.dart';
import 'package:kisma_livescore/screens/home/searchscreen.dart';
import 'package:kisma_livescore/screens/home/upcoming/upcomingmatchesscreen.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        // length: 1, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColors,
            bottom: PreferredSize(
              preferredSize:
                  const Size.fromHeight(.0), // Adjust the height here
              child: TabBar(
                // Remove tabAlignment and isScrollable
                indicatorColor: buttonColors,
                labelColor: buttonColors,
                unselectedLabelColor: disableColors,
                indicatorWeight: 3.0,
                dividerColor: buttonColors,
                tabs: [
                  Tab(
                    child: Center(
                      child: commonText(
                        data: "Live",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: commonText(
                        data: "For You",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: commonText(
                        overflow: TextOverflow.ellipsis,
                        data: "Upcoming",
                        fontSize: 14,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Tab(
                    child: Center(
                      child: commonText(
                        data: "Finished",
                        fontSize: 14,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              )

            ),
          ),
          body: const TabBarView(
            physics:  NeverScrollableScrollPhysics(),
            children: [
              LiveScreen(),
              ForYou(),
              UpcomingMatchScreen(),
              FinishedScreen()
            ],
          ),
        ),
      ),
    );
  }
}

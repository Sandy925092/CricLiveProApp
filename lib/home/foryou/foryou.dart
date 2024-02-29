import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/foryou/foryoumatchdetails.dart';
import 'package:kisma_livescore/home/livematchdetails.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class ForYou extends StatefulWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  late ExpandedTileController _controller;

  void initState() {
    // initialize controller
    _controller = ExpandedTileController(isExpanded: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          2.h.heightBox,
          ExpandedTile(
            theme: const ExpandedTileThemeData(
              headerSplashColor: transparent,
              contentBackgroundColor: transparent,
            ),
            controller: _controller,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/doticon.png",
                      height: 25,
                      width: 25,
                    ),
                    2.w.widthBox,
                    commonText(
                        data: "International Twenty20 Matches",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Spacer(),
                    Container(
                      width: 35,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Divider(
                    thickness: 1.0,
                    color: buttonColors,
                  ),
                ),
              ],
            ),
            content: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ForYouMatchDetails(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          border: Border.all(color: disableColors)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Add your card title here

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                commonText(
                                  data: "",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: matchTitleColor,
                                ),
                                commonText(
                                  data: "International Twenty20 Matches",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: disableColors,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 4.0, top: 4.0),
                                  child: Image.asset(
                                    "assets/images/notification.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/team2.png",
                                    height: 40,
                                    width: 40,
                                  ),
                                  commonText(
                                    data: "* Live",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black,
                                  ),
                                  Image.asset(
                                    "assets/images/team1.png",
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  commonText(
                                    data: "Zimbabwe",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: teamColor,
                                  ),
                                  commonText(
                                    data: "Bangladesh",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: teamColor,
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 8.0, right: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 12, top: 5, bottom: 5, right: 12),
                                    decoration: BoxDecoration(
                                        color: buttonColors,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: commonText(
                                      data: "146/2",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins",
                                      color: black,
                                    ),
                                  ),
                                  commonText(
                                    data: "39.2/45 ov",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Poppins",
                                    color: overColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: commonText(
                                      data: "175",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins",
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            onTap: () {
              debugPrint("tapped!!");
            },
            onLongTap: () {
              debugPrint("long tapped!!");
            },
          ),
          //* Starting V0.3.4 : ExpandedTileList.builder widget is available.
          ExpandedTileList.builder(
            itemCount: 2,
            maxOpened: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            itemBuilder: (context, index, controller) {
              return ExpandedTile(
                theme: const ExpandedTileThemeData(
                  headerSplashColor: transparent,
                  contentBackgroundColor: transparent,
                ),
                controller: index == 2
                    ? controller.copyWith(isExpanded: true)
                    : controller,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/doticon.png",
                          height: 25,
                          width: 25,
                        ),
                        2.w.widthBox,
                        commonText(
                          data: index == 1
                              ? "The Hundred"
                              : "The Hundred - Womens ",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Divider(
                        thickness: 1.0,
                        color: buttonColors,
                      ),
                    ),
                  ],
                ),
                content: index == 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const ForYouMatchDetails(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: disableColors)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Add your card title here

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonText(
                                          data: "",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          color: matchTitleColor,
                                        ),
                                        commonText(
                                          data:
                                              "International Twenty20 Matches",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          color: disableColors,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 4.0, top: 4.0),
                                          child: Image.asset(
                                            "assets/images/notification.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/images/team2.png",
                                            height: 40,
                                            width: 40,
                                          ),
                                          commonText(
                                            data: "* Live",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: black,
                                          ),
                                          Image.asset(
                                            "assets/images/team1.png",
                                            height: 40,
                                            width: 40,
                                          )
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.0, left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          commonText(
                                            data: "Zimbabwe",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: teamColor,
                                          ),
                                          commonText(
                                            data: "Bangladesh",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: teamColor,
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 8.0, right: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 12,
                                                top: 5,
                                                bottom: 5,
                                                right: 12),
                                            decoration: BoxDecoration(
                                                color: buttonColors,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: commonText(
                                              data: "146/2",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
                                          ),
                                          commonText(
                                            data: "39.2/45 ov",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Poppins",
                                            color: overColor,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: commonText(
                                              data: "175",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const ForYouMatchDetails(),
                                withNavBar:
                                    true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    commonText(
                                      data: "Coming soon",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                  ],
                                ),
                                2.h.heightBox,
                                Container(
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      border: Border.all(color: disableColors)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Add your card title here
                                        0.5.h.heightBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonText(
                                              data: "",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: matchTitleColor,
                                            ),
                                            commonText(
                                              data:
                                                  "International Twenty20 Matches",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0, top: 4.0),
                                              child: Image.asset(
                                                "assets/images/notification.png",
                                                height: 15,
                                                width: 15,
                                              ),
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.asset(
                                                "assets/images/team2.png",
                                                height: 40,
                                                width: 40,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 3,
                                                    bottom: 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    color: buttonColors),
                                                child: Center(
                                                  child: commonText(
                                                    alignment: TextAlign.center,
                                                    data: "Starting \n in 26’",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Poppins",
                                                    color: black,
                                                  ),
                                                ),
                                              ).pOnly(left: 32, right: 32),
                                              Image.asset(
                                                "assets/images/team1.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, left: 8.0, right: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonText(
                                                data: "Zimbabwe",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                              ),
                                              commonText(
                                                data: "Bangladesh",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 20)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                onTap: () {
                  debugPrint("tapped!!");
                },
                onLongTap: () {
                  debugPrint("looooooooooong tapped!!");
                },
              );
            },
          ),

          Container(
            color: disableColors.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                0.5.h.heightBox,
                commonText(
                  data: "Featured",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: primaryColors,
                ).pOnly(left: 10),
                0.5.h.heightBox,
                SizedBox(
                  height: 16.h,
                  width: 100.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Column(children: [
                              Image.asset(
                                'assets/images/nzvsafg.png',
                                fit: BoxFit.contain,
                                height: 100,
                                width: 100,
                              ),
                              0.5.h.heightBox,
                              commonText(
                                data: "Test Match",
                                alignment: TextAlign.center,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: primaryColors,
                              ),
                            ]),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

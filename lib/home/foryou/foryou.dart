import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kisma_livescore/commonwidget.dart';
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

  bool? isTrue;
  List<bool> isTrueList = [false, false];

  void initState() {
    // initialize controller
    _controller = ExpandedTileController(isExpanded: true);

    isTrue = _controller.isExpanded;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              2.h.heightBox,
              ExpandedTile(
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  // size: 40,
                  color: Color(0xff96A0B7),
                ).rotate90(),
                trailingRotation: 180,
                theme: const ExpandedTileThemeData(
                  headerColor: bgColor,
                  headerSplashColor: transparent,
                  contentBackgroundColor: bgColor,
                ),
                controller: _controller,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isTrue!
                            ? Image.asset(
                                "assets/images/doticon.png",
                                height: 25,
                                width: 25,
                              )
                            : SizedBox(),
                        2.w.widthBox,
                        Flexible(
                          flex: 20,
                          child: commonText(
                              data: "International T20 Matches",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
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
                      log(_controller.isExpanded.toString());
                      return GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const LiveMatchDetails(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          clipBehavior: Clip.hardEdge,
                          // margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: disableColors),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignmen,
                              children: [
                                Container(
                                  // height: 21.4.h,
                                  // width: 3.w,
                                  decoration: BoxDecoration(
                                      color: neonColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(7),
                                          topLeft: Radius.circular(7))),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            data: "International T20 Matches",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: disableColors,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Image.asset(
                                              "assets/images/notification.png",
                                              height: 15,
                                              width: 15,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              "assets/images/team2.png",
                                              scale: 4,
                                            ),
                                            Image.asset(
                                              "assets/images/team1.png",
                                              scale: 4,
                                            )
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0.0, left: 8.0, right: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            commonText(
                                              data: "Zimbabwe",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: teamColor,
                                            ),
                                            commonText(
                                              data: "* Live",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
                                            commonText(
                                              data: "Bangladesh",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: teamColor,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 8.0, right: 8.0),
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
                                                      BorderRadius.circular(
                                                          30)),
                                              child: commonText(
                                                data: "146/2",
                                                fontSize: 14,
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                color: black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                onTap: () {
                  if (_controller.isExpanded == true) {
                    setState(() {
                      isTrue = _controller.isExpanded;
                    });
                  } else {
                    setState(() {
                      isTrue = false;
                    });
                  }
                  debugPrint("tapped!!");
                },
                onLongTap: () {
                  debugPrint("long tapped!!");
                },
              ),
              ExpandedTileList.builder(
                itemCount: 2,
                maxOpened: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                reverse: true,
                itemBuilder: (context, index, controller) {
                  return ExpandedTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      // size: 40,
                      color: Color(0xff96A0B7),
                    ).rotate90(),
                    trailingRotation: 180,
                    theme: const ExpandedTileThemeData(
                      headerColor: bgColor,
                      headerSplashColor: transparent,
                      contentBackgroundColor: bgColor,
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
                            index == 1
                                ? isTrueList.first
                                    ? Image.asset(
                                        "assets/images/doticon.png",
                                        height: 25,
                                        width: 25,
                                      )
                                    : SizedBox()
                                : isTrueList.last
                                    ? Image.asset(
                                        "assets/images/doticon.png",
                                        height: 25,
                                        width: 25,
                                      )
                                    : SizedBox(),
                            2.w.widthBox,
                            commonText(
                              data: index == 1
                                  ? "The Hundred"
                                  : "The Hundred - Womens ",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: white,
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
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
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  // PersistentNavBarNavigator.pushNewScreen(
                                  //   context,
                                  //   screen: const ForYouMatchDetails(),
                                  //   withNavBar:
                                  //       true, // OPTIONAL VALUE. True by default.
                                  //   pageTransitionAnimation:
                                  //       PageTransitionAnimation.cupertino,
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  // margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: disableColors),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              data: "International T20 Matches",
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
                                                scale: 4,
                                              ),
                                              Image.asset(
                                                "assets/images/team1.png",
                                                scale: 4,
                                              )
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, left: 8.0, right: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonText(
                                                data: "Zimbabwe",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                color: teamColor,
                                              ),
                                              commonText(
                                                data: "* Live",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                color: black,
                                              ),
                                              commonText(
                                                data: "Bangladesh",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                color: teamColor,
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
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
                                                      BorderRadius.circular(
                                                          30)),
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
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  // PersistentNavBarNavigator.pushNewScreen(
                                  //   context,
                                  //   screen: const ForYouMatchDetails(),
                                  //   withNavBar:
                                  //       true, // OPTIONAL VALUE. True by default.
                                  //   pageTransitionAnimation:
                                  //       PageTransitionAnimation.cupertino,
                                  // );
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          color: Colors.grey.withOpacity(0.4),
                                          border:
                                              Border.all(color: disableColors),
                                          borderRadius:
                                              BorderRadius.circular(7)),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      "International T20 Matches",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        alignment:
                                                            TextAlign.center,
                                                        data:
                                                            "Starting \n in 26’",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                  top: 0.0,
                                                  left: 8.0,
                                                  right: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  commonText(
                                                    data: "Zimbabwe",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.grey
                                                        .withOpacity(0.6),
                                                  ),
                                                  commonText(
                                                    data: "Bangladesh",
                                                    fontSize: 14,
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
                      log(index.toString());
                      log(controller.isExpanded.toString());
                      if (index == 1) {
                        if (controller.isExpanded) {
                          setState(() {
                            isTrueList.first = true;
                          });
                        } else {
                          setState(() {
                            isTrueList.first = false;
                          });
                        }
                      } else {
                        setState(() {
                          isTrueList.first = false;
                        });
                      }
                      log(isTrueList.first.toString() + "this is is true");

                      if (index == 0) {
                        if (controller.isExpanded) {
                          setState(() {
                            isTrueList.last = true;
                          });
                        } else {
                          setState(() {
                            isTrueList.last = false;
                          });
                        }
                      } else {
                        setState(() {
                          isTrueList.last = false;
                        });
                      }
                      log(isTrueList.last.toString() + "this is is true last");
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("looooooooooong tapped!!");
                    },
                  );
                },
              ),
              Container(
                color: white,
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
                                    'assets/images/afgvsnzw.png',
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
                    )
                  ],
                ),
              ).pOnly(left: 10),
            ],
          ),
        ));
  }
}

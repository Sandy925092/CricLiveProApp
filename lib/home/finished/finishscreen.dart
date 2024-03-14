import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/foryou/foryoumatchdetails.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({Key? key}) : super(key: key);

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
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
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: disableColors),
                              borderRadius: BorderRadius.circular(7)),
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
                                    data: "International T20 Matches",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: disableColors,
                                  ),
                                  Image.asset(
                                    "assets/images/notification.png",
                                    height: 15,
                                    width: 15,
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/team2.png",
                                    scale: 4,
                                  ),
                                  commonText(
                                    data: "ZIM Won",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black,
                                  ),
                                  Image.asset(
                                    "assets/images/team1.png",
                                    scale: 4,
                                  )
                                ],
                              ),

                              Row(
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
                                    data: "Bangladesh",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: teamColor,
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: commonText(
                                      data: "146/2",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins",
                                      color: black,
                                    ),
                                  ),
                                  // commonText(
                                  //   data: "39.2/45 ov",
                                  //   fontSize: 12,
                                  //   fontWeight: FontWeight.w300,
                                  //   fontFamily: "Poppins",
                                  //   color: overColor,
                                  // ),
                                  commonText(
                                    data: "120/8",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black,
                                  ),
                                ],
                              ),
                            ],
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
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: disableColors),
                                      borderRadius: BorderRadius.circular(7)),
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
                                          Image.asset(
                                            "assets/images/notification.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/images/team2.png",
                                            scale: 4,
                                          ),
                                          commonText(
                                            data: "ZIM Won",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: black,
                                          ),
                                          Image.asset(
                                            "assets/images/team1.png",
                                            scale: 4,
                                          )
                                        ],
                                      ),

                                      Row(
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
                                            data: "Bangladesh",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: teamColor,
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: commonText(
                                              data: "146/2",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
                                          ),
                                          // commonText(
                                          //   data: "39.2/45 ov",
                                          //   fontSize: 12,
                                          //   fontWeight: FontWeight.w300,
                                          //   fontFamily: "Poppins",
                                          //   color: overColor,
                                          // ),
                                          commonText(
                                            data: "120/8",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: black,
                                          ),
                                        ],
                                      ),
                                    ],
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
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: disableColors),
                                      borderRadius: BorderRadius.circular(7)),
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
                                          Image.asset(
                                            "assets/images/notification.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/images/team2.png",
                                            scale: 4,
                                          ),
                                          commonText(
                                            data: "ZIM Won",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: black,
                                          ),
                                          Image.asset(
                                            "assets/images/team1.png",
                                            scale: 4,
                                          )
                                        ],
                                      ),

                                      Row(
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
                                            data: "Bangladesh",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: teamColor,
                                          ),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 18.0),
                                            child: commonText(
                                              data: "146/2",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
                                          ),
                                          // commonText(
                                          //   data: "39.2/45 ov",
                                          //   fontSize: 12,
                                          //   fontWeight: FontWeight.w300,
                                          //   fontFamily: "Poppins",
                                          //   color: overColor,
                                          // ),
                                          commonText(
                                            data: "120/8",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: black,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
            ],
          ),
        ));
  }
}

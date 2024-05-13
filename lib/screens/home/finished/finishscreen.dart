import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
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
  ExpandedTileController _controller2 =
      ExpandedTileController(isExpanded: false);
  ExpandedTileController controller3 =
      ExpandedTileController(isExpanded: false);
  bool isTrue2 = false;
  bool isTrue3 = false;
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
                contentseparator: 3.0,
                trailingRotation: 180,
                theme: const ExpandedTileThemeData(
                  headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                        _controller.isExpanded
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
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/team2.png",
                                        scale: 4,
                                      ),
                                      3.w.widthBox,
                                      commonText(
                                        data: "Zimbabwe",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: teamColor,
                                      ),
                                    ],
                                  ),
                                  commonText(
                                    data: "ZIM Won",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/team1.png",
                                        scale: 4,
                                      ),
                                      3.w.widthBox,
                                      commonText(
                                        data: "Bangladesh",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: teamColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              2.h.heightBox,

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
              2.h.heightBox,
              ExpandedTile(
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  // size: 40,
                  color: Color(0xff96A0B7),
                ).rotate90(),
                contentseparator: 3.0,
                trailingRotation: 180,
                theme: const ExpandedTileThemeData(
                  headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  headerColor: bgColor,
                  headerSplashColor: transparent,
                  contentBackgroundColor: bgColor,
                ),
                controller: _controller2,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isTrue2
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
                              data: "The Hundred",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
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
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/team2.png",
                                        scale: 4,
                                      ),
                                      3.w.widthBox,
                                      commonText(
                                        data: "Zimbabwe",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: teamColor,
                                      ),
                                    ],
                                  ),
                                  commonText(
                                    data: "ZIM Won",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/team1.png",
                                        scale: 4,
                                      ),
                                      3.w.widthBox,
                                      commonText(
                                        data: "Bangladesh",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: teamColor,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              2.h.heightBox,

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
                  if (_controller2.isExpanded == true) {
                    setState(() {
                      isTrue2 = _controller2.isExpanded;
                    });
                  } else {
                    setState(() {
                      isTrue2 = false;
                    });
                  }
                  debugPrint("tapped!!");
                },
                onLongTap: () {
                  debugPrint("long tapped!!");
                },
              ),
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
                    headerPadding: EdgeInsets.symmetric(horizontal: 10),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  controller: controller3,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isTrue3
                              ? Image.asset(
                                  "assets/images/doticon.png",
                                  height: 25,
                                  width: 25,
                                )
                              : SizedBox(),
                          2.w.widthBox,
                          commonText(
                            data: "The Hundred - Womens ",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: white,
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
                  content: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {},
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
                                    color: Colors.white.withOpacity(0.2),
                                    border: Border.all(color: disableColors),
                                    borderRadius: BorderRadius.circular(7)),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      0.5.h.heightBox,
                                      commonText(
                                        data: "International T20 Matches",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: Colors.grey.withOpacity(0.3),
                                      ).centered(),
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            ),
                                            commonText(
                                              data: "Bangladesh",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  onTap: () {
                    if (controller3.isExpanded == true) {
                      setState(() {
                        isTrue3 = controller3.isExpanded;
                      });
                    } else {
                      setState(() {
                        isTrue3 = false;
                      });
                    }
                    debugPrint("tapped!!");
                  },
                  onLongTap: () {
                    debugPrint("long tapped!!");
                  }),
              3.h.heightBox
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({Key? key}) : super(key: key);

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
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
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: black,
                        ),
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
                content: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              margin: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Color(0xffF6F6F8),
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
                                            data: "Zim won",
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
                                              data: "195/2",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
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
                    commonText(
                      data: "All Matches",
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors.withOpacity(0.5),
                    ),
                  ],
                ),
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

                            },
                            child: Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  color: Color(0xffF6F6F8),
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
                                            data: "Zim won",
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
                                              data: "195/2",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
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
                        })
                        :  ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              margin: EdgeInsets.all(0),
                              decoration: BoxDecoration( color: Color(0xffF6F6F8),
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
                                            data: "Zim Won",
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
                                              data: "195/2",
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              color: black,
                                            ),
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

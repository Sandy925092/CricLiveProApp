import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/likedMatch.dart';
import 'package:kisma_livescore/screens/home/live/live_dashboard.dart';
import 'package:kisma_livescore/screens/home/live/live_details_tab.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants.dart';
import '../../../cubit/livescore_cubit.dart';
import '../../../utils/custom_widgets.dart';
import '../../../utils/shared_preference.dart';

class ForYou extends StatefulWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
  late ExpandedTileController _controller;
  ExpandedTileController _controller2 =
      ExpandedTileController(isExpanded: false);
  ExpandedTileController controller3 =
      ExpandedTileController(isExpanded: false);
  bool isTrue2 = false;
  bool isTrue3 = false;
  int selectedIndex = -1;
  int selectedSeriesIndex = -1;

  List<LikedMatchData> likedMatch = [];

  bool? isTrue;
  List<bool> isTrueList = [false, false];
  String token = "";

  void initState() {
    // initialize controller

    getToken();

    isInternetConnected().then((value) async {
      if (value == true) {
        await BlocProvider.of<LiveScoreCubit>(context).getLikedMatch(token);
      } else {
        showToast(context: context, message: notConnected);
      }
    });
    _controller = ExpandedTileController(isExpanded: true);

    isTrue = _controller.isExpanded;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
          listener: (context, state) {
            if (state.status == LiveScoreStatus.getLikedMatchSuccess) {
              LikedMatchResponse likedMatchResponse =
                  state.responseData?.response as LikedMatchResponse;

              print("Success");

              if (likedMatchResponse.data != 0) {
                likedMatch.addAll(likedMatchResponse.data ?? []);
              }
            }

            if (state.status == LiveScoreStatus.unLikematchSuccess) {
              setState(() {
                if (likedMatch[selectedSeriesIndex].likedFixtures?.length ==
                    1) {
                  likedMatch.removeAt(selectedSeriesIndex);
                } else {
                  likedMatch[selectedSeriesIndex]
                      .likedFixtures
                      ?.removeAt(selectedIndex);
                }
              });

              showToast(
                  context: context, message: "Match removed from wishlist");
            }

            if (state.status == LiveScoreStatus.getLikedMatchError) {
              print("in error");
              showToast(context: context, message: state.error.toString());
            }
          },
          builder: (context, state) {
            if (state.status == LiveScoreStatus.getLikedMatchLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.status == LiveScoreStatus.getLikedMatchError) {
              int statusCode = state.errorData?.code ?? 0;
              String? error = state.errorData?.message ?? state.error;
              print('error:$error');
              return RefreshIndicator(
                onRefresh: _refreshPage,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 14, right: 14, top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //  Image.asset('assets/images/error.png', height: 45, width: 45),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: statusCode == 401
                                ? Center(
                                    child: mediumText14(context, error ?? '',
                                        //'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        textColor: const Color(0xffFFFFFF)),
                                  )
                                : mediumText14(
                                    // context, '$error\n\nClick to refresh.',
                                    context,
                                    "${"No data found"}\n \n Click to refresh",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xffFFFFFF)),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 35,
                            ),
                            onPressed: () {
                              _refreshPage();
                              // Handle refresh action here
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  2.h.heightBox,
                  likedMatch.length != 0
                      ? ExpandedTileList.builder(
                          itemCount: likedMatch.length,
                          shrinkWrap: true,
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          itemBuilder: (context, index, con) {
                            return ExpandedTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Color(0xff96A0B7),
                              ).rotate90(),
                              contentseparator: 3.0,
                              trailingRotation: 180,
                              theme: const ExpandedTileThemeData(
                                headerPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
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
                                            data:
                                                likedMatch[index].seriesName ??
                                                    "",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: white,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: Divider(
                                      thickness: 1.0,
                                      color: buttonColors,
                                    ),
                                  ),
                                ],
                              ),
                              content: likedMatch[index]
                                          .likedFixtures
                                          ?.length ==
                                      0
                                  ? Center(
                                      child: mediumText14(
                                          context, 'No match found',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                          textColor: const Color(0xffFFFFFF)),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: likedMatch[index]
                                              .likedFixtures
                                              ?.length ??
                                          0,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              2.h.heightBox,
                                              Container(
                                                margin: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                        color: disableColors),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      0.5.h.heightBox,
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          // commonText(
                                                          //   data: upcomingSeriesResponse
                                                          //           .data?[index]
                                                          //           .seriesName ??
                                                          //       "",
                                                          //   fontSize: 14,
                                                          //   fontWeight:
                                                          //       FontWeight.w400,
                                                          //   fontFamily: "Poppins",
                                                          //   color: Colors.grey
                                                          //       .withOpacity(0.9),
                                                          // ).centered(),

                                                       state.status==LiveScoreStatus.unLikematchLoading && selectedIndex==i?
                                                       SizedBox(
                                                           height: 20,
                                                           width: 20,
                                                           child: CircularProgressIndicator(color:
                                                           Colors.blue,)):   GestureDetector(
                                                              onTap: () {
                                                                isInternetConnected()
                                                                    .then(
                                                                        (value) {
                                                                  if (value ==
                                                                      true) {
                                                                    selectedSeriesIndex =
                                                                        index;
                                                                    selectedIndex =
                                                                        i;

                                                                    BlocProvider.of<LiveScoreCubit>(context).unLikeMatch(
                                                                        token,
                                                                        likedMatch[index]
                                                                            .likedFixtures![i]
                                                                            .fixtureId
                                                                            .toString());
                                                                  } else {
                                                                    showToast(
                                                                        context:
                                                                            context,
                                                                        message:
                                                                            notConnected);
                                                                  }
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          SizedBox(
                                                            width: 10,
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Flexible(
                                                            //   child: SizedBox(
                                                            //     width: 25.w,
                                                            //     child:
                                                            //         commonText(
                                                            //       data: upcomingSeriesResponse
                                                            //               .data?[
                                                            //                   index]
                                                            //               .fixtures?[
                                                            //                   i]
                                                            //               .homeTeam
                                                            //               ?.name ??
                                                            //           "N/A",
                                                            //       fontSize: 14,
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w400,
                                                            //       fontFamily:
                                                            //           "Poppins",
                                                            //       color: Colors
                                                            //           .grey
                                                            //           .withOpacity(
                                                            //               0.9),
                                                            //     ),
                                                            //   ),
                                                            // ),

                                                            Flexible(
                                                              child: SizedBox(
                                                                width: 25.w,
                                                                child:
                                                                    commonText(
                                                                  data: likedMatch[
                                                                          index]
                                                                      .likedFixtures![
                                                                          i]
                                                                      .teamAName
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.9),
                                                                ),
                                                              ),
                                                            ),

                                                            likedMatch[index]
                                                                        .likedFixtures![
                                                                            i]
                                                                        .matchStatus ==
                                                                    "Upcoming"
                                                                ? Container(
                                                                    width: 20.w,
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
                                                                        top: 3,
                                                                        bottom:
                                                                            3),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                20.0)),
                                                                        color:
                                                                            buttonColors),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          commonText(
                                                                        alignment:
                                                                            TextAlign.center,
                                                                        data:
                                                                            "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(likedMatch[index].likedFixtures?[i].matchDate?.toString() ?? "2025-04-04T10:00:00"))}",
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color:
                                                                            black,
                                                                      ),
                                                                    ),
                                                                  ).pOnly(
                                                                    left: 32,
                                                                    right: 32)
                                                                : commonText(
                                                                    data: likedMatch[
                                                                            index]
                                                                        .likedFixtures![
                                                                            i]
                                                                        .matchStatus
                                                                        .toString(),
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.9),
                                                                  ),

                                                            Flexible(
                                                              child: SizedBox(
                                                                width: 30.w,
                                                                child:
                                                                    commonText(
                                                                  data: likedMatch[
                                                                          index]
                                                                      .likedFixtures![
                                                                          i]
                                                                      .teamBName
                                                                      .toString(),
                                                                  fontSize: 14,
                                                                  maxLines: 2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  alignment: TextAlign.center,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.9),
                                                                ),
                                                              ),
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
                            );
                          })
                      : SizedBox(
                    height: MediaQuery.of(context).size.height*0.7,
                        child: Center(
                            child: mediumText14(context, 'No Liked Match Yet',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: const Color(0xffFFFFFF)),
                          ),
                      ),
                  2.h.heightBox,
                  // ExpandedTile(
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios_outlined,
                  //     // size: 40,
                  //     color: Color(0xff96A0B7),
                  //   ).rotate90(),
                  //   contentseparator: 3.0,
                  //   trailingRotation: 180,
                  //   theme: const ExpandedTileThemeData(
                  //     headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  //     contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     headerColor: bgColor,
                  //     headerSplashColor: transparent,
                  //     contentBackgroundColor: bgColor,
                  //   ),
                  //   controller: _controller2,
                  //   title: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           isTrue2!
                  //               ? Image.asset(
                  //                   "assets/images/doticon.png",
                  //                   height: 25,
                  //                   width: 25,
                  //                 )
                  //               : SizedBox(),
                  //           2.w.widthBox,
                  //           Flexible(
                  //             flex: 20,
                  //             child: commonText(
                  //                 data: "The Hundred",
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.w700,
                  //                 fontFamily: "Poppins",
                  //                 color: white,
                  //                 maxLines: 1,
                  //                 overflow: TextOverflow.ellipsis),
                  //           ),
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding:
                  //             const EdgeInsets.only(left: 12.0, right: 12.0),
                  //         child: Divider(
                  //           thickness: 1.0,
                  //           color: buttonColors,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   content: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: 1,
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemBuilder: (context, index) {
                  //         return GestureDetector(
                  //           onTap: () {
                  //             PersistentNavBarNavigator.pushNewScreen(
                  //               context,
                  //               screen: const LiveDashboard(),
                  //               withNavBar:
                  //                   true, // OPTIONAL VALUE. True by default.
                  //               pageTransitionAnimation:
                  //                   PageTransitionAnimation.cupertino,
                  //             );
                  //           },
                  //           child: Container(
                  //             clipBehavior: Clip.hardEdge,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 border: Border.all(color: disableColors),
                  //                 borderRadius: BorderRadius.circular(7)),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(0),
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     height: 14.h,
                  //                     width: 2.w,
                  //                     decoration: BoxDecoration(
                  //                         color: neonColor,
                  //                         borderRadius: BorderRadius.only(
                  //                             bottomLeft: Radius.circular(7),
                  //                             topLeft: Radius.circular(7))),
                  //                   ),
                  //                   Flexible(
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         1.h.heightBox,
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Row(
                  //                                 children: [
                  //                                   Image.asset(
                  //                                     "assets/images/team2.png",
                  //                                     scale: 4,
                  //                                   ),
                  //                                   3.w.widthBox,
                  //                                   commonText(
                  //                                     data: "Zimbabwe",
                  //                                     fontSize: 14,
                  //                                     fontWeight:
                  //                                         FontWeight.w400,
                  //                                     fontFamily: "Poppins",
                  //                                     color: teamColor,
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                               commonText(
                  //                                 data: "• Live",
                  //                                 fontSize: 12,
                  //                                 fontWeight: FontWeight.w700,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.red,
                  //                               ),
                  //                               Row(
                  //                                 children: [
                  //                                   Image.asset(
                  //                                     "assets/images/team1.png",
                  //                                     scale: 4,
                  //                                   ),
                  //                                   3.w.widthBox,
                  //                                   commonText(
                  //                                     data: "Bangladesh",
                  //                                     fontSize: 14,
                  //                                     fontWeight:
                  //                                         FontWeight.w400,
                  //                                     fontFamily: "Poppins",
                  //                                     color: teamColor,
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 10.0,
                  //                               left: 20.0,
                  //                               right: 8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     left: 12,
                  //                                     top: 5,
                  //                                     bottom: 5,
                  //                                     right: 12),
                  //                                 decoration: BoxDecoration(
                  //                                     color: buttonColors,
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             30)),
                  //                                 child: commonText(
                  //                                   data: "146/2",
                  //                                   fontSize: 14,
                  //                                   fontWeight: FontWeight.w700,
                  //                                   fontFamily: "Poppins",
                  //                                   color: black,
                  //                                 ),
                  //                               ),
                  //                               commonText(
                  //                                 data: "39.2/45 ov",
                  //                                 fontSize: 12,
                  //                                 fontWeight: FontWeight.w300,
                  //                                 fontFamily: "Poppins",
                  //                                 color: overColor,
                  //                               ),
                  //                               Padding(
                  //                                 padding:
                  //                                     const EdgeInsets.only(
                  //                                         right: 18.0),
                  //                                 child: commonText(
                  //                                   data: "175",
                  //                                   fontSize: 15,
                  //                                   fontWeight: FontWeight.w700,
                  //                                   fontFamily: "Poppins",
                  //                                   color: black,
                  //                                 ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         2.h.heightBox
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       }),
                  //   onTap: () {
                  //     if (_controller2.isExpanded == true) {
                  //       setState(() {
                  //         isTrue2 = _controller2.isExpanded;
                  //       });
                  //     } else {
                  //       setState(() {
                  //         isTrue2 = false;
                  //       });
                  //     }
                  //     debugPrint("tapped!!");
                  //   },
                  //   onLongTap: () {
                  //     debugPrint("long tapped!!");
                  //   },
                  // ),
                  // 2.h.heightBox,
                  // ExpandedTile(
                  //     trailing: Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       // size: 40,
                  //       color: Color(0xff96A0B7),
                  //     ).rotate90(),
                  //     trailingRotation: 180,
                  //     theme: const ExpandedTileThemeData(
                  //       headerColor: bgColor,
                  //       headerSplashColor: transparent,
                  //       contentBackgroundColor: bgColor,
                  //       headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     ),
                  //     controller: controller3,
                  //     title: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             isTrue3
                  //                 ? Image.asset(
                  //                     "assets/images/doticon.png",
                  //                     height: 25,
                  //                     width: 25,
                  //                   )
                  //                 : SizedBox(),
                  //             2.w.widthBox,
                  //             commonText(
                  //               data: "The Hundred - Womens ",
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: "Poppins",
                  //               color: white,
                  //             ),
                  //           ],
                  //         ),
                  //         Padding(
                  //           padding:
                  //               const EdgeInsets.only(left: 12.0, right: 12.0),
                  //           child: Divider(
                  //             thickness: 1.0,
                  //             color: buttonColors,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     content: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 1,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, i) {
                  //           return GestureDetector(
                  //             onTap: () {},
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     commonText(
                  //                       data: "Coming soon",
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w400,
                  //                       color: Colors.grey.withOpacity(0.6),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 2.h.heightBox,
                  //                 Container(
                  //                   margin: EdgeInsets.all(0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.2),
                  //                       border:
                  //                           Border.all(color: disableColors),
                  //                       borderRadius: BorderRadius.circular(7)),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(1.0),
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         0.5.h.heightBox,
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             commonText(
                  //                               data: "",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w500,
                  //                               fontFamily: "Poppins",
                  //                               color: matchTitleColor,
                  //                             ),
                  //                             commonText(
                  //                               data:
                  //                                   "International T20 Matches",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               fontFamily: "Poppins",
                  //                               color: Colors.grey
                  //                                   .withOpacity(0.3),
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.only(
                  //                                   right: 4.0, top: 4.0),
                  //                               child: Image.asset(
                  //                                 "assets/images/notification.png",
                  //                                 height: 15,
                  //                                 width: 15,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(12.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               Image.asset(
                  //                                 "assets/images/team2.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               ),
                  //                               Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     left: 10,
                  //                                     right: 10,
                  //                                     top: 3,
                  //                                     bottom: 3),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius:
                  //                                         BorderRadius.all(
                  //                                             Radius.circular(
                  //                                                 20.0)),
                  //                                     color: buttonColors),
                  //                                 child: Center(
                  //                                   child: commonText(
                  //                                     alignment:
                  //                                         TextAlign.center,
                  //                                     data:
                  //                                         "Starting \n in 26’",
                  //                                     fontSize: 10,
                  //                                     fontWeight:
                  //                                         FontWeight.w700,
                  //                                     fontFamily: "Poppins",
                  //                                     color: black,
                  //                                   ),
                  //                                 ),
                  //                               ).pOnly(left: 32, right: 32),
                  //                               Image.asset(
                  //                                 "assets/images/team1.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 0.0,
                  //                               left: 8.0,
                  //                               right: 8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               commonText(
                  //                                 data: "Zimbabwe",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey
                  //                                     .withOpacity(0.6),
                  //                               ),
                  //                               commonText(
                  //                                 data: "Bangladesh",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey
                  //                                     .withOpacity(0.6),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //     onTap: () {
                  //       if (controller3.isExpanded == true) {
                  //         setState(() {
                  //           isTrue3 = controller3.isExpanded;
                  //         });
                  //       } else {
                  //         setState(() {
                  //           isTrue3 = false;
                  //         });
                  //       }
                  //       debugPrint("tapped!!");
                  //     },
                  //     onLongTap: () {
                  //       debugPrint("long tapped!!");
                  //     }),
                  // 2.h.heightBox,
                  // Container(
                  //   color: white,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       0.5.h.heightBox,
                  //       commonText(
                  //         data: "Featured",
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w500,
                  //         fontFamily: "Poppins",
                  //         color: primaryColors,
                  //       ).pOnly(left: 10),
                  //       0.5.h.heightBox,
                  //       SizedBox(
                  //         height: 16.h,
                  //         width: 100.w,
                  //         child: ListView.builder(
                  //             shrinkWrap: true,
                  //             itemCount: 6,
                  //             scrollDirection: Axis.horizontal,
                  //             itemBuilder: (context, index) {
                  //               return Row(
                  //                 children: [
                  //                   Column(children: [
                  //                     Image.asset(
                  //                       'assets/images/afgvsnzw.png',
                  //                       fit: BoxFit.contain,
                  //                       height: 100,
                  //                       width: 100,
                  //                     ),
                  //                     0.5.h.heightBox,
                  //                     commonText(
                  //                       data: "Test Match",
                  //                       alignment: TextAlign.center,
                  //                       fontSize: 10,
                  //                       fontWeight: FontWeight.w700,
                  //                       fontFamily: "Poppins",
                  //                       color: primaryColors,
                  //                     ),
                  //                   ]),
                  //                 ],
                  //               );
                  //             }),
                  //       )
                  //     ],
                  //   ),
                  // ).pOnly(left: 10),
                ],
              ),
            );
          },
        ));
  }

  void getToken() {
    token = PreferenceManager.getStringValue(key: "token") ?? "";
    print("token");
    print(token);
  }

  Future<void> _refreshPage() async {
    isInternetConnected().then((value) async {
      if (value == true) {
        await BlocProvider.of<LiveScoreCubit>(context).getLikedMatch(token);
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }
}

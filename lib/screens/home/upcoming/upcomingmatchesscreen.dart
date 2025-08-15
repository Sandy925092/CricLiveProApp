import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/upcoming_series_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants.dart';

class UpcomingMatchScreen extends StatefulWidget {
  const UpcomingMatchScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingMatchScreen> createState() => _UpcomingMatchScreenState();
}

class _UpcomingMatchScreenState extends State<UpcomingMatchScreen> {
  UpcomingSeriesResponse upcomingSeriesResponse = UpcomingSeriesResponse();

  late ExpandedTileController _controller;
  int? expandedIndex;
  bool? isTrue;
  List<bool> isTrueList = [false, false];
  String token = "";
  int pageNo = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  int selectedIndex = -1;
  late final PagingController<int, UpComingContent> _pagingController;

  List<UpComingContent> seriesName = [];
  List<Fixtures> fixtures = [];

  Future<void> _refreshPage() async {
    _fetchPage(pageNo);
  }

  @override
  void initState() {
    getToken();

    print("token");
    print(token);

    _pagingController = PagingController(
      firstPageKey: 0,
    );

    _fetchPage(pageNo);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    // initialize controller
    _controller = ExpandedTileController(isExpanded: true);
    isTrue = _controller.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
            listener: (context, state) {
          print("${state.status} this is status");
          if (state.status == LiveScoreStatus.upcomingSeriesSuccess) {
            upcomingSeriesResponse =
                state.responseData?.response as UpcomingSeriesResponse;
            Loader.hide();
            if (upcomingSeriesResponse.data?.content?.length != 0) {
              // seriesName.addAll(finishedSeriesResponse.data?.content ?? []);

              final newItems = upcomingSeriesResponse.data?.content ?? [];
              final isLastPage = upcomingSeriesResponse.data?.last ?? true;

              if (isLastPage) {
                _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey =
                    (upcomingSeriesResponse.data?.number ?? 0) + 1;
                pageNo = (upcomingSeriesResponse.data?.number ?? 0) + 1;
                _pagingController.appendPage(newItems, nextPageKey);
              }
              seriesName.addAll(newItems);

              print("seriesLength");
              print(seriesName.length);
            }
          }

          if (state.status == LiveScoreStatus.likematchSuccess) {
            setState(() {
              fixtures[selectedIndex].liked = true;
            });
            UiHelper.toastMessage("Match added to wishlist" ?? '');
            // showToast(context: context, message: "Match added to wishlist");
          }

          if (state.status == LiveScoreStatus.unLikematchSuccess) {
            setState(() {
              fixtures[selectedIndex].liked = false;
            });
            showToast(context: context, message: "Match removed from wishlist");
          }
          if (state.status == LiveScoreStatus.upcomingSeriesError ||
              state.status == LiveScoreStatus.likematchError ||
              state.status == LiveScoreStatus.unLikematchError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage(message);
          }

          // if (state.status == LiveScoreStatus.upcomingSeriesLoading) {
          //   Loader.show(context);
          // }
        }, builder: (context, state) {
          if (state.status == LiveScoreStatus.upcomingSeriesLoading &&
              pageNo == 0) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.upcomingSeriesError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: screenHeight * 0.5,
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
                            _fetchPage(pageNo);
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
          return RefreshIndicator(
            onRefresh: _refreshPage,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  2.h.heightBox,
                  upcomingSeriesResponse.data?.content?.length == null &&
                          upcomingSeriesResponse.data?.content?.length == 0
                      ? Center(
                          child: mediumText14(context, 'No Upcoming Series',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: const Color(0xffFFFFFF)),
                        )
                      : (upcomingSeriesResponse.data?.content?.isNotEmpty ??
                              false)
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: PagedListView<int, UpComingContent>(
                                  pagingController: _pagingController,
                                  builderDelegate: PagedChildBuilderDelegate<
                                      UpComingContent>(
                                    itemBuilder: (context, item, index) {
                                      final isExpanded = expandedIndex == index;
                                      return ExpansionTile(
                                        key: PageStorageKey(
                                            'expansion_tile_$index'),
                                        initiallyExpanded: isExpanded,
                                        trailing: Transform.rotate(
                                          angle: isExpanded
                                              ? 3.1
                                              : 0, // 90 degrees
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Color(0xff96A0B7),
                                          ).rotate90(),
                                        ),
                                        onExpansionChanged: (expanded) async {
                                          expandedIndex =
                                              expanded ? index : null;
                                          print(
                                              "Tapped index: $index, expanded: $expanded");
                                          fixtures.clear();

                                          fixtures.addAll(
                                              seriesName[index].fixtures ?? []);

                                          print(jsonEncode(fixtures));
                                          // await BlocProvider.of<LiveScoreCubit>(
                                          //     context)
                                          //     .getFinishMatch(
                                          //     pageNo.toString(),
                                          //     seriesName[index]
                                          //         .id2
                                          //         .toString());
                                          // });
                                          setState(() {});
                                        },
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/images/doticon.png",
                                                  height: 25,
                                                  width: 25,
                                                ),
                                                // _controller.isExpanded
                                                //     ? Image.asset(
                                                //   "assets/images/doticon.png",
                                                //   height: 25,
                                                //   width: 25,
                                                // )
                                                //     : SizedBox(),
                                                2.w.widthBox,
                                                Flexible(
                                                  flex: 20,
                                                  child: commonText(
                                                      data: seriesName[index]
                                                              .seriesName
                                                              .toString() ??
                                                          "",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                      color: white,
                                                      maxLines: 3,
                                                      overflow: TextOverflow
                                                          .ellipsis),
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
                                        children: [
                                          if (isExpanded)
                                            if (state.status ==
                                                LiveScoreStatus
                                                    .finishedMatchLoading)
                                              Center(
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            else if (seriesName.length == 0)
                                              Center(
                                                child: mediumText14(
                                                  context,
                                                  'No match found',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textAlign: TextAlign.center,
                                                  textColor: Colors.red,
                                                ),
                                              )
                                            else
                                              fixtures.length != 0
                                                  ? Column(
                                                      children: fixtures
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                        (entry) {
                                                          final index1 =
                                                              entry.key;
                                                          final items =
                                                              entry.value;

                                                          return GestureDetector(
                                                            onTap: () {
                                                              print(
                                                                  "Tapped fixture index: $index1");

                                                              // Example: Navigate or show toast
                                                              // if (items.fixtures == true) {
                                                              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              //     return FinishedMatchScorecardScreen(
                                                              //       matchId: items.fixtureId?.toString() ?? "",
                                                              //       winningTeam: items.winningTeamName?.toString() ?? "",
                                                              //     );
                                                              //   }));
                                                              // } else {
                                                              //   showToast(context: context, message: "Result not found");
                                                              // }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.2),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              disableColors),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              7)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        1.0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              10.0,
                                                                          top:
                                                                              5),
                                                                      child:
                                                                          Align(
                                                                        alignment:
                                                                            Alignment.centerRight,
                                                                        child: state.status == LiveScoreStatus.likematchLoading && selectedIndex == index1 ||
                                                                                state.status == LiveScoreStatus.unLikematchLoading && selectedIndex == index1
                                                                            ? SizedBox(
                                                                                height: 20,
                                                                                width: 20,
                                                                                child: CircularProgressIndicator(
                                                                                  color: Colors.blue,
                                                                                ))
                                                                            : GestureDetector(
                                                                                onTap: () {
                                                                                  if (items.liked == true) {
                                                                                    isInternetConnected().then((value) {
                                                                                      if (value == true) {
                                                                                        selectedIndex = index1;

                                                                                        BlocProvider.of<LiveScoreCubit>(context).unLikeMatch(token, items.fixtureId.toString() ?? "");
                                                                                      } else {
                                                                                        showToast(context: context, message: notConnected);
                                                                                      }
                                                                                    });
                                                                                  } else {
                                                                                    isInternetConnected().then((value) {
                                                                                      if (value == true) {
                                                                                        print("series id index");
                                                                                        print(index);
                                                                                        print(index1);
                                                                                        Map<String, dynamic> matchDetails = {
                                                                                          "seriesId": upcomingSeriesResponse.data?.content![index1].seriesId?.toString() ?? "",
                                                                                          "seriesName": upcomingSeriesResponse.data?.content![index1].seriesName?.toString() ?? "",
                                                                                          "fixtureId": items.fixtureId?.toString() ?? "",
                                                                                          "teamAName": items.homeTeam?.name?.toString() ?? "Team ${items.homeTeam?.id?.toString()}",
                                                                                          "teamBName": items.awayTeam?.name?.toString() ?? "Team ${items.awayTeam?.id?.toString()}",
                                                                                          "matchStatus": "Upcoming",
                                                                                          "matchDate": items.startTimes?.first.date?.toString() ?? "",
                                                                                        };

                                                                                        selectedIndex = index1;

                                                                                        print("matchDetails");
                                                                                        print(matchDetails);

                                                                                        BlocProvider.of<LiveScoreCubit>(context).likeMatch(token, matchDetails);
                                                                                      } else {
                                                                                        showToast(context: context, message: notConnected);
                                                                                      }
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: Icon(
                                                                                  items.liked == true ? Icons.favorite : Icons.favorite_outline_rounded,
                                                                                  color: items.liked == true ? Colors.red : Colors.grey,
                                                                                ),
                                                                              ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          12.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                SizedBox(
                                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                                              child: commonText(
                                                                                data: items.homeTeam?.name != null ? items.homeTeam?.name?.toString() ?? "Not available" : " Team ${items.homeTeam?.id.toString()}" ?? "",
                                                                                fontSize: 14,
                                                                                maxLines: 2,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: "Poppins",
                                                                                color: Colors.black,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                25.w,
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                              color: buttonColors,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: commonText(
                                                                                alignment: TextAlign.center,
                                                                                data: "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(items.startTimes?.first.date ?? "2025-04-04T10:00:00"))}",
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "Poppins",
                                                                                color: black,
                                                                              ),
                                                                            ),
                                                                          ).pOnly(
                                                                              left: 32,
                                                                              right: 32),
                                                                          Flexible(
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                                                  child: commonText(
                                                                                    data: items.awayTeam?.name != null ? items.awayTeam?.name?.toString() ?? "Not available" : " Team ${items.awayTeam?.id.toString()}" ?? "",
                                                                                    fontSize: 14,
                                                                                    maxLines: 2,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    fontFamily: "Poppins",
                                                                                    color: Colors.black,
                                                                                    overflow: TextOverflow.ellipsis,
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
                                                        },
                                                      ).toList(),
                                                    )
                                                  : Center(
                                                      child: mediumText14(
                                                        context,
                                                        'No match found',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        textAlign:
                                                            TextAlign.center,
                                                        textColor: Colors.white,
                                                      ),
                                                    )
                                        ],
                                      );
                                    },
                                  )),
                            )

                          // ExpandedTileList.builder(
                          //             itemCount: upcomingSeriesResponse
                          //                     .data?.content?.length ??
                          //                 0,
                          //             shrinkWrap: true,
                          //             // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          //             itemBuilder: (context, index, con) {
                          //               return ExpandedTile(
                          //                 trailing: Icon(
                          //                   Icons.arrow_forward_ios_outlined,
                          //                   color: Color(0xff96A0B7),
                          //                 ).rotate90(),
                          //                 contentseparator: 3.0,
                          //                 trailingRotation: 180,
                          //                 theme: const ExpandedTileThemeData(
                          //                   headerPadding: EdgeInsets.symmetric(
                          //                       horizontal: 10, vertical: 10),
                          //                   contentPadding:
                          //                       EdgeInsets.symmetric(horizontal: 20),
                          //                   headerColor: bgColor,
                          //                   headerSplashColor: transparent,
                          //                   contentBackgroundColor: bgColor,
                          //                 ),
                          //                 controller: _controller,
                          //                 title: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         _controller.isExpanded
                          //                             ? Image.asset(
                          //                                 "assets/images/doticon.png",
                          //                                 height: 25,
                          //                                 width: 25,
                          //                               )
                          //                             : SizedBox(),
                          //                         2.w.widthBox,
                          //                         Flexible(
                          //                           flex: 20,
                          //                           child: commonText(
                          //                               data: upcomingSeriesResponse
                          //                                       .data
                          //                                       ?.content?[index]
                          //                                       .seriesName ??
                          //                                   "",
                          //                               fontSize: 16,
                          //                               fontWeight: FontWeight.w700,
                          //                               fontFamily: "Poppins",
                          //                               color: white,
                          //                               maxLines: 3,
                          //                               overflow:
                          //                                   TextOverflow.ellipsis),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                     Padding(
                          //                       padding: const EdgeInsets.only(
                          //                           left: 12.0, right: 12.0),
                          //                       child: Divider(
                          //                         thickness: 1.0,
                          //                         color: buttonColors,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 content: upcomingSeriesResponse
                          //                             .data
                          //                             ?.content?[index]
                          //                             .fixtures
                          //                             ?.length ==
                          //                         0
                          //                     ? Center(
                          //                         child: mediumText14(
                          //                             context, 'No match found',
                          //                             fontSize: 16,
                          //                             fontWeight: FontWeight.w500,
                          //                             textAlign: TextAlign.center,
                          //                             textColor:
                          //                                 const Color(0xffFFFFFF)),
                          //                       )
                          //                     : ListView.builder(
                          //                         shrinkWrap: true,
                          //                         itemCount: upcomingSeriesResponse
                          //                                 .data
                          //                                 ?.content?[index]
                          //                                 .fixtures
                          //                                 ?.length ??
                          //                             0,
                          //                         physics:
                          //                             NeverScrollableScrollPhysics(),
                          //                         itemBuilder: (context, i) {
                          //                           return GestureDetector(
                          //                             onTap: () {},
                          //                             child: Column(
                          //                               children: [
                          //                                 2.h.heightBox,
                          //                                 Container(
                          //                                   margin: EdgeInsets.all(0),
                          //                                   decoration: BoxDecoration(
                          //                                       color: Colors.white
                          //                                           .withOpacity(0.2),
                          //                                       border: Border.all(
                          //                                           color:
                          //                                               disableColors),
                          //                                       borderRadius:
                          //                                           BorderRadius
                          //                                               .circular(7)),
                          //                                   child: Padding(
                          //                                     padding:
                          //                                         const EdgeInsets.all(
                          //                                             1.0),
                          //                                     child: Column(
                          //                                       crossAxisAlignment:
                          //                                           CrossAxisAlignment
                          //                                               .start,
                          //                                       children: [
                          //                                         0.5.h.heightBox,
                          //                                         Row(
                          //                                           mainAxisAlignment:
                          //                                               MainAxisAlignment
                          //                                                   .end,
                          //                                           children: [
                          //                                             // commonText(
                          //                                             //   data: upcomingSeriesResponse
                          //                                             //           .data?[index]
                          //                                             //           .seriesName ??
                          //                                             //       "",
                          //                                             //   fontSize: 14,
                          //                                             //   fontWeight:
                          //                                             //       FontWeight.w400,
                          //                                             //   fontFamily: "Poppins",
                          //                                             //   color: Colors.grey
                          //                                             //       .withOpacity(0.9),
                          //                                             // ).centered(),
                          //
                          //                                             GestureDetector(
                          //                                                 onTap: () {},
                          //                                                 child: Icon(Icons
                          //                                                     .favorite_border)),
                          //                                             SizedBox(
                          //                                               width: 10,
                          //                                             )
                          //                                           ],
                          //                                         ),
                          //                                         Padding(
                          //                                           padding:
                          //                                               const EdgeInsets
                          //                                                   .all(12.0),
                          //                                           child: Row(
                          //                                             mainAxisAlignment:
                          //                                                 MainAxisAlignment
                          //                                                     .spaceBetween,
                          //                                             children: [
                          //                                               // Flexible(
                          //                                               //   child: SizedBox(
                          //                                               //     width: 25.w,
                          //                                               //     child:
                          //                                               //         commonText(
                          //                                               //       data: upcomingSeriesResponse
                          //                                               //               .data?[
                          //                                               //                   index]
                          //                                               //               .fixtures?[
                          //                                               //                   i]
                          //                                               //               .homeTeam
                          //                                               //               ?.name ??
                          //                                               //           "N/A",
                          //                                               //       fontSize: 14,
                          //                                               //       fontWeight:
                          //                                               //           FontWeight
                          //                                               //               .w400,
                          //                                               //       fontFamily:
                          //                                               //           "Poppins",
                          //                                               //       color: Colors
                          //                                               //           .grey
                          //                                               //           .withOpacity(
                          //                                               //               0.9),
                          //                                               //     ),
                          //                                               //   ),
                          //                                               // ),
                          //
                          //                                               Flexible(
                          //                                                 child:
                          //                                                     SizedBox(
                          //                                                   width: 25.w,
                          //                                                   child:
                          //                                                       commonText(
                          //                                                     data: upcomingSeriesResponse.data?.content?[index].fixtures?[i].homeTeam?.name !=
                          //                                                             null
                          //                                                         ? upcomingSeriesResponse
                          //                                                             .data!
                          //                                                             .content![index]
                          //                                                             .fixtures![i]
                          //                                                             .homeTeam!
                          //                                                             .name!
                          //                                                         : upcomingSeriesResponse.data!.content![index].fixtures![i].homeTeam?.id?.toString() ?? "N/A",
                          //                                                     fontSize:
                          //                                                         14,
                          //                                                     fontWeight:
                          //                                                         FontWeight
                          //                                                             .w400,
                          //                                                     fontFamily:
                          //                                                         "Poppins",
                          //                                                     color: Colors
                          //                                                         .grey
                          //                                                         .withOpacity(
                          //                                                             0.9),
                          //                                                   ),
                          //                                                 ),
                          //                                               ),
                          //
                          //                                               Container(
                          //                                                 width: 25.w,
                          //                                                 padding: EdgeInsets
                          //                                                     .only(
                          //                                                         left:
                          //                                                             10,
                          //                                                         right:
                          //                                                             10,
                          //                                                         top:
                          //                                                             3,
                          //                                                         bottom:
                          //                                                             3),
                          //                                                 decoration: BoxDecoration(
                          //                                                     borderRadius:
                          //                                                         BorderRadius.all(Radius.circular(
                          //                                                             20.0)),
                          //                                                     color:
                          //                                                         buttonColors),
                          //                                                 child: Center(
                          //                                                   child:
                          //                                                       commonText(
                          //                                                     alignment:
                          //                                                         TextAlign
                          //                                                             .center,
                          //                                                     data:
                          //                                                         "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(upcomingSeriesResponse.data?.content![index].fixtures?[i].startTimes?.first.date ?? "2025-04-04T10:00:00"))}",
                          //                                                     fontSize:
                          //                                                         10,
                          //                                                     fontWeight:
                          //                                                         FontWeight
                          //                                                             .w700,
                          //                                                     fontFamily:
                          //                                                         "Poppins",
                          //                                                     color:
                          //                                                         black,
                          //                                                   ),
                          //                                                 ),
                          //                                               ).pOnly(
                          //                                                   left: 32,
                          //                                                   right: 32),
                          //                                               // Flexible(
                          //                                               //   child: SizedBox(
                          //                                               //     width: 25.w,
                          //                                               //     child:
                          //                                               //         commonText(
                          //                                               //       data: upcomingSeriesResponse
                          //                                               //               .data?[
                          //                                               //                   index]
                          //                                               //               .fixtures?[
                          //                                               //                   i]
                          //                                               //               .awayTeam
                          //                                               //               ?.name ??
                          //                                               //           "N/A",
                          //                                               //       fontSize: 14,
                          //                                               //       fontWeight:
                          //                                               //           FontWeight
                          //                                               //               .w400,
                          //                                               //       fontFamily:
                          //                                               //           "Poppins",
                          //                                               //       color: Colors
                          //                                               //           .grey
                          //                                               //           .withOpacity(
                          //                                               //               0.9),
                          //                                               //     ),
                          //                                               //   ),
                          //                                               // ),
                          //
                          //                                               Flexible(
                          //                                                 child:
                          //                                                     SizedBox(
                          //                                                   width: 25.w,
                          //                                                   child:
                          //                                                       commonText(
                          //                                                     data: upcomingSeriesResponse.data?.content?[index].fixtures?[i].awayTeam?.name !=
                          //                                                             null
                          //                                                         ? upcomingSeriesResponse
                          //                                                             .data!
                          //                                                             .content![index]
                          //                                                             .fixtures![i]
                          //                                                             .awayTeam!
                          //                                                             .name!
                          //                                                         : upcomingSeriesResponse.data!.content![index].fixtures![i].awayTeam?.id?.toString() ?? "N/A",
                          //                                                     fontSize:
                          //                                                         14,
                          //                                                     fontWeight:
                          //                                                         FontWeight
                          //                                                             .w400,
                          //                                                     fontFamily:
                          //                                                         "Poppins",
                          //                                                     color: Colors
                          //                                                         .grey
                          //                                                         .withOpacity(
                          //                                                             0.9),
                          //                                                   ),
                          //                                                 ),
                          //                                               ),
                          //                                             ],
                          //                                           ),
                          //                                         ),
                          //                                       ],
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           );
                          //                         }),
                          //                 onTap: () {
                          //                   if (_controller.isExpanded == true) {
                          //                     setState(() {
                          //                       isTrue = _controller.isExpanded;
                          //                     });
                          //                   } else {
                          //                     setState(() {
                          //                       isTrue = false;
                          //                     });
                          //                   }
                          //                   debugPrint("tapped!!");
                          //                 },
                          //                 onLongTap: () {
                          //                   debugPrint("long tapped!!");
                          //                 },
                          //               );
                          //             })

                          : Center(
                              child: mediumText14(
                                context,
                                'No Upcoming Series',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: const Color(0xffFFFFFF),
                              ),
                            ),
                ],
              ),
            ),
          );
        }));
  }

  void getToken() {
    token = PreferenceManager.getStringValue(key: "token") ?? "";
    print("token");
    print(token);
  }

  void _fetchPage(int pageKey) {
    try {
      isInternetConnected().then((value) async {
        if (value == true) {
          await BlocProvider.of<LiveScoreCubit>(context)
              .getUpcomingSeries(token, pageKey.toString());
        } else {
          showToast(context: context, message: notConnected);
        }
      });
    } catch (error) {
      _pagingController.error = error;
      debugPrint('Error loading page $pageKey: $error');
    }
  }
}

//

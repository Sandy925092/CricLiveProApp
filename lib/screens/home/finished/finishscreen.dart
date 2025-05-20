import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/finished_match.dart';
import 'package:kisma_livescore/responses/finishedserires.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../cubit/livescore_cubit.dart';
import '../../../utils/custom_widgets.dart';
import '../../../utils/ui_helper.dart';
import '../../series/FinishedMatchscorecard.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({Key? key}) : super(key: key);

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
  FinishedSeriesResponse finishedSeriesResponse = FinishedSeriesResponse();

  // FinishedMatchResponse  finishedSeriesResponse= FinishedMatchResponse();

  // late ExpandedTileController _controller;

  bool? isTrue;
  List<bool> isTrueList = [false, false];
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  List<SeriesName> seriesName = [];
  List<MatchData> matchData = [];
  int? expandedIndex;
  late final PagingController<int, SeriesName> _pagingController;

  Future<void> getFinished({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() {
        isLoadingMore = true;
      });
    }

    await BlocProvider.of<LiveScoreCubit>(context)
        .getFinishedSeries(pageNo.toString());
  }

  Future<void> _refreshPage() async {
    // await getFinished();
  }

  void fetchNextPage() async {
    pageNo++;
    // await getFinished(isLoadMore: true);
  }

  @override
  void initState() {
    super.initState();
    print("call inittstate");
    // _controller = ExpandedTileController(isExpanded: true);
    // isTrue = _controller.isExpanded;

    _pagingController = PagingController(
      firstPageKey: 0,
    );

    print("call inittstate1");

    _fetchPage(pageNo);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    print("call inittstate2");
  }

  Future<void> _fetchPage(int pageKey) async {
    print(pageKey.toString() + "this is page key");
    try {
      await BlocProvider.of<LiveScoreCubit>(context)
          .getFinishedSeries(pageKey.toString());

      // if (response.responseData != null) {
      //   final smileGalleryProResponse =
      //   response.responseData as SmileGalleryProResponse;
      //   final newItems = smileGalleryProResponse.smileDesignPro ?? [];
      //   final isLastPage = newItems.isEmpty;
      //
      //   if (isLastPage) {
      //     _pagingController.appendLastPage(newItems); // This was missing
      //     print('hereeee');
      //   } else {
      //     final nextPageKey = pageKey + 1;
      //     _pagingController.appendPage(newItems, nextPageKey);
      //   }
      // }
      // else {
      //   _pagingController.error = Exception(
      //       'Failed to load data: ${response.responseData.message ??
      //           "Unknown error"}');
      // }
    } catch (error) {
      _pagingController.error = error;
      debugPrint('Error loading page $pageKey: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
            listener: (context, state) {
          print(state.status.toString() + " this is status");
          if (state.status == LiveScoreStatus.finishedSeriesSuccess) {
            finishedSeriesResponse =
                state.responseData?.response as FinishedSeriesResponse;
            Loader.hide();

            if (finishedSeriesResponse.data?.content?.length != 0) {
              // seriesName.addAll(finishedSeriesResponse.data?.content ?? []);

              final newItems = finishedSeriesResponse.data?.content ?? [];
              final isLastPage = finishedSeriesResponse.data?.last ?? true;

              if (isLastPage) {
                _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey =
                    (finishedSeriesResponse.data?.number ?? 0) + 1;
                pageNo = (finishedSeriesResponse.data?.number ?? 0) + 1;
                _pagingController.appendPage(newItems, nextPageKey);
              }
              seriesName.addAll(newItems);

              print("seriesLength");
              print(seriesName.length);
            }
          }

          if (state.status == LiveScoreStatus.finishedMatchSuccess) {
            FinishedMatchResponse finishedMatchResponse =
                state.responseData?.response as FinishedMatchResponse;
            Loader.hide();

            if (finishedMatchResponse.data?.length != 0) {
              matchData.clear();
              matchData.addAll(finishedMatchResponse.data ?? []);
            }
          }

          // if (state.status == LiveScoreStatus.finishedSeriesSuccess) {
          //   var newData = (state.responseData?.response as FinishedMatchResponse).data;
          //
          //   if (newData == null) {
          //     hasMoreData = false;
          //   } else {
          //     if (pageNo == 0) {
          //       finishedSeriesResponse = state.responseData?.response as FinishedMatchResponse;
          //     } else {
          //       finishedSeriesResponse.data = newData; // This now works since `data` is not final
          //     }
          //   }
          // }

          setState(() {
            isLoadingMore = false;
          });

          Loader.hide();

          if (state.status == LiveScoreStatus.finishedSeriesError ||
              state.status == LiveScoreStatus.finishedMatchError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';

            print(message);
            UiHelper.toastMessage(message);
          }

          // if (state.status == LiveScoreStatus.upcomingSeriesLoading) {
          //   Loader.show(context);
          // }
        }, builder: (context, state) {
          if (state.status == LiveScoreStatus.finishedSeriesLoading &&
              pageNo == 0) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.finishedSeriesError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: screenHeight * 0.5,
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
                              ? mediumText14(context, "No data found",
                                  //'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  textColor: const Color(0xffFFFFFF))
                              : Center(
                                  child: mediumText14(
                                      // context, '$ No data found \n\nClick to refresh.',
                                      context,
                                      "${"No data found"}\n \n Click to refresh",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                      textColor: const Color(0xffFFFFFF)),
                                ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            // getFinished();
                            // Handle refresh action here
                          },
                        ),
                        if (isLoadingMore)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
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
                  finishedSeriesResponse.data?.content?.length == null &&
                          finishedSeriesResponse.data?.content?.length == 0
                      ? Center(
                          child: mediumText14(context, 'No Upcoming Series',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: const Color(0xffFFFFFF)),
                        )
                      : (finishedSeriesResponse.data?.content?.isNotEmpty ??
                              false)
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: PagedListView<int, SeriesName>(
                                  pagingController: _pagingController,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<SeriesName>(
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
                                          await BlocProvider.of<LiveScoreCubit>(
                                                  context)
                                              .getFinishMatch(
                                                  pageNo.toString(),
                                                  seriesName[index]
                                                      .id2
                                                      .toString());
                                          // });
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
                                                              .name
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
                                            else if (matchData.isEmpty)
                                              Center(
                                                child: mediumText14(
                                                  context,
                                                  'No match found',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  textAlign: TextAlign.center,
                                                  textColor:
                                                      const Color(0xffFFFFFF),
                                                ),
                                              )
                                            else
                                              Column(
                                                children: matchData
                                                    .map(
                                                      (items) => GestureDetector(
                                                        onTap: (){
                                                          if(items.result== true){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                              return FinishedMatchScorecardScreen(matchId:items.fixtureId.toString()??"", winningTeam:items.winningTeamName.toString()??"");
                                                            },));
                                                          }
                                                          else{
                                                            showToast(context: context, message: "Result not found");
                                                          }
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color:
                                                                    Colors.white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(7),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(1.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          12.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width:
                                                                                  MediaQuery.of(context).size.width * 0.25,
                                                                              child:
                                                                                  commonText(
                                                                                data: items.homeTeam ?? "N/A",
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: "Poppins",
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                                height: 20),
                                                                            items.homeTeamRuns != null
                                                                                ? commonText(
                                                                                    data: "${items.homeTeamRuns ?? "N/A"}/${items.homeTeamWickets ?? "N/A"}",
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontFamily: "Poppins",
                                                                                    color: Colors.black,
                                                                                  )
                                                                                : commonText(
                                                                                    data: "Not found",
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontFamily: "Poppins",
                                                                                    color: Colors.black,
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            commonText(
                                                                          alignment:
                                                                              TextAlign.center,
                                                                          data:
                                                                              items.winningTeamName??"N/A",
                                                                          fontSize:
                                                                              10,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          color: Colors
                                                                              .black,
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width:
                                                                                  MediaQuery.of(context).size.width * 0.25,
                                                                              child: items.awayTeam != null
                                                                                  ? commonText(
                                                                                      data: items.awayTeam ?? "N/A",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontFamily: "Poppins",
                                                                                      color: Colors.black,
                                                                                    )
                                                                                  : commonText(
                                                                                      data: "Not available",
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontFamily: "Poppins",
                                                                                      color: Colors.black,
                                                                                    ),
                                                                            ),
                                                                            SizedBox(
                                                                                height: 20),
                                                                            items.awayTeamRuns != null
                                                                                ? commonText(
                                                                                    data: "${items.awayTeamRuns ?? "N/A"}/${items.awayTeamWickets ?? "N/A"}",
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontFamily: "Poppins",
                                                                                    color: Colors.black,
                                                                                  )
                                                                                : commonText(
                                                                                    data: "Not found",
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontFamily: "Poppins",
                                                                                    color: Colors.black,
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
                                                      ),
                                                    )
                                                    .toList(),
                                              )
                                        ],
                                      );
                                    },
                                  )),
                            )
                          : Center(
                              child: mediumText14(
                                context,
                                'No Finished Series',
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
}

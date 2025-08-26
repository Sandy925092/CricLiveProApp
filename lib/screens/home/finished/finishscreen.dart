import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
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

import '../../../constants.dart';
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
  bool? isTrue;
  List<bool> isTrueList = [false, false];
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  List<SeriesName> seriesName = [];
  List<MatchData> matchData = [];
  String selectedFilter = "International";
  int selectedIndex = 0;
  int selectedSeriesIndex = -1;

  List<String> filterTypes = [
    "International",
    "InternationalClubs",
    "Domestic",
    "Other",
    "Unknown"
  ];
  int? expandedIndex;
  late final PagingController<int, SeriesName> _pagingController;

  Future<void> getFinished({bool isLoadMore = false}) async {
    if (isLoadMore) {
      setState(() {
        isLoadingMore = true;
      });
    }
    //
    // isInternetConnected().then((value) async {
    //   if (value == true) {
    //     await BlocProvider.of<LiveScoreCubit>(context)
    //         .getFinishedSeries(pageNo.toString());
    //   } else {
    //     showToast(context: context, message: notConnected);
    //   }
    // });
  }

  Future<void> _refreshPage() async {
    _pagingController = PagingController(
      firstPageKey: 0,
    );

    print("call inittstate1");

    _fetchPage(pageNo);

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void initState() {
    super.initState();
    print("call inittstate");
    _scrollController.addListener(_scrollListener);

    _pagingController = PagingController(
      firstPageKey: 0,
    );

    print("call inittstate1");

    _fetchPage(pageNo);

    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    print("call inittstate2");
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      pageNo++;
      _fetchPage(pageNo);
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    print(pageKey.toString() + "this is page key");
    try {
      isInternetConnected().then((value) async {
        if (value == true) {
          await BlocProvider.of<LiveScoreCubit>(context)
              .getFinishedSeries(pageNo.toString(), selectedFilter);
        } else {
          showToast(context: context, message: notConnected);
        }
      });
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

              if (pageNo == 0) {
                seriesName.clear();
              }

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
            matchData.clear();

            print("Match data details");
            print(matchData.length);

            if (finishedMatchResponse.data?.length != 0) {
              final matches = finishedMatchResponse.data ?? [];

              matchData.clear();
              matchData.addAll(matches.where((m) => m.result == true));
            } else {
              matchData.clear();
            }
          }

          setState(() {
            isLoadingMore = false;
          });

          Loader.hide();

          if (state.status == LiveScoreStatus.finishedSeriesError ||
              state.status == LiveScoreStatus.finishedMatchError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';

            print(message);
            matchData.clear();
            // UiHelper.toastMessage(message);
          }
        }, builder: (context, state) {
          if (state.status == LiveScoreStatus.finishedSeriesLoading &&
              pageNo == 0) {
            return Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterTypes.length,
                    itemBuilder: (context, index) {
                      final item = filterTypes[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pageNo = 0;
                            selectedIndex = index;
                            selectedFilter = item;
                            _pagingController.refresh();

                            _fetchPage(0);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? neonColor : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: isSelected ? neonColor : Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
                  ),
                ),
              ],
            );
          }
          if (state.status == LiveScoreStatus.finishedSeriesError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterTypes.length,
                    itemBuilder: (context, index) {
                      final item = filterTypes[index];
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pageNo = 0;
                            selectedIndex = index;
                            selectedFilter = item;
                            _pagingController.refresh();

                            _fetchPage(0);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? neonColor : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: isSelected ? neonColor : Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refreshPage,
                  child: SingleChildScrollView(
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
                              padding: const EdgeInsets.only(
                                  left: 50.0, right: 50.0),
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
                                          "${"No data found"}",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                          textColor: const Color(0xffFFFFFF)),
                                    ),
                            ),
                            if (isLoadingMore)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filterTypes.length,
                  itemBuilder: (context, index) {
                    final item = filterTypes[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          pageNo = 0;
                          selectedIndex = index;
                          selectedFilter = item;
                          _pagingController.refresh();

                          _fetchPage(0);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? neonColor : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: isSelected ? neonColor : Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              RefreshIndicator(
                onRefresh: _refreshPage,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      2.h.heightBox,
                      finishedSeriesResponse.data?.content?.length == null &&
                              finishedSeriesResponse.data?.content?.length == 0
                          ? Column(
                              children: [
                                SizedBox(height: 15),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filterTypes.length,
                                    itemBuilder: (context, index) {
                                      final item = filterTypes[index];
                                      final isSelected = selectedIndex == index;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pageNo = 0;
                                            selectedIndex = index;
                                            selectedFilter = item;
                                            _pagingController.refresh();
                                            _fetchPage(0);
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? neonColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: isSelected
                                                    ? neonColor
                                                    : Colors.grey),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
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
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.64,
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                physics: AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    seriesName.length + (isLoadingMore ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == seriesName.length) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  final series = seriesName[index];
                                  final isExpanded = expandedIndex == index;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() async {
                                            matchData.clear();
                                            expandedIndex =
                                                isExpanded ? null : index;
                                            print(
                                                "Tapped index: $index, expanded: ${seriesName[index].id2.toString()}");
                                            pageNo = 0;

                                            selectedSeriesIndex = index;
                                            await BlocProvider.of<
                                                    LiveScoreCubit>(context)
                                                .getFinishMatch(
                                                    pageNo.toString(),
                                                    seriesName[index]
                                                        .id2
                                                        .toString());
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: commonText(
                                                  data: series.name ?? "",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: white,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() async {
                                                    matchData.clear();
                                                    expandedIndex = isExpanded
                                                        ? null
                                                        : index;
                                                    print(
                                                        "Tapped index: $index, expanded: ${seriesName[index].id2.toString()}");
                                                    pageNo = 0;

                                                    selectedSeriesIndex = index;
                                                    await BlocProvider.of<
                                                                LiveScoreCubit>(
                                                            context)
                                                        .getFinishMatch(
                                                            pageNo.toString(),
                                                            seriesName[index]
                                                                .id2
                                                                .toString());
                                                  });
                                                },
                                                child: Icon(
                                                  isExpanded
                                                      ? Icons.keyboard_arrow_up
                                                      : Icons
                                                          .keyboard_arrow_down,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1.0,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      if (state.status ==
                                              LiveScoreStatus
                                                  .finishedMatchLoading &&
                                          selectedSeriesIndex == index)
                                        const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      if (isExpanded && matchData.isNotEmpty)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: matchData.length,
                                          itemBuilder: (context, index2) {
                                            final fixture = matchData[index2];
                                            return GestureDetector(
                                              onTap: () {
                                                if (matchData[index2]
                                                    .resultType
                                                    .toString()
                                                    .lowerCamelCase
                                                    .contains("won")) {
                                                  if (matchData[index2]
                                                          .homeTeamRuns
                                                          ?.length ==
                                                      0) {
                                                    showToast(
                                                        context: context,
                                                        message:
                                                            "No data found");
                                                  } else {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return FinishedMatchScorecardScreen(
                                                            matchId: matchData[
                                                                        index2]
                                                                    .fixtureId
                                                                    .toString() ??
                                                                "",
                                                            winningTeam: matchData[
                                                                        index2]
                                                                    .winningTeamName
                                                                    .toString() ??
                                                                "");
                                                      },
                                                    ));
                                                  }
                                                }
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      fixture.homeTeamFlag ??
                                                                          "",
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (c,
                                                                          u,
                                                                          e) =>
                                                                      Image
                                                                          .asset(
                                                                    "assets/images/iv_noflag.png",
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                                  height: 30,
                                                                  width: 30,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  fixture.homeTeam ??
                                                                      "Team ${fixture.fixtureId ?? ""}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 25.w,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        3),
                                                            child: Center(
                                                              child: commonText(
                                                                alignment:
                                                                    TextAlign
                                                                        .center,
                                                                data: () {
                                                                  final resultType =
                                                                      matchData[index2]
                                                                              .resultType
                                                                              ?.toLowerCase() ??
                                                                          "";
                                                                  final winningTeam =
                                                                      matchData[index2]
                                                                              .winningTeamName ??
                                                                          "";

                                                                  if (resultType ==
                                                                      "abandoned") {
                                                                    return "Match Abandoned";
                                                                  } else if (resultType
                                                                      .contains(
                                                                          "cancel")) {
                                                                    return "Match Cancelled";
                                                                  } else if (winningTeam
                                                                      .isNotEmpty) {
                                                                    return "$winningTeam ${matchData[index2].resultType}";
                                                                  } else {
                                                                    return matchData[index2]
                                                                            .resultType ??
                                                                        "Result Pending";
                                                                  }
                                                                }(),
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ).pOnly(
                                                              left: 32,
                                                              right: 32),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      fixture.awayTeamFlag ??
                                                                          "",
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width: 20,
                                                                      height:
                                                                          20,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  errorWidget: (c,
                                                                          u,
                                                                          e) =>
                                                                      Image
                                                                          .asset(
                                                                    "assets/images/iv_noflag.png",
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                                  height: 30,
                                                                  width: 30,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  fixture.awayTeam ??
                                                                      "Team ${fixture.fixtureId ?? ""}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                    ],
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}

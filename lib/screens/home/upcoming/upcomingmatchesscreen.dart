import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
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
import '../countdown.dart';

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
  String selectedDay = "";
  String selectedDayValue = "Today";
  String selectedFilter = "International";
  int pageNo = 0;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  int selectedIndex = 0;
  int selectedLikeIndex = -1;

  int selectedDayIndex = -1;
  int? selectedSeriesIndex;
  int? selectedFixtureIndex;
  late final PagingController<int, UpComingContent> _pagingController;
  final ScrollController _scrollController = ScrollController();

  List<UpComingContent> seriesName = [];

  List<Fixtures> fixtures = [];

  List<String> filterTypes = [
    "International",
    "InternationalClubs",
    "Domestic",
    "Other",
    "Unknown"
  ];

  List<String> filterDays = [
    "Today",
    "This Week",
  ];

  Future<void> _refreshPage() async {
    _fetchPage(pageNo);
  }

  @override
  void initState() {
    getToken();
    _scrollController.addListener(_scrollListener);

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

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isLoadingMore &&
        hasMoreData) {
      pageNo++;
      _fetchPage(pageNo);
    }
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

            if (pageNo == 0) {
              seriesName.clear();
            }
            final allSeries = upcomingSeriesResponse.data?.content ?? [];

            seriesName.addAll(allSeries
                .where((series) => (series.fixtures?.isNotEmpty ?? false)));

            if (upcomingSeriesResponse.data?.content?.isNotEmpty ?? false) {
              final newItems = upcomingSeriesResponse.data?.content ?? [];
              final isLastPage = upcomingSeriesResponse.data?.last ?? true;

              if (isLastPage) {
                _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey =
                    (upcomingSeriesResponse.data?.number ?? 0) + 1;
                pageNo = nextPageKey;
                _pagingController.appendPage(newItems, nextPageKey);
              }

              print("paging length => ${_pagingController.itemList?.length}");
            }
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
                  height: 15,
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filterDays.length,
                    itemBuilder: (context, index) {
                      final item = filterDays[index];
                      final isSelected = selectedDayIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            pageNo = 0;
                            selectedDayIndex = index;
                            selectedDay = item;
                            _pagingController.refresh();

                            _fetchPage(0);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: isSelected
                                    ? Colors.blue
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
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
                  ),
                ),
              ],
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

                                    _fetchPage(0);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected ? neonColor : Colors.white,
                                    borderRadius: BorderRadius.circular(25),
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
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: filterDays.length,
                            itemBuilder: (context, index) {
                              final item = filterDays[index];
                              final isSelected = selectedDayIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageNo = 0;
                                    selectedDayIndex = index;
                                    selectedDay = item;
                                    _pagingController.refresh();

                                    _fetchPage(0);
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: isSelected
                                            ? Colors.blue
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
                  seriesName.length == 0
                      ? Column(
                          children: [
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
                                        borderRadius: BorderRadius.circular(25),
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
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: filterDays.length,
                                itemBuilder: (context, index) {
                                  final item = filterDays[index];
                                  final isSelected = selectedDayIndex == index;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        pageNo = 0;
                                        selectedDayIndex = index;
                                        selectedDay = item;
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
                                            ? Colors.blue
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: isSelected
                                                ? Colors.blue
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
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.5,
                              child: Center(
                                child: mediumText14(context, 'No Upcoming Series',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.center,
                                    textColor: const Color(0xffFFFFFF)),
                              ),
                            ),
                          ],
                        )
                      : (seriesName.length != 0)
                          ? Column(
                              children: [
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
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filterDays.length,
                                    itemBuilder: (context, index) {
                                      final item = filterDays[index];
                                      final isSelected =
                                          selectedDayIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pageNo = 0;
                                            selectedDayIndex = index;
                                            selectedDay = item;
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
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemCount: seriesName.length +
                                        (isLoadingMore ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      final series = seriesName[index];
                                      final isExpanded = expandedIndex == index;

                                      if (index == seriesName.length) {
                                        return const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                expandedIndex =
                                                    isExpanded ? null : index;
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 15.0, right: 15),
                                              child: Row(
                                                children: [

                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Expanded(
                                                    child: commonText(
                                                      data: series.seriesName ??
                                                          "",
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                      color: white,
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Icon(
                                                    isExpanded
                                                        ? Icons
                                                            .keyboard_arrow_up
                                                        : Icons
                                                            .keyboard_arrow_down,
                                                    color: Colors.white,
                                                    size: 30,
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
                                          if (isExpanded &&
                                              (series.fixtures?.isNotEmpty ??
                                                  false))
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  series.fixtures!.length,
                                              itemBuilder: (context, index2) {
                                                final fixture =
                                                    series.fixtures![index2];
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: state.status ==
                                                                          LiveScoreStatus
                                                                              .likematchLoading &&
                                                                      selectedLikeIndex ==
                                                                          index2 ||
                                                                  state.status ==
                                                                          LiveScoreStatus
                                                                              .unLikematchLoading &&
                                                                      selectedLikeIndex ==
                                                                          index2
                                                              ? const SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                )
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedLikeIndex =
                                                                          index2;
                                                                    });
                                                                    final matchDetails =
                                                                        {
                                                                      "seriesId":
                                                                          series.seriesId?.toString() ??
                                                                              "",
                                                                      "seriesName":
                                                                          series.seriesName?.toString() ??
                                                                              "",
                                                                      "fixtureId": fixture
                                                                          .fixtureId
                                                                          .toString(),
                                                                      "teamAName": fixture
                                                                              .homeTeam
                                                                              ?.name
                                                                              ?.toString() ??
                                                                          "Team ${fixture.homeTeam?.id?.toString() ?? ""}",
                                                                      "teamBName": fixture
                                                                              .awayTeam
                                                                              ?.name
                                                                              ?.toString() ??
                                                                          "Team ${fixture.awayTeam?.id?.toString() ?? ""}",
                                                                      "matchStatus":
                                                                          "Upcoming",
                                                                      "matchDate": fixture
                                                                              .startTimes
                                                                              ?.first
                                                                              .date
                                                                              ?.toString() ??
                                                                          "",
                                                                    };
                                                                    BlocProvider.of<LiveScoreCubit>(
                                                                            context)
                                                                        .likeMatch(
                                                                            token,
                                                                            matchDetails);
                                                                  },
                                                                  child: BlocConsumer<
                                                                      LiveScoreCubit,
                                                                      LiveScoreState>(
                                                                    listener:
                                                                        (context,
                                                                            state) {
                                                                      if (state
                                                                              .status ==
                                                                          LiveScoreStatus
                                                                              .likematchSuccess) {
                                                                        UiHelper.toastMessage(
                                                                            "Match added to wishlist");

                                                                        setState(
                                                                            () {
                                                                          series
                                                                              .fixtures![selectedLikeIndex]
                                                                              .liked = true;
                                                                        });
                                                                        UiHelper.toastMessage(
                                                                            "Match added to wishlist");
                                                                      }

                                                                      if (state
                                                                              .status ==
                                                                          LiveScoreStatus
                                                                              .unLikematchSuccess) {
                                                                        showToast(
                                                                            context:
                                                                                context,
                                                                            message:
                                                                                "Match removed from wishlist");

                                                                        setState(
                                                                            () {
                                                                          series
                                                                              .fixtures![selectedLikeIndex]
                                                                              .liked = false;
                                                                        });
                                                                      }
                                                                    },
                                                                    builder:
                                                                        (context,
                                                                            state) {
                                                                      return Icon(
                                                                        series.fixtures![index2].liked ==
                                                                                true
                                                                            ? Icons.favorite
                                                                            : Icons.favorite_outline_rounded,
                                                                        color: series.fixtures![index2].liked ==
                                                                                true
                                                                            ? Colors.red
                                                                            : Colors.grey,
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  CachedNetworkImage(
                                                                    imageUrl: fixture
                                                                            .homeTeam
                                                                            ?.flagUrl ??
                                                                        "",
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (c,
                                                                            u,
                                                                            e) =>
                                                                        Image
                                                                            .asset(
                                                                      "assets/images/iv_noflag.png",
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                    ),
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  Text(
                                                                    fixture.homeTeam
                                                                            ?.name ??
                                                                        "Team ${fixture.homeTeam?.id ?? ""}",
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                color:
                                                                    buttonColors,
                                                              ),
                                                              child: Center(
                                                                child: MatchCountdown(
                                                                  startDate: DateTime.parse(
                                                                      "${fixture.startTimes?.first.date} ${fixture.startTimes?.first.time}"
                                                                  ).toLocal(),
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "Poppins",
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ).pOnly(
                                                                left: 32,
                                                                right: 32),
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  CachedNetworkImage(
                                                                    imageUrl: fixture
                                                                            .awayTeam
                                                                            ?.flagUrl ??
                                                                        "",
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width:
                                                                            20,
                                                                        height:
                                                                            20,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          strokeWidth:
                                                                              2,
                                                                          color:
                                                                              Colors.blue,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (c,
                                                                            u,
                                                                            e) =>
                                                                        Image
                                                                            .asset(
                                                                      "assets/images/iv_noflag.png",
                                                                      height:
                                                                          30,
                                                                      width: 30,
                                                                    ),
                                                                    height: 30,
                                                                    width: 30,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  Text(
                                                                    fixture.awayTeam
                                                                            ?.name ??
                                                                        "Team ${fixture.awayTeam?.id ?? ""}",
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
                                                );
                                              },
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
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
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filterDays.length,
                                    itemBuilder: (context, index) {
                                      final item = filterDays[index];
                                      final isSelected =
                                          selectedDayIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            pageNo = 0;
                                            selectedDayIndex = index;
                                            selectedDay = item;
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
                                SizedBox(
                                  height: 40,
                                ),
                                Center(
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
          await BlocProvider.of<LiveScoreCubit>(context).getUpcomingSeries(
              token, pageKey.toString(), selectedFilter, selectedDay);
        } else {
          showToast(context: context, message: notConnected);
        }
      });
    } catch (error) {
      _pagingController.error = error;
      debugPrint('Error loading page $pageKey: $error');
    }
  }

  String getCountdown(DateTime startDate) {
    final now = DateTime.now();
    final difference = startDate.difference(now);

    final clockTime = DateFormat("hh:mm a").format(startDate); // format clock

    if (difference.isNegative) {
      return "Started";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays > 1 ? "s" : ""} left";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hour${difference.inHours > 1 ? "s" : ""} left • $clockTime";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} min left • $clockTime";
    } else {
      return "Starting soon • $clockTime";
    }
  }
}

//

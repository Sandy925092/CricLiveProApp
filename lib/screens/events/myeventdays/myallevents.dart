import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants.dart';
import '../../../cubit/livescore_cubit.dart';
import '../../../main.dart';
import '../../../responses/myevents.dart';
import '../../../utils/custom_widgets.dart';
import '../../series/FinishedMatchscorecard.dart';

class MyAllEventsScreen extends StatefulWidget {
  final String tabType;

  MyAllEventsScreen({super.key, required this.tabType});

  @override
  State<MyAllEventsScreen> createState() => _MyAllEventsScreenState();
}

class _MyAllEventsScreenState extends State<MyAllEventsScreen> {
  MyEventsResponse myEventsResponse = MyEventsResponse();
  late final PagingController<int, MyEventsData> _pagingController;
  int pageNo = 0;

  @override
  void initState() {
    getCurrentDate();
    _pagingController = PagingController(firstPageKey: 0);

    _pagingController.addPageRequestListener((pageKey) {
      getApi(pageKey);
    });

    // Load initial data
    getApi(0);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Today',
          //       style: TextStyle(
          //           color: white, fontSize: 16, fontWeight: FontWeight.w700),
          //     ),
          //     Column(
          //       children: [
          //         2.h.heightBox,
          //         Text(
          //           selectedDate,
          //           style: TextStyle(
          //               color: white,
          //               fontSize: 14,
          //               fontWeight: FontWeight.w700),
          //         ),
          //       ],
          //     ),
          //     GestureDetector(
          //       onTap: () async {
          //         DateTime? picked = await showDatePicker(
          //           context: context,
          //           initialDate: DateTime.now(),
          //           firstDate: DateTime(1800),
          //           lastDate: DateTime(2100),
          //         );
          //
          //         if (picked != null) {
          //           setState(() {
          //             selectedDate = DateFormat('yyyy-MM-dd').format(picked);
          //             // Reset pagination and load new data
          //             _pagingController.refresh();
          //             pageNo = 0;
          //           });
          //         }
          //       },
          //       child: Icon(
          //         Icons.calendar_today, // Changed to Material icon
          //         color: white,
          //         size: 30,
          //       ),
          //     )
          //   ],
          // ).pSymmetric(h: 3),
          Expanded(
            child: BlocConsumer<LiveScoreCubit, LiveScoreState>(
              listener: (context, state) {
                if (state.status == LiveScoreStatus.myEventsSuccess) {
                  myEventsResponse =
                      state.responseData?.response as MyEventsResponse;
                  // Loader.hide();

                  final newItems = myEventsResponse.data?.content ?? [];
                  final isLastPage = myEventsResponse.data?.last ?? true;

                  if (pageNo == 0) {
                    // For first page or refresh, replace all items
                    _pagingController.value = PagingState(
                      itemList: newItems,
                      nextPageKey: isLastPage ? null : pageNo + 1,
                      error: null,
                    );
                  } else {
                    // For subsequent pages, append items
                    if (isLastPage) {
                      _pagingController.appendLastPage(newItems);
                    } else {
                      _pagingController.appendPage(newItems, pageNo + 1);
                    }
                  }
                } else if (state.status == LiveScoreStatus.myEventsLoading &&
                    pageNo == 0) {
                  // Loader.show(context);
                }
              },
              builder: (context, state) {
                if (state.status == LiveScoreStatus.myEventsLoading &&
                    pageNo == 0) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                return PagedListView<int, MyEventsData>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<MyEventsData>(
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: mediumText14(
                        context,
                        'No Result found',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        textColor: const Color(0xffFFFFFF),
                      ),
                    ),
                    itemBuilder: (context, item, index) {
                      if (item.status == "Upcoming") {
                        return _buildUpcomingMatchItem(item);
                      } else {
                        return _buildCompletedMatchItem(item);
                      }
                    },
                  ),
                ).pSymmetric(h: 10, v: 6);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingMatchItem(MyEventsData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonText(
                  alignment: TextAlign.center,
                  data: item.seriesName ?? "",
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: commonText(
                              data: item.homeTeam ?? "N/A",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Container(
                      width: 25.w,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: buttonColors,
                      ),
                      child: Center(
                        child: commonText(
                          alignment: TextAlign.center,
                          data:
                              "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(item.matchDateTime ?? "2025-04-04T10:00:00"))}",
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: black,
                        ),
                      ),
                    ).pOnly(left: 32, right: 32),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: commonText(
                              data: item.awayTeam ?? "N/A",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
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
  }

  Widget _buildCompletedMatchItem(MyEventsData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          if (item.result == true) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FinishedMatchScorecardScreen(
                    matchId: item.fixtureId.toString() ?? "",
                    winningTeam: item.winningTeamName.toString() ?? "");
              },
            ));
          } else {
            showToast(context: context, message: "Result not found");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: commonText(
                    alignment: TextAlign.center,
                    data: item.seriesName ?? "",
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: commonText(
                                data: item.homeTeam ?? "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (item.homeTeamRuns?.isNotEmpty ?? false)
                              Column(
                                children: List.generate(
                                  item.homeTeamRuns!.length,
                                  (i) => commonText(
                                    data:
                                        "${item.homeTeamRuns![i]}/${item.homeTeamWickets![i]}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            else
                              commonText(
                                data: "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                      item.winningTeamName != null
                          ? Center(
                              child: commonText(
                                alignment: TextAlign.center,
                                data: "${item.winningTeamName} won" ?? "N/A",
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            )
                          : Center(
                        child: commonText(
                          alignment: TextAlign.center,
                          data: "N/A",
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: commonText(
                                data: item.awayTeam ?? "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (item.awayTeamRuns?.isNotEmpty ?? false)
                              Column(
                                children: List.generate(
                                  item.awayTeamRuns!.length,
                                  (i) => commonText(
                                    data:
                                        "${item.awayTeamRuns![i]}/${item.awayTeamWickets![i]}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            else
                              commonText(
                                data: "N/A",
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
    );
  }

  void getCurrentDate() {
    DateTime now = DateTime.now();
    selectedDate = DateFormat('yyyy-MM-dd').format(now);
  }

  void getApi(int pageKey) {
    pageNo = pageKey;
    isInternetConnected().then((value) {
      if (value) {
        BlocProvider.of<LiveScoreCubit>(context).getMyEvents(
          selectedDate,
          widget.tabType,
          pageKey.toString(),
        );
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }
}

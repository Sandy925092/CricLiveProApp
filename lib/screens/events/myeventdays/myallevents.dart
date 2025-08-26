import 'package:cached_network_image/cached_network_image.dart';
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

  List<MyEventsData> myEventsList = [];

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
          Expanded(
            child: BlocConsumer<LiveScoreCubit, LiveScoreState>(
              listener: (context, state) {
                if (state.status == LiveScoreStatus.myEventsSuccess) {
                  myEventsResponse =
                      state.responseData?.response as MyEventsResponse;
                  // Loader.hide();

                  print("my events length");
                  print(myEventsList.length);

                  if (pageNo == 0) {
                    myEventsList.clear();
                  }

                  if (myEventsResponse.data?.content?.length != 0) {
                    myEventsList.addAll(myEventsResponse.data?.content ?? []);
                  }


                  print("my events length");
                  print(myEventsList.length);

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
                }
                if (state.status == LiveScoreStatus.myEventsError) {
                  // Loader.show(context);
                  print("my events length in error");
                  print(myEventsList.length);
                  myEventsList.clear();

                }
              },
              builder: (context, state) {
                if (state.status == LiveScoreStatus.myEventsLoading &&
                    pageNo == 0) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                return myEventsList.length != 0
                    ? ListView.builder(
                  itemCount: myEventsList.length,
                        itemBuilder: (context, index) {
                          if (myEventsList[index]
                              .status
                              .toString()
                              .lowerCamelCase
                              .contains("upcoming")) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: commonText(
                                          alignment: TextAlign.center,
                                          data:
                                              myEventsList[index].seriesName ??
                                                  "",
                                          fontSize: 14,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: myEventsList[
                                                                index]
                                                            .homeTeamFlag
                                                            .toString()
                                                            .isNotEmpty
                                                        ? myEventsList[index]
                                                            .homeTeamFlag
                                                            .toString()
                                                        : "assets/images/iv_noflag.png",
                                                    // better fallback
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child: SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "assets/images/iv_noflag.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: commonText(
                                                      data: myEventsList[index]
                                                              .homeTeam ??
                                                          "N/A",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                color: buttonColors,
                                              ),
                                              child: Center(
                                                child: commonText(
                                                  alignment: TextAlign.center,
                                                  data:
                                                      "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(myEventsList[index].matchDateTime ?? "2025-04-04T10:00:00"))}",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: black,
                                                ),
                                              ),
                                            ).pOnly(left: 32, right: 32),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: myEventsList[
                                                                index]
                                                            .awayTeamFlag
                                                            .toString()
                                                            .isNotEmpty
                                                        ? myEventsList[index]
                                                            .awayTeamFlag
                                                            .toString()
                                                        : "assets/images/iv_noflag.png",
                                                    // better fallback
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child: SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      "assets/images/iv_noflag.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    child: commonText(
                                                      data: myEventsList[index]
                                                              .awayTeam ??
                                                          "N/A",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (myEventsList[index].result == true) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return FinishedMatchScorecardScreen(
                                            matchId: myEventsList[index]
                                                    .fixtureId
                                                    .toString() ??
                                                "",
                                            winningTeam: myEventsList[index]
                                                    .winningTeamName
                                                    .toString() ??
                                                "");
                                      },
                                    ));
                                  } else {
                                    showToast(
                                        context: context,
                                        message: "Result not found");
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: commonText(
                                            alignment: TextAlign.center,
                                            data: myEventsList[index]
                                                    .seriesName ??
                                                "",
                                            fontSize: 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: commonText(
                                                        data:
                                                            myEventsList[index]
                                                                    .homeTeam ??
                                                                "N/A",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    if (myEventsList[index]
                                                            .homeTeamRuns
                                                            ?.isNotEmpty ??
                                                        false)
                                                      Column(
                                                        children: List.generate(
                                                          myEventsList[index]
                                                              .homeTeamRuns!
                                                              .length,
                                                          (i) => commonText(
                                                            data:
                                                                "${myEventsList[index].homeTeamRuns![i]}/${myEventsList[index].homeTeamWickets![i]}",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    else
                                                      commonText(
                                                        data: "N/A",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              myEventsList[index]
                                                          .winningTeamName !=
                                                      null
                                                  ? Center(
                                                      child: commonText(
                                                        alignment:
                                                            TextAlign.center,
                                                        data:
                                                            "${myEventsList[index].winningTeamName} won" ??
                                                                "N/A",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  : Center(
                                                      child: commonText(
                                                        alignment:
                                                            TextAlign.center,
                                                        data: "N/A",
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: commonText(
                                                        data:
                                                            myEventsList[index]
                                                                    .awayTeam ??
                                                                "N/A",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    if (myEventsList[index]
                                                            .awayTeamRuns
                                                            ?.isNotEmpty ??
                                                        false)
                                                      Column(
                                                        children: List.generate(
                                                          myEventsList[index]
                                                              .awayTeamRuns!
                                                              .length,
                                                          (i) => commonText(
                                                            data:
                                                                "${myEventsList[index].awayTeamRuns![i]}/${myEventsList[index].awayTeamWickets![i]}",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    else
                                                      commonText(
                                                        data: "N/A",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                        },
                      )
                    : Center(
                        child: commonText(
                            data: "No Data Found",
                            fontSize: 14,
                            color: Colors.white),
                      );
              },
            ),
          ),
        ],
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
        BlocProvider.of<LiveScoreCubit>(context)
            .getMyEvents(selectedDate, widget.tabType, pageKey.toString(), "");
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }
}

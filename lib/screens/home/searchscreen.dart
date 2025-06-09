import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/searchResponse.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants.dart';
import '../../cubit/livescore_cubit.dart';
import '../../utils/custom_widgets.dart';
import '../series/FinishedMatchscorecard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  List<SearchData> searchData = [];
  late ExpandedTileController _controller;
  bool? isTrue;
  SearchResponse searchResponse = SearchResponse();
  bool isDataEmpty = true;

  @override
  void initState() {
    _controller = ExpandedTileController(isExpanded: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Search",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                "assets/images/backicon.png",
                height: 0,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchController,
                textInputAction: TextInputAction.done,
                // Shows "Done" on the keyboard
                decoration: InputDecoration(
                  fillColor: white,
                  filled: true,
                  hintText: 'Search by series or teams',
                  hintStyle: TextStyle(
                      color: primaryColors,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: primaryColors,
                      width: 1.0,
                    ),
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search, size: 30, color: primaryColors),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),

                onFieldSubmitted: (value) {
                  print("On Tap");
                  print(value.toString());
                  isInternetConnected().then((value) async {
                    if (value == true) {
                      await BlocProvider.of<LiveScoreCubit>(context)
                          .getSearchMatches(
                              searchController.text.toString().trim());
                      setState(() {
                        searchData.clear();
                      });
                    } else {
                      showToast(context: context, message: notConnected);
                    }
                  });
                },
                onChanged: (value) {
                  // setState(() {});
                },
              ),
            ),
            2.h.heightBox,
            BlocConsumer<LiveScoreCubit, LiveScoreState>(
              listener: (context, state) {
                if (state.status == LiveScoreStatus.searchMatchesSuccess) {
                  searchResponse =
                      state.responseData?.response as SearchResponse;
                  setState(() {
                    searchData.clear();
                  });
                  // searchData.clear();

                  if (searchResponse.data?.length != 0) {
                    setState(() {
                      searchData.addAll(searchResponse.data ?? []);
                      isDataEmpty = false;
                    });
                  }

                  print("search list size");
                  print(searchData.length);
                }

                if (state.status == LiveScoreStatus.searchMatchesLoading) {
                  // CircularProgressIndicator();
                }

                if (state.status == LiveScoreStatus.searchMatchesError) {
                  showToast(
                      context: context,
                      message: state.errorData?.message.toString() ?? "");
                  setState(() {
                    isDataEmpty = true;
                  });
                }
              },
              builder: (context, state) {
                print("isDataEmpty");
                print(isDataEmpty);
                print(searchData.length);
                // print(searchData[3].seriesName.toString());

                return state.status == LiveScoreStatus.searchMatchesLoading
                    ? CircularProgressIndicator()
                    : searchData.isNotEmpty
                        ? ExpandedTileList.builder(
                            itemCount: searchData.length ?? 0,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                              data: searchData[index]
                                                      .seriesName ??
                                                  "",
                                              // data:  "asdsada",
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
                                // content: SizedBox(),
                                content: searchData[index].matches?.length == 0
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
                                        itemCount:
                                            searchData[index].matches?.length ??
                                                0,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          if (searchData[index]
                                                  .matches?[i]
                                                  .upcoming ==
                                              true) {
                                            return GestureDetector(
                                              onTap: () {
                                                print("Tapped fixture index: ");
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                        color: disableColors),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.25,
                                                              child: commonText(
                                                                data: searchData[
                                                                            index]
                                                                        .matches?[
                                                                            i]
                                                                        .homeTeam
                                                                        ?.toString() ??
                                                                    "Not available",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 25.w,
                                                            padding: EdgeInsets
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
                                                              child: commonText(
                                                                alignment:
                                                                    TextAlign
                                                                        .center,
                                                                data:
                                                                    "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(searchData[index].matches?[i].startDateTime?.toString() ?? "2025-04-04T10:00:00"))}",
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    "Poppins",
                                                                color: black,
                                                              ),
                                                            ),
                                                          ).pOnly(
                                                              left: 32,
                                                              right: 32),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.25,
                                                                  child:
                                                                      commonText(
                                                                    data: searchData[index]
                                                                            .matches?[i]
                                                                            .awayTeam
                                                                            ?.toString() ??
                                                                        "Not available",
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .black,
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
                                            );
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                if (searchData[index]
                                                        .matches?[i]
                                                        .result ==
                                                    true) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return FinishedMatchScorecardScreen(
                                                          matchId: searchData[
                                                                      index]
                                                                  .matches?[i]
                                                                  .fixtureId
                                                                  .toString() ??
                                                              "",
                                                          winningTeam: searchData[
                                                                      index]
                                                                  .matches?[i]
                                                                  .winningTeamName
                                                                  .toString() ??
                                                              "");
                                                    },
                                                  ));
                                                } else {
                                                  showToast(
                                                      context: context,
                                                      message:
                                                          "Result not found");
                                                }
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  top: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                        color: disableColors),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.25,
                                                                  child:
                                                                      commonText(
                                                                    data: searchData[index]
                                                                            .matches![i]
                                                                            .homeTeam
                                                                            .toString() ??
                                                                        "N/A",
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 20),

                                                                searchData[index]
                                                                        .matches![
                                                                            i]
                                                                        .homeTeamRuns!
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children:
                                                                            List.generate(
                                                                          searchData[index].matches![i].homeTeamRuns?.length ??
                                                                              0,
                                                                          (indexRuns) =>
                                                                              commonText(
                                                                            data:
                                                                                "${searchData[index].matches![i].homeTeamRuns![indexRuns]}/${searchData[index].matches![i].homeTeamWickets![indexRuns]}",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    // optional else case

                                                                    : commonText(
                                                                        data:
                                                                            "Not found",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
                                                                      ),

                                                                // searchData[index]
                                                                //             .matches![
                                                                //                 i]
                                                                //             .homeTeamRuns !=
                                                                //         null
                                                                //     ? commonText(
                                                                //         data:
                                                                //             "${searchData[index].matches![i].homeTeamRuns.toString() ?? "N/A"}/${searchData[index].matches![i].homeTeamWickets.toString() ?? "N/A"}",
                                                                //         fontSize:
                                                                //             14,
                                                                //         fontWeight:
                                                                //             FontWeight
                                                                //                 .w500,
                                                                //         fontFamily:
                                                                //             "Poppins",
                                                                //         color: Colors
                                                                //             .black,
                                                                //       )
                                                                //     : commonText(
                                                                //         data:
                                                                //             "Not found",
                                                                //         fontSize:
                                                                //             14,
                                                                //         fontWeight:
                                                                //             FontWeight
                                                                //                 .w500,
                                                                //         fontFamily:
                                                                //             "Poppins",
                                                                //         color: Colors
                                                                //             .black,
                                                                //       ),
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: commonText(
                                                              alignment:
                                                                  TextAlign
                                                                      .center,
                                                              data:
                                                                  "${"${searchData[index].matches![i].winningTeamName.toString()} won" ?? ""}",
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.25,
                                                                  child: searchData[index]
                                                                              .matches![i]
                                                                              .awayTeam !=
                                                                          null
                                                                      ? commonText(
                                                                          data: searchData[index].matches![i].awayTeam.toString() ??
                                                                              "N/A",
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          color:
                                                                              Colors.black,
                                                                        )
                                                                      : commonText(
                                                                          data:
                                                                              "Not available",
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                ),
                                                                SizedBox(
                                                                    height: 20),
                                                                searchData[index]
                                                                        .matches![
                                                                            i]
                                                                        .awayTeamRuns!
                                                                        .isNotEmpty
                                                                    ? Column(
                                                                        children:
                                                                            List.generate(
                                                                          searchData[index].matches![i].awayTeamRuns?.length ??
                                                                              0,
                                                                          (AwayRunsIndex) =>
                                                                              commonText(
                                                                            data:
                                                                                "${searchData[index].matches![i].awayTeamRuns![AwayRunsIndex]}/${searchData[index].matches![i].awayTeamWickets![AwayRunsIndex]}",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    // optional else case

                                                                    : commonText(
                                                                        data:
                                                                            "Not found",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
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
                                            );
                                          }
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
                        : Center(
                            child: state.status ==
                                    LiveScoreStatus.searchMatchesLoading
                                ? CircularProgressIndicator()
                                : isDataEmpty
                                    ? SizedBox()
                                    : commonText(
                                        data: "No result found",
                                        fontSize: 15,
                                        color: Colors.white),
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}

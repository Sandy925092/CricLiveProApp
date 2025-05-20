import 'dart:convert';
import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/finishedmatchdetails.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../cubit/livescore_cubit.dart';
import '../../responses/socketlivematch.dart';
import '../../utils/ui_helper.dart';

class FinishedMatchScorecardScreen extends StatefulWidget {
  String matchId;
  String winningTeam;

  FinishedMatchScorecardScreen({super.key, required this.matchId, required this.winningTeam});

  @override
  State<FinishedMatchScorecardScreen> createState() =>
      _FinishedMatchScorecardScreenState();
}

class _FinishedMatchScorecardScreenState
    extends State<FinishedMatchScorecardScreen> with TickerProviderStateMixin {
  TabController? _controller;
  TabController? _controller2;
  bool isScoreCardSelected = true;
  bool lineUpTeamA = true;
  FinishedMatchDetailsResponse finishedMatchDetailsResponse =
      FinishedMatchDetailsResponse();


  late ScrollController _scrollController;


  final allInnings = <Map<String, dynamic>>[];
  var students = {
    "id": ['123', '456', '789'],
    "firstName": ["old", "gold", "silver"],
    "surName": ["new", 'newwww', "newest"]
  };

  List<Map<String, dynamic>> orderedInnings = [];
  int selectedTabIndex = 0;
  int passingValue = 1;

  dynamic teamAId;
  dynamic teamBId;
  dynamic teamAInnings;
  dynamic teamBInnings;
  dynamic maxLength;
  dynamic currentRunRate;
  dynamic RequiredRunRate;
  dynamic teamAIndex;
  dynamic teamBIndex;
  String teamAName ="";
  String teamBName ="";
  List<BattersDetails>? batters;
  List<BowlersDetails>? bowlers;
  late ExtrasDetails teamAExtras;
  late ExtrasDetails teamBExtras;
  List<TeamLineupsDetails>? teamALineUp;
  List<TeamLineupsDetails>? teamBLineUp;
  List<FallOfWicketsDetails>? fallOfWicketsteamA = [];
  List<FallOfWicketsDetails>? fallOfWicketsteamB = [];
  List<PartnershipsDetails>? partnerships = [];
  List<YetToBatDetails>? yetToBat = [];
  List<OverSummariesDetails>? overSummaries = [];

  void initState() {
    print("selected match");
    // log(widget.matchList);

    BlocProvider.of<LiveScoreCubit>(context).getMatchDetails(widget.matchId);

    _scrollController = ScrollController();

    // Scroll to max after first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });

    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "${teamAName} vs ${teamBName}",
                  // data: "dsads",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              "assets/images/backicon.png",
              height: 0,
            ),
          ).onTap(() {
            Navigator.of(context).pop();
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: BlocConsumer<LiveScoreCubit, LiveScoreState>(
            listener: (context, state) {
              if (state.status == LiveScoreStatus.matchDetailsSuccess) {
                finishedMatchDetailsResponse = state.responseData?.response
                    as FinishedMatchDetailsResponse;

                if (finishedMatchDetailsResponse.data != null) {
                  teamAId = finishedMatchDetailsResponse.data?.teamAId ?? 0;
                  teamBId = finishedMatchDetailsResponse.data?.teamBId;
                  teamAInnings = finishedMatchDetailsResponse.data?.innings
                      ?.where((inning) => inning.battingTeam?.teamId == teamAId)
                      .toList();
                  if (teamAInnings != null) {
                    for (var inning in teamAInnings) {
                      if (inning.fallOfWickets != null) {
                        fallOfWicketsteamA?.addAll(inning.fallOfWickets!);
                      }
                      if (inning.partnerships != null) {
                        partnerships?.addAll(inning.partnerships!);
                      }
                      if (inning.extras != null) {
                        teamAExtras = inning.extras;
                      }
                    }
                  }

                  teamBInnings = finishedMatchDetailsResponse.data?.innings
                      ?.where((inning) => inning.battingTeam?.teamId == teamBId)
                      .toList();
                  if (teamBInnings != null) {
                    for (var inning in teamBInnings) {
                      if (inning.fallOfWickets != null) {
                        fallOfWicketsteamB?.addAll(inning.fallOfWickets!);
                      }
                      if (inning.partnerships != null) {
                        partnerships?.addAll(inning.partnerships!);
                      }
                      if (inning.extras != null) {
                        teamBExtras = inning.extras;
                      }
                    }
                  }

                  print("fall of wickets");
                  print(jsonEncode(fallOfWicketsteamA));
                  print(jsonEncode(teamAInnings));
                  print(jsonEncode(fallOfWicketsteamB));

                  _controller = TabController(length: 2, vsync: this);
                  // _controller2 = TabController(length: 2, vsync: this);
                  _controller2 = TabController(length: 0, vsync: this);

                  _controller2?.addListener(() {
                    if (_controller2?.indexIsChanging == false) {
                      setState(() {
                        selectedTabIndex = _controller2!.index;
                      });
                    }
                  });

                  final teamAId1 = finishedMatchDetailsResponse.data?.teamAId;
                  final teamBId2 = finishedMatchDetailsResponse.data?.teamBId;

                  teamAIndex = finishedMatchDetailsResponse.data?.teamLineups
                          ?.indexWhere((lineup) => lineup.teamId == teamAId1) ??
                      -1;
                  teamBIndex = finishedMatchDetailsResponse.data?.teamLineups
                          ?.indexWhere((lineup) => lineup.teamId == teamBId2) ??
                      -1;

                  print("jsonEncode(teamALineUp)");
                  print(jsonEncode(
                      finishedMatchDetailsResponse.data?.teamLineups));


                  teamAName = finishedMatchDetailsResponse.data?.teamAName.toString()??"";
                  teamBName = finishedMatchDetailsResponse.data?.teamBName.toString()??"";
                  setState(() {

                  });
                }
              }

              if (state.status == LiveScoreStatus.matchDetailsError) {
                Loader.hide();
                String message = state.errorData?.message ?? state.error ?? '';

                print(message);
                UiHelper.toastMessage(message);
              }
              // final updatedMatch = state.socketLiveData
              //     ?.expand((e) => e.matches ?? [])
              //     .firstWhere(
              //       (m) => m.fixtureId == widget.matchList.fixtureId,
              //   orElse: () => widget.matchList, // fallback to passed match
              // );

              print("teaALineUp");

              getAllInningsInitial();
            },
            builder: (context, state) {
              if (state.status == LiveScoreStatus.matchDetailsLoading) {
                Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff001548).withOpacity(0.7),
                        // border: Border.all(color: txtGrey),
                        // borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          2.h.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/indiaflag.png',
                                    scale: 3,
                                  ),
                                  1.heightBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 25.w,
                                        child: commonText(
                                          alignment: TextAlign.center,
                                          // data: updatedMatch?.teamAName ?? updatedMatch?.teamAId.toString() ?? '',
                                          data: finishedMatchDetailsResponse
                                                  .data?.teamAName ??
                                              finishedMatchDetailsResponse
                                                  .data?.teamAId
                                                  .toString() ??
                                              '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          color: Colors.grey.withOpacity(0.9),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: teamAInnings?.length != null
                                            ? teamAInnings!.length * 40.0
                                            : 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: ListView.builder(
                                          itemCount: teamAInnings?.length ?? 0,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, inningIndex) {
                                            final inning =
                                                teamAInnings![inningIndex];
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              width: 90,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  commonText(
                                                    data:
                                                        "${inning.battingTeam?.runs ?? 'N/A'}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data: "/",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data:
                                                        "${inning.battingTeam?.wickets ?? 'N/A'}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data:
                                                        " (${inning.battingTeam?.overs ?? 'N/A'} ov)",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ausflag.png',
                                    scale: 3,
                                  ),
                                  1.h.heightBox,
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      commonText(
                                        alignment: TextAlign.center,
                                        data: finishedMatchDetailsResponse
                                                .data?.teamBName
                                                .toString() ??
                                            "",
                                        // data: updatedMatch.teamBName.toString() ?? "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: Colors.grey.withOpacity(0.9),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: teamBInnings?.length != null
                                            ? teamBInnings!.length * 40.0
                                            : 40,
                                        child: ListView.builder(
                                          itemCount: teamBInnings?.length ?? 0,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, inningIndex) {
                                            final inning =
                                                teamBInnings![inningIndex];
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              width: 90,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  commonText(
                                                    data:
                                                        "${inning.battingTeam?.runs ?? 'N/A'}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data: "/",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data:
                                                        "${inning.battingTeam?.wickets ?? 'N/A'}",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                  commonText(
                                                    data:
                                                        " (${inning.battingTeam?.overs ?? 'N/A'} ov)",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: "Poppins",
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ).pSymmetric(h: 20),
                        ],
                      ).pSymmetric(h: 10),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isScoreCardSelected = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: isScoreCardSelected
                                      ? neonColor
                                      : Color.fromARGB(255, 226, 226, 226)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: commonText(
                                  data: "Scorecard",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isScoreCardSelected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: !isScoreCardSelected
                                      ? neonColor
                                      : Color.fromARGB(255, 226, 226, 226)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: commonText(
                                  data: "Lineup",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    isScoreCardSelected
                        ? Column(
                            children: [
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey5),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text('${widget.winningTeam} won',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700)),
                                    SizedBox(
                                      width: 10,
                                    )
                                    // Spacer(),
                                    // Text('India won by 8 wickets',
                                    //     style: TextStyle(
                                    //         color: Colors.black,
                                    //         fontSize: 10,
                                    //         fontWeight: FontWeight.w700))
                                  ],
                                ).pSymmetric(h: 10),
                              ),
                              overSummaries?.length != 0
                                  ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  child: ListView.builder(
                                    reverse: true,
                                    controller: _scrollController, // 👈 attach controller here

                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: overSummaries?.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          10))),
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(4.0),
                                                child: Center(
                                                  child: Text(
                                                      "Over ${((overSummaries?[index].overNumber ?? 0) + 1)}",
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              // width: MediaQuery.of(context)
                                              //     .size
                                              //     .width,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemCount:
                                                overSummaries?[index]
                                                    .balls
                                                    ?.length,
                                                itemBuilder:
                                                    (context, index1) {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                            Colors.grey),
                                                        shape:
                                                        BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(4.0),
                                                        child: Center(
                                                          child: Text(
                                                              "${overSummaries?[index].balls?[index1].toString() ?? ""}",
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                                  : SizedBox(),
                              SizedBox(
                                height: 8.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // Ensure left alignment of the column
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Removed unnecessary alignment inside container, it's redundant with CrossAxisAlignment.start
                                      TabBar(
                                        dividerColor: Colors.transparent,
                                        controller: _controller2,
                                        isScrollable: true,
                                        onTap: (index) {
                                          selectedTabIndex = index;
                                          passingValue = index + 1;

                                          // Perform your getAllInnings logic here
                                          getAllInnings();
                                        },
                                        indicator: BoxDecoration(
                                          color: neonColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        indicatorPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        labelPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.black,
                                        tabs: List.generate(allInnings.length,
                                            (index) {
                                          final inning = allInnings[index];
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: selectedTabIndex == index
                                                  ? neonColor
                                                  : const Color.fromARGB(
                                                      255, 226, 226, 226),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              // Replace with the correct team info
                                              '${inning['team']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                    isScoreCardSelected
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                batters?.length != 0
                                    ? ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Table(
                                              columnWidths: {
                                                0: FlexColumnWidth(2),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Text(
                                                        "Batter",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    for (final label in [
                                                      'R',
                                                      'B',
                                                      '4s',
                                                      '6s',
                                                      'S/R'
                                                    ])
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            label,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                            color: Colors.white,
                                            margin: EdgeInsets.all(10),
                                            child: Table(
                                              columnWidths: {
                                                0: FlexColumnWidth(2),
                                              },
                                              // border: TableBorder(
                                              //   horizontalInside:
                                              //   BorderSide(
                                              //       color: bgColor,
                                              //       width: 1.0),
                                              // ),
                                              children: [
                                                // Static Header

                                                // Dynamic Rows
                                                ...List.generate(
                                                    batters!.length, (index) {
                                                  final batter =
                                                      batters![index];
                                                  return TableRow(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 20,
                                                                horizontal: 6),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(batter.playerName
                                                                        .toString() ==
                                                                    "Unknown Player"
                                                                ? batter
                                                                    .playerId
                                                                    .toString()
                                                                : batter
                                                                    .playerName
                                                                    .toString()),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    width: 4),
                                                                batter
                                                                            .isOut ==
                                                                        true
                                                                    ? SizedBox( width: MediaQuery.of(
                                                                    context)
                                                                    .size
                                                                    .width *
                                                                    0.2,
                                                                      child: Text(
                                                                          batter
                                                                              .dismissal
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                    )
                                                                    : Icon(
                                                                        Icons
                                                                            .sports_cricket,
                                                                        size:
                                                                            16),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      for (final val in [
                                                        batter.runs
                                                                ?.toString() ??
                                                            '0',
                                                        batter.balls
                                                                ?.toString() ??
                                                            '0',
                                                        batter.fours
                                                                ?.toString() ??
                                                            '0',
                                                        batter.sixes
                                                                ?.toString() ??
                                                            '0',
                                                        (batter.strikeRate ?? 0)
                                                            .toStringAsFixed(2)
                                                      ])
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        20),
                                                            child: Text(
                                                              val,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Extras",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '${teamAExtras.total} '
                                                  '('
                                                  '${teamAExtras.byes != 0 ? 'b ${teamAExtras.byes}, ' : ''}'
                                                  '${teamAExtras.legByes != 0 ? 'lb ${teamAExtras.legByes}, ' : ''}'
                                                  '${teamAExtras.wides != 0 ? 'w ${teamAExtras.wides}, ' : ''}'
                                                  '${teamAExtras.noBalls != 0 ? 'nb ${teamAExtras.noBalls}, ' : ''}'
                                                  '${teamAExtras.penalty != 0 ? 'p ${teamAExtras.penalty}' : ''}'
                                                  ')',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          yetToBat?.length!=0?   Container(
                                            margin: const EdgeInsets.only(
                                                left: 10.0, right: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Yet to bat",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 10,
                                                          childAspectRatio:
                                                              2.5),
                                                  itemCount: yetToBat?.length,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    print("in the list");
                                                    print(yetToBat?[index]
                                                        .name
                                                        .toString());
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    226,
                                                                    226,
                                                                    226)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                child: Image.asset(
                                                                    "assets/images/iv_player_image.png"),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Center(
                                                                child: SizedBox(
                                                                  width: 100,
                                                                  child: Text(
                                                                    yetToBat?[index].name.toString() ==
                                                                            "null"
                                                                        ? '${yetToBat?[index].id}'
                                                                        : '${yetToBat?[index].name}',
                                                                    maxLines: 2,
                                                                    // textAlign: TextAlign.center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ):SizedBox(),
                                        ],
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 10,
                                ),
                                bowlers?.length != 0
                                    ? ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Table(
                                              columnWidths: {
                                                0: FlexColumnWidth(2),
                                              },
                                              children: [
                                                TableRow(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Text(
                                                        "Bowler",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    for (final label in [
                                                      'O',
                                                      'M',
                                                      'R',
                                                      'W',
                                                      'ECO'
                                                    ])
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Text(
                                                            label,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Card(
                                              color: Colors.white,
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 10),
                                              child: Table(
                                                columnWidths: {
                                                  0: FlexColumnWidth(2),
                                                },
                                                border: TableBorder(
                                                  horizontalInside: BorderSide(
                                                      color: bgColor,
                                                      width: 1.0),
                                                ),
                                                children: [
                                                  // Static Header

                                                  // Dynamic Rows
                                                  ...List.generate(
                                                      bowlers!.length, (index) {
                                                    final batter = bowlers![
                                                        index]; // Assuming each batter has relevant fields
                                                    return TableRow(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      6),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(batter.playerName
                                                                          .toString() ==
                                                                      "Unknown Player"
                                                                  ? batter
                                                                      .playerId
                                                                      .toString()
                                                                  : batter
                                                                      .playerName
                                                                      .toString()),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Icon(Icons.keyboard_arrow_down, size: 15),
                                                                  SizedBox(
                                                                      width: 4),
                                                                  // Expanded(
                                                                  //     child: batter
                                                                  //         .isOut == true
                                                                  //         ? Text(
                                                                  //       batter.dismissal
                                                                  //           .toString(),
                                                                  //       // or whatever default text you prefer
                                                                  //       style: TextStyle(
                                                                  //           fontSize: 12),
                                                                  //     ) // or any icon you want
                                                                  //         : Icon(Icons
                                                                  //         .sports_cricket,
                                                                  //         size: 16)
                                                                  // )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        for (final val in [
                                                          batter.overs
                                                                  ?.toString() ??
                                                              '0',
                                                          batter.maidens
                                                                  .toString() ??
                                                              '0',
                                                          batter.runsConceded
                                                                  ?.toString() ??
                                                              '0',
                                                          batter.wickets
                                                                  ?.toString() ??
                                                              '0',
                                                          (batter.economyRate ??
                                                                  0)
                                                              .toStringAsFixed(
                                                                  2)
                                                        ])
                                                          Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          20),
                                                              child: Text(
                                                                val,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    );
                                                  }),
                                                ],
                                              ))
                                        ],
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  "Fall Of Wickets",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              for (final label in [
                                                'Score',
                                                'Over',
                                              ])
                                                Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: Text(
                                                      label,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.all(10),
                                      child: Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                        },
                                        // border: TableBorder(
                                        //   horizontalInside:
                                        //   BorderSide(
                                        //       color: bgColor,
                                        //       width: 1.0),
                                        // ),
                                        children: [
                                          // Static Header

                                          // Dynamic Rows
                                          ...List.generate(
                                              fallOfWicketsteamA!.length,
                                              (index) {
                                            final fallOfWickets =
                                                fallOfWicketsteamA![index];
                                            return TableRow(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 20,
                                                      horizontal: 6),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(fallOfWickets
                                                                  .playerName
                                                                  .toString() ==
                                                              "Unknown Player"
                                                          ? fallOfWickets
                                                              .playerId
                                                              .toString()
                                                          : fallOfWickets
                                                              .playerName
                                                              .toString()),
                                                    ],
                                                  ),
                                                ),
                                                for (final val in [
                                                  "${fallOfWickets.scoreAtFall?.toString()}-${fallOfWickets.wicketNumber?.toString()}" ??
                                                      '0',
                                                  "${fallOfWickets.overAtFall?.toString()}" ??
                                                      '0',
                                                ])
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 20),
                                                      child: Text(
                                                        val,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   margin: const EdgeInsets.only(
                                    //       left: 10.0, right: 10),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         "Extras",
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.white),
                                    //       ),
                                    //       Text(
                                    //         '${teamAExtras.total} '
                                    //             '('
                                    //             '${teamAExtras.byes != 0 ? 'b ${teamAExtras.byes}, ' : ''}'
                                    //             '${teamAExtras.legByes != 0 ? 'lb ${teamAExtras.legByes}, ' : ''}'
                                    //             '${teamAExtras.wides != 0 ? 'w ${teamAExtras.wides}, ' : ''}'
                                    //             '${teamAExtras.noBalls != 0 ? 'nb ${teamAExtras.noBalls}, ' : ''}'
                                    //             '${teamAExtras.penalty != 0 ? 'p ${teamAExtras.penalty}' : ''}'
                                    //             ')',
                                    //         style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white,
                                    //         ),
                                    //       )
                                    //
                                    //
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  "Partenership",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      color: Colors.white,
                                      margin: EdgeInsets.all(10),
                                      child: Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(2),
                                        },
                                        // border: TableBorder(
                                        //   horizontalInside:
                                        //   BorderSide(
                                        //       color: bgColor,
                                        //       width: 1.0),
                                        // ),
                                        children: [
                                          // Static Header

                                          // Dynamic Rows
                                          ...List.generate(partnerships!.length,
                                              (index) {
                                            final partnership =
                                                partnerships![index];
                                            return TableRow(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          commonText(
                                                              data:
                                                                  "${partnership.wicketNumber.toString()} Wicket",
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: commonText(
                                                                data:
                                                                    "${partnership.batsman1?.playerName.toString() == "Unknown Player" ? partnership.batsman1?.playerId.toString() : partnership.batsman1?.playerName.toString()}",
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          commonText(
                                                              data:
                                                                  "${partnership.batsman1?.runs.toString()}(${partnership.batsman1?.balls.toString()})",
                                                              fontSize: 14),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/iv_partenerships.png",
                                                            height: 25,
                                                            width: 25,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          commonText(
                                                              data:
                                                                  "${partnership.totalRuns.toString()}(${partnership.totalBalls.toString()})",
                                                              fontSize: 14),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            child: commonText(
                                                                data:
                                                                    "${partnership.batsman2?.playerName.toString() == "Unknown Player" ? partnership.batsman2?.playerId.toString() : partnership.batsman1?.playerName.toString()}",
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                alignment:
                                                                    TextAlign
                                                                        .end),
                                                          ),
                                                          commonText(
                                                              data:
                                                                  "${partnership.batsman2?.runs.toString()}(${partnership.batsman2?.balls.toString()})",
                                                              fontSize: 14),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   margin: const EdgeInsets.only(
                                    //       left: 10.0, right: 10),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         "Extras",
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.white),
                                    //       ),
                                    //       Text(
                                    //         '${teamAExtras.total} '
                                    //             '('
                                    //             '${teamAExtras.byes != 0 ? 'b ${teamAExtras.byes}, ' : ''}'
                                    //             '${teamAExtras.legByes != 0 ? 'lb ${teamAExtras.legByes}, ' : ''}'
                                    //             '${teamAExtras.wides != 0 ? 'w ${teamAExtras.wides}, ' : ''}'
                                    //             '${teamAExtras.noBalls != 0 ? 'nb ${teamAExtras.noBalls}, ' : ''}'
                                    //             '${teamAExtras.penalty != 0 ? 'p ${teamAExtras.penalty}' : ''}'
                                    //             ')',
                                    //         style: TextStyle(
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white,
                                    //         ),
                                    //       )
                                    //
                                    //
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          lineUpTeamA = true;
                                          isScoreCardSelected = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: lineUpTeamA
                                                ? neonColor
                                                : Color.fromARGB(
                                                    255, 226, 226, 226)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: commonText(
                                            data:
                                                "${finishedMatchDetailsResponse.data?.teamAName.toString() ?? ""}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          lineUpTeamA = false;
                                          isScoreCardSelected = false;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: !lineUpTeamA
                                                ? neonColor
                                                : Color.fromARGB(
                                                    255, 226, 226, 226)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: commonText(
                                            data:
                                                "${finishedMatchDetailsResponse.data?.teamBName.toString() ?? ""}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              lineUpTeamA
                                  ? SizedBox(
                                      height: (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamAIndex]
                                                  .lineup
                                                  ?.length ??
                                              0) *
                                          50.0,
                                      child: GridView.builder(
                                        itemCount: finishedMatchDetailsResponse
                                            .data
                                            ?.teamLineups?[teamAIndex]
                                            .lineup
                                            ?.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2.5,
                                                crossAxisSpacing: 15),
                                        itemBuilder: (context, index) {
                                          print("line team index length");
                                          print(finishedMatchDetailsResponse
                                              .data
                                              ?.teamLineups?[teamAIndex]
                                              .lineup
                                              ?.length);
                                          bool isCaptain = false;
                                          bool isWicketKeeper = false;

                                          if (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamAIndex]
                                                  .captainId ==
                                              finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamAIndex]
                                                  .lineup?[index]
                                                  .id) {
                                            isCaptain = true;
                                          } else {
                                            isCaptain = false;
                                          }
                                          if (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamAIndex]
                                                  .wicketKeeperId ==
                                              finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamAIndex]
                                                  .lineup?[index]
                                                  .id) {
                                            isWicketKeeper = true;
                                          } else {
                                            isWicketKeeper = false;
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color.fromARGB(
                                                      255, 226, 226, 226)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    finishedMatchDetailsResponse
                                                                .data
                                                                ?.teamLineups?[
                                                                    teamAIndex]
                                                                .lineup?[index]
                                                                .name ==
                                                            "Unknown Player"
                                                        ? Center(
                                                            child: commonText(
                                                              data:
                                                                  "${finishedMatchDetailsResponse.data?.teamLineups?[teamAIndex].lineup?[index].id ?? ""}"
                                                                  "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                              fontSize: 14,
                                                              maxLines: 2,
                                                              alignment:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : Center(
                                                            child: commonText(
                                                              data:
                                                                  "${finishedMatchDetailsResponse.data?.teamLineups?[teamAIndex].lineup?[index].name ?? ""}${isCaptain ? " (C)" : ""}",
                                                              fontSize: 13,
                                                              maxLines: 2,
                                                              alignment:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      height: (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamBIndex]
                                                  .lineup
                                                  ?.length ??
                                              0) *
                                          50.0,
                                      child: GridView.builder(
                                        itemCount: finishedMatchDetailsResponse
                                            .data
                                            ?.teamLineups?[teamBIndex]
                                            .lineup
                                            ?.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 2.5,
                                                crossAxisSpacing: 15),
                                        itemBuilder: (context, index) {
                                          print("line team index length");
                                          print(finishedMatchDetailsResponse
                                              .data
                                              ?.teamLineups?[teamBIndex]
                                              .lineup
                                              ?.length);
                                          bool isCaptain = false;
                                          bool isWicketKeeper = false;

                                          if (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamBIndex]
                                                  .captainId ==
                                              finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamBIndex]
                                                  .lineup?[index]
                                                  .id) {
                                            isCaptain = true;
                                          } else {
                                            isCaptain = false;
                                          }
                                          if (finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamBIndex]
                                                  .wicketKeeperId ==
                                              finishedMatchDetailsResponse
                                                  .data
                                                  ?.teamLineups?[teamBIndex]
                                                  .lineup?[index]
                                                  .id) {
                                            isWicketKeeper = true;
                                          } else {
                                            isWicketKeeper = false;
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color.fromARGB(
                                                      255, 226, 226, 226)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    finishedMatchDetailsResponse
                                                                .data
                                                                ?.teamLineups?[
                                                                    teamBIndex]
                                                                .lineup?[index]
                                                                .name ==
                                                            "Unknown Player"
                                                        ? Center(
                                                            child: commonText(
                                                              data:
                                                                  "${finishedMatchDetailsResponse.data?.teamLineups?[teamBIndex].lineup?[index].id ?? ""}"
                                                                  "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                              fontSize: 14,
                                                              maxLines: 2,
                                                              alignment:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )
                                                        : Center(
                                                            child: commonText(
                                                              data:
                                                                  "${finishedMatchDetailsResponse.data?.teamLineups?[teamBIndex].lineup?[index].name ?? ""}${isCaptain ? " (C)" : ""}",
                                                              fontSize: 13,
                                                              maxLines: 2,
                                                              alignment:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily:
                                                                  "Poppins",
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                            ],
                          )
                  ],
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void updateTabController() {
    _controller2 = TabController(length: allInnings.length, vsync: this);
  }

  void getAllInnings() {
    final maxLength = (teamAInnings?.length ?? 0) > (teamBInnings?.length ?? 0)
        ? (teamAInnings?.length ?? 0)
        : (teamBInnings?.length ?? 0);
    allInnings.clear();

    for (int i = 0; i < maxLength; i++) {
      if (i < (teamAInnings?.length ?? 0)) {
        final inning = teamAInnings![i];

        allInnings.add({
          // 'team': updatedMatch.teamAName ?? updatedMatch.teamAId.toString() ??'',
          'team': finishedMatchDetailsResponse.data?.teamAName ??
              finishedMatchDetailsResponse.data?.teamAId.toString() ??
              '',
          'runs': inning.battingTeam?.runs ?? "0",
          'wickets': inning.battingTeam?.wickets ?? "0",
          'overs': inning.battingTeam?.overs ?? '0.0',
          'inningData': inning,
        });
      }
      if (i < (teamBInnings?.length ?? 0)) {
        final inning = teamBInnings![i];
        allInnings.add({
          // 'team': updatedMatch.teamBName ?? updatedMatch.teamBId.toString() ?? '',
          'team': finishedMatchDetailsResponse.data?.teamBName ??
              finishedMatchDetailsResponse.data?.teamAId.toString() ??
              '',

          'runs': inning.battingTeam?.runs ?? "0",
          'wickets': inning.battingTeam?.wickets ?? "0",
          'overs': inning.battingTeam?.overs ?? '0.0',
          'inningData': inning,
        });
      }
    }
    print("all innings length");
    print(allInnings.length);
    print(passingValue);
    // log(allInnings[0]['inningData']);
    // log(allInnings[2]['inningData']);
    // log(allInnings[3]['inningData']);
    final selectedInning = allInnings[selectedTabIndex]['inningData'];
    batters = selectedInning.batters ?? [];
    print("batters names");
    print(jsonEncode(batters));

    // if (teamBInnings != null) {
    //   for (var inning in teamBInnings) {
    //     if (inning.fallOfWickets != null) {
    //       fallOfWicketsteamB?.addAll(inning.fallOfWickets!);
    //     }
    //     if (inning.extras != null) {
    //       teamBExtras = inning.extras;
    //     }
    //   }
    //
    // }

    if (selectedInning.fallOfWickets.length != 0) {
      fallOfWicketsteamA = selectedInning.fallOfWickets ?? [];
    }
    if (selectedInning.partnerships.length != 0) {
      partnerships = selectedInning.partnerships ?? [];
    }

    teamAExtras = selectedInning.extras;
    if (selectedInning.yetToBat != null) {
      yetToBat = selectedInning.yetToBat ?? [];
    }
    if (selectedInning.overSummaries != null) {
      overSummaries = (selectedInning.overSummaries ?? []).reversed.toList();
    }

    // if (teamAInnings != null) {
    //   for (var inning in teamAInnings) {
    //     if (inning.fallOfWickets != null) {
    //       fallOfWicketsteamA?.addAll(inning.fallOfWickets!);
    //     }
    //     if (inning.extras != null) {
    //       teamAExtras = inning.extras;
    //     }
    //   }
    //
    // }

    updateTabController();

    print("updatedMatch.toString()");
    // print(jsonEncode(overSummaries));
    debugPrint(jsonEncode(yetToBat), wrapWidth: 1024);
    debugPrint(jsonEncode(selectedInning), wrapWidth: 1024);

    setState(() {});
  }

  void getAllInningsInitial() {
    final maxLength = (teamAInnings?.length ?? 0) > (teamBInnings?.length ?? 0)
        ? (teamAInnings?.length ?? 0)
        : (teamBInnings?.length ?? 0);
    allInnings.clear();

    for (int i = 0; i < maxLength; i++) {
      if (i < (teamAInnings?.length ?? 0)) {
        final inning = teamAInnings![i];

        allInnings.add({
          // 'team': updatedMatch.teamAName ?? updatedMatch.teamAId.toString() ??'',
          'team': finishedMatchDetailsResponse.data?.teamAName ??
              finishedMatchDetailsResponse.data?.teamAId.toString() ??
              '',
          'runs': inning.battingTeam?.runs ?? "0",
          'wickets': inning.battingTeam?.wickets ?? "0",
          'overs': inning.battingTeam?.overs ?? '0.0',
          'inningData': inning,
        });
      }
      if (i < (teamBInnings?.length ?? 0)) {
        final inning = teamBInnings![i];
        allInnings.add({
          // 'team': updatedMatch.teamBName ?? updatedMatch.teamBId.toString() ?? '',
          'team': finishedMatchDetailsResponse.data?.teamBName ??
              finishedMatchDetailsResponse.data?.teamAId.toString() ??
              '',

          'runs': inning.battingTeam?.runs ?? "0",
          'wickets': inning.battingTeam?.wickets ?? "0",
          'overs': inning.battingTeam?.overs ?? '0.0',
          'inningData': inning,
        });
      }
    }
    print("all innings length");
    print(allInnings.length);
    print(passingValue);
    // log(allInnings[0]['inningData']);
    // log(allInnings[2]['inningData']);
    // log(allInnings[3]['inningData']);
    final selectedInning = allInnings[selectedTabIndex]['inningData'];
    batters = selectedInning.batters ?? [];
    bowlers = selectedInning.bowlers ?? [];
    print("batters names");
    print(jsonEncode(batters));

    if (selectedInning.fallOfWickets.length != 0) {
      fallOfWicketsteamA = selectedInning.fallOfWickets ?? [];
    }
    if (selectedInning.partnerships.length != 0) {
      partnerships = selectedInning.partnerships ?? [];
    }

    teamAExtras = selectedInning.extras;
    if (selectedInning.yetToBat != null) {
      yetToBat = selectedInning.yetToBat ?? [];
    }
    if (selectedInning.overSummaries != null) {
      overSummaries = (selectedInning.overSummaries ?? []).reversed.toList();
    }

    print("updatedMatch 2.toString()");
    // print(jsonEncode(yetToBat));
    // print(jsonEncode(overSummaries));
    debugPrint(jsonEncode(yetToBat), wrapWidth: 1024);


    // if (teamBInnings != null) {
    //   for (var inning in teamBInnings) {
    //     if (inning.fallOfWickets != null) {
    //       fallOfWicketsteamB?.addAll(inning.fallOfWickets!);
    //     }
    //     if (inning.extras != null) {
    //       teamBExtras = inning.extras;
    //     }
    //   }
    //
    // }
    //
    // if (teamAInnings != null) {
    //   for (var inning in teamAInnings) {
    //     if (inning.fallOfWickets != null) {
    //       fallOfWicketsteamA?.addAll(inning.fallOfWickets!);
    //     }
    //     if (inning.extras != null) {
    //       teamAExtras = inning.extras;
    //     }
    //   }

    // }

    updateTabController();
  }
}

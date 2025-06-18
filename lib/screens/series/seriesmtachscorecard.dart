import 'dart:convert';
import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/screens/home/live/live_lineup_tab.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../cubit/livescore_cubit.dart';
import '../../responses/socketlivematch.dart';

class SeriesMatchScorecardScreen extends StatefulWidget {
  final Matches matchList;
  String teamAName = "";
  String teamBName = "";

  SeriesMatchScorecardScreen(
      {super.key,
      required this.matchList,
      required this.teamAName,
      required this.teamBName});

  @override
  State<SeriesMatchScorecardScreen> createState() =>
      _SeriesMatchScorecardScreenState();
}

class _SeriesMatchScorecardScreenState extends State<SeriesMatchScorecardScreen>
    with TickerProviderStateMixin {
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  TabController? _controller;
  TabController? _controller2;
  int _currentIndex = 0;
  int _currentIndex2 = 0;
  bool isScoreCardSelected = true;
  late ScrollController _scrollController;

  bool lineUpTeamA = true;
  final allInnings = <Map<String, dynamic>>[];
  var students = {
    "id": ['123', '456', '789'],
    "firstName": ["old", "gold", "silver"],
    "surName": ["new", 'newwww', "newest"]
  };

  List<Map<String, dynamic>> orderedInnings = [];
  int selectedTabIndex = 0;

  dynamic teamAId;
  dynamic teamBId;
  dynamic teamAInnings;
  dynamic teamBInnings;
  dynamic maxLength;
  dynamic teamAIndex;
  dynamic teamBIndex;
  dynamic updatedMatch;
  num? currentRunRate;
  num? requiredRunRate;
  List<Batters>? batters;
  List<Bowlers>? bowlers;
  late Extras teamAExtras;
  late Extras teamBExtras;
  List<TeamLineups>? teamALineUp;
  List<TeamLineups>? teamAllPlayer;
  List<TeamLineups>? teamBatter;
  List<TeamLineups>? teamBowler;
  List<TeamLineups>? teamAllRounder;
  List<TeamLineups>? teamBLineUp;
  List<FallOfWickets>? fallOfWicketsteamA = [];
  List<FallOfWickets>? fallOfWicketsteamB = [];
  List<Partnerships>? partnerships = [];
  List<YetToBat>? yetToBat = [];
  List<OverSummaries>? overSummaries = [];

  String teamAName = "";
  String teamBName = "";

  void initState() {
    print("selected match");
    // log(widget.matchList);
    print(widget.matchList);
    // updatedMatch = state.socketLiveData
    //     ?.expand((e) => e.matches ?? [])
    //     .firstWhere(
    //       (m) => m.fixtureId == widget.matchList.fixtureId,
    //   orElse: () => widget.matchList, // fallback to passed match
    // );

    teamAId = widget.matchList.teamAId;
    teamBId = widget.matchList.teamBId;

    teamAName = widget.teamAName;
    teamBName = widget.teamBName;
    // teamAInnings = widget.matchList.innings
    //     ?.where((inning) => inning.battingTeam?.teamId == teamAId)
    //     .toList();

    teamAInnings = widget.matchList.innings
        ?.where((inning) => inning.inningNumber == 1)
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
          teamAExtras = inning.extras!;
        }
      }
    }

    // teamBInnings = widget.matchList.innings
    //     ?.where((inning) => inning.battingTeam?.teamId == teamBId)
    //     .toList();

    teamBInnings = widget.matchList.innings
        ?.where((inning) => inning.inningNumber == 2)
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
    final teamAId1 = widget.matchList.teamAId;
    final teamBId2 = widget.matchList.teamBId;

    print("team line up");
    print(widget.matchList.teamLineups?.length);
    print(widget.matchList.teamAId);

    teamAIndex = widget.matchList.teamLineups
            ?.indexWhere((lineup) => lineup.teamId == teamAId1) ??
        0;
    teamBIndex = widget.matchList.teamLineups
            ?.indexWhere((lineup) => lineup.teamId == teamBId2) ??
        1;

    print("Initial teamAIndex");

    if (teamAIndex == -1) {
      teamAIndex = 0;
    }
    if (teamBIndex == -1) {
      teamBIndex = 1;
    }
    print(teamAIndex);
    print(teamAId1);
    print(teamBId2);
    print(jsonEncode(widget.matchList.teamLineups));

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
                  data:
                      "${widget.matchList.teamAName.toString()} vs ${widget.matchList.teamBName.toString()}",
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
          child: BlocBuilder<LiveScoreCubit, LiveScoreState>(
            buildWhen: (prev, curr) =>
                curr.status == LiveScoreStatus.liveMatchSocketUpdate,
            builder: (context, state) {
              // Use updated match data from socket
              updatedMatch = state.socketLiveData
                  ?.expand((e) => e.matches ?? [])
                  .firstWhere(
                    (m) => m.fixtureId == widget.matchList.fixtureId,
                    orElse: () => widget.matchList, // fallback to passed match
                  );

              teamAId = updatedMatch.teamAId;
              teamBId = updatedMatch.teamBId;
              // teamAInnings = updatedMatch.innings
              //     ?.where((inning) => inning.battingTeam?.teamId == teamAId)
              //     .toList();

              // teamBInnings = updatedMatch.innings
              //     ?.where((inning) => inning.battingTeam?.teamId == teamBId)
              //     .toList();

              teamAInnings = updatedMatch.innings
                  ?.where((inning) => inning.inningNumber == 1 && inning.battingTeam?.teamId != null)
                  .toList();

              teamBInnings = updatedMatch.innings
                  ?.where((inning) => inning.inningNumber == 2 && inning.battingTeam?.teamId != null)
                  .toList();
              //
              // final inningsList =
              //     updatedMatch.innings ??
              //         [];

              // for (var inning in inningsList) {
              //   final teamId = inning.battingTeam?.teamId;
              //
              //   if (inning.inningNumber == 1) {
              //     if (teamId == match?.teamAId) {
              //       teamAName =
              //           match?.teamAName.toString() ?? "";
              //     } else if (teamId == match?.teamBId) {
              //       teamAName = match?.teamBName ?? "";
              //     }
              //   } else if (inning.inningNumber == 2) {
              //     if (teamId == match?.teamAId) {
              //       teamBName = match?.teamAName ?? "";
              //     } else if (teamId == match?.teamBId) {
              //       teamBName = match?.teamBName ?? "";
              //     }
              //   }
              // }

              // 1. Combine and label innings from both teams

              // final maxLength =
              //     (teamAInnings?.length ?? 0) > (teamBInnings?.length ?? 0)
              //         ? (teamAInnings?.length ?? 0)
              //         : (teamBInnings?.length ?? 0);
              //
              // for (int i = 0; i < maxLength; i++) {
              //   if (i < (teamAInnings?.length ?? 0)) {
              //     final inning = teamAInnings![i];
              //     allInnings.add({
              //       'team': updatedMatch.teamAName ??
              //           updatedMatch.teamAId.toString() ??
              //           '',
              //       'runs': inning.battingTeam?.runs ?? "0",
              //       'wickets': inning.battingTeam?.wickets ?? "0",
              //       'overs': inning.battingTeam?.overs ?? '0.0',
              //       'inningData': inning,
              //     });
              //   }
              //   if (i < (teamBInnings?.length ?? 0)) {
              //     final inning = teamBInnings![i];
              //     allInnings.add({
              //       'team': updatedMatch.teamBName ??
              //           updatedMatch.teamBId.toString() ??
              //           '',
              //       'runs': inning.battingTeam?.runs ?? "0",
              //       'wickets': inning.battingTeam?.wickets ?? "0",
              //       'overs': inning.battingTeam?.overs ?? '0.0',
              //       'inningData': inning,
              //     });
              //   }
              // }

              // for (var inning in teamAInnings ?? []) {
              //   allInnings.add({
              //     'team':updatedMatch?.teamAName ??
              //         updatedMatch?.teamAId.toString() ??
              //         '' , // or use teamAName dynamically
              //     'runs': inning.battingTeam?.runs ?? "0",
              //     'wickets': inning.battingTeam?.wickets ?? "0",
              //     'overs': inning.battingTeam?.overs ?? '0.0',
              //   });
              // }
              //
              // for (var inning in teamBInnings ?? []) {
              //   allInnings.add({
              //     'team': updatedMatch?.teamBName ??
              //         updatedMatch?.teamBId.toString() ??
              //         '', // or use teamBName dynamically
              //     'runs': inning.battingTeam?.runs ?? "0",
              //     'wickets': inning.battingTeam?.wickets ?? "0",
              //     'overs': inning.battingTeam?.overs ?? '0.0',
              //   });
              // }

              // updateTabController();

              getAllInningsInitial();

              print("updatedMatch.toString()");
              print(updatedMatch?.teamAName);
              print(allInnings.toString());
              // print(widget.matchList.teamLineups?[0].lineup?.length);
              print(teamBIndex);
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/indiaflag.png',
                                  scale: 3,
                                ),
                                1.heightBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 25.w,
                                      child: commonText(
                                        alignment: TextAlign.center,
                                        // data: updatedMatch?.teamAName ?? updatedMatch?.teamAId.toString() ?? '',
                                        data: widget.teamAName ?? '',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: ListView.builder(
                                        itemCount: teamAInnings?.length ?? 0,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, inningIndex) {
                                          final inning =
                                              teamAInnings![inningIndex];
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 5),
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
                                    SizedBox(
                                      width: 25.w,
                                      child: commonText(
                                        alignment: TextAlign.center,
                                        // data: updatedMatch?.teamAName ?? updatedMatch?.teamAId.toString() ?? '',
                                        data: widget.teamBName.toString() ?? '',
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
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: teamBInnings?.length != null
                                          ? teamBInnings!.length * 40.0
                                          : 40,
                                      child: ListView.builder(
                                        itemCount: teamBInnings?.length ?? 0,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, inningIndex) {
                                          final inning =
                                              teamBInnings![inningIndex];
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 5),
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
                  allInnings.length != 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isScoreCardSelected = true;
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: isScoreCardSelected
                                            ? neonColor
                                            : Color.fromARGB(
                                                255, 226, 226, 226)),
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
                        )
                      : SizedBox(),
                  isScoreCardSelected && allInnings.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.systemGrey5),
                              child: Row(
                                children: [
                                  Text('CRR: ${currentRunRate ?? "0.0"}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700)),
                                  Spacer(),
                                  requiredRunRate != null
                                      ? Text('RRR: ${requiredRunRate}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700))
                                      : SizedBox()
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
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: overSummaries?.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
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
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Center(
                                                      child: Text(
                                                          "Over ${((overSummaries?[index].overNumber ?? 0) + 1)}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
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
                                child: TabBar(
                                  dividerColor: Colors.transparent,
                                  controller: _controller2,
                                  isScrollable: true,

                                  onTap: (index) {
                                    selectedTabIndex = index;
                                    getAllInnings();
                                  },
                                  // indicator: BoxDecoration(
                                  //   color: neonColor,
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  indicatorPadding:
                                      EdgeInsets.symmetric(vertical: 5),
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.black,
                                  tabs:
                                      List.generate(allInnings.length, (index) {
                                    final inning = allInnings[index];
                                    return Container(
                                      height: 50,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: selectedTabIndex == index
                                            ? neonColor
                                            : const Color.fromARGB(
                                                255, 226, 226, 226),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${inning['team']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )),
                          ],
                        )
                      : SizedBox(),
                  isScoreCardSelected && allInnings.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  batters?.length != 0
                                      ? Container(
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
                                                          color: Colors.white),
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                  batters?.length != 0
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color:
                                                  CupertinoColors.systemGrey5),
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
                                                  batters?.length ?? 0,
                                                  (index) {
                                                final batter = batters![index];
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
                                                          Text(
                                                            batter.playerName
                                                                        .toString() ==
                                                                    "Unknown Player"
                                                                ? batter
                                                                    .playerId
                                                                    .toString()
                                                                : batter
                                                                    .playerName
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
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
                                                              batter.isOut ==
                                                                      true
                                                                  ? SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.2,
                                                                      child:
                                                                          Text(
                                                                        batter
                                                                            .dismissal
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .sports_cricket,
                                                                      size: 16),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    for (final val in [
                                                      batter.runs?.toString() ??
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
                                                                  vertical: 20),
                                                          child: Text(
                                                            val,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Extras",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          teamAExtras.total == 0
                                              ? '${teamAExtras.total}'
                                              : '${teamAExtras.total} '
                                                  '('
                                                  '${teamAExtras.byes != 0 ? 'b ${teamAExtras.byes} ' : ''}'
                                                  '${teamAExtras.legByes != 0 ? ', lb ${teamAExtras.legByes}' : ''}'
                                                  '${teamAExtras.wides != 0 ? ', w ${teamAExtras.wides}' : ''}'
                                                  '${teamAExtras.noBalls != 0 ? ', nb ${teamAExtras.noBalls}' : ''}'
                                                  '${teamAExtras.penalty != 0 ? ', p ${teamAExtras.penalty}' : ''}'
                                                  ')',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  yetToBat?.length != 0
                                      ? Container(
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
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              GridView.builder(
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 10,
                                                        childAspectRatio: 2.5),
                                                itemCount: yetToBat?.length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
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
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Color.fromARGB(
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
                                                                  yetToBat?[index]
                                                                              .name
                                                                              .toString() ==
                                                                          "Unknown Player"
                                                                      ? '${yetToBat?[index].id}'
                                                                      : '${yetToBat?[index].name}',
                                                                  maxLines: 2,
                                                                  // textAlign: TextAlign.center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            21,
                                                                            72,
                                                                            1),
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
                                        )
                                      : SizedBox(),
                                ],
                              ),
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
                                                          color: Colors.white),
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
                                                              color:
                                                                  Colors.white),
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
                                                    color: bgColor, width: 1.0),
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
                                                                horizontal: 6),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              batter.playerName
                                                                          .toString() ==
                                                                      "Unknown Player"
                                                                  ? batter
                                                                      .playerId
                                                                      .toString()
                                                                  : batter
                                                                      .playerName
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
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
                                            ))
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),
                              fallOfWicketsteamA!.length != 0
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
                                                              color:
                                                                  Colors.white),
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
                                                          Text(
                                                            fallOfWickets
                                                                        .playerName
                                                                        .toString() ==
                                                                    "Unknown Player"
                                                                ? fallOfWickets
                                                                    .playerId
                                                                    .toString()
                                                                : fallOfWickets
                                                                    .playerName
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
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
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 20),
                                                          child: Text(
                                                            val,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),
                              partnerships?.length != 0
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
                                              ...List.generate(
                                                  partnerships!.length,
                                                  (index) {
                                                final partnership =
                                                    partnerships![index];
                                                return TableRow(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
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
                                                                  color: Colors
                                                                      .grey),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.2,
                                                                child: commonText(
                                                                    data:
                                                                        "${partnership.batsman1?.playerName.toString() == "Unknown Player" ? partnership.batsman1?.playerId.toString() : partnership.batsman1?.playerName.toString()}",
                                                                    fontSize:
                                                                        14,
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
                                                                        "${partnership.batsman2?.playerName.toString() == "Unknown Player" ? partnership.batsman2?.playerId.toString() : partnership.batsman2?.playerName.toString()}",
                                                                    fontSize:
                                                                        14,
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
                                    )
                                  : SizedBox(),
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
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          lineUpTeamA = true;
                                          isScoreCardSelected = false;
                                        });
                                        print(jsonEncode(widget
                                            .matchList.teamLineups?[0].lineup));
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: lineUpTeamA
                                                ? neonColor
                                                : Color.fromARGB(
                                                    255, 226, 226, 226)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: commonText(
                                              data: widget.matchList.teamAName
                                                  .toString(),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
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

                                        print("all data");

                                        print(jsonEncode(widget
                                            .matchList.teamLineups?[1].lineup));
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: !lineUpTeamA
                                                ? neonColor
                                                : Color.fromARGB(
                                                    255, 226, 226, 226)),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: commonText(
                                              data: widget.matchList.teamBName
                                                  .toString(),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            lineUpTeamA
                                ? widget.matchList.teamLineups?.length != 0
                                    ? SizedBox(
                                        height: (widget
                                                    .matchList
                                                    .teamLineups?[teamAIndex]
                                                    .lineup
                                                    ?.length ??
                                                0) *
                                            50.0,
                                        child: GridView.builder(
                                          itemCount: widget
                                              .matchList
                                              .teamLineups?[teamAIndex]
                                              .lineup
                                              ?.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2.2,
                                                  crossAxisSpacing: 10),
                                          itemBuilder: (context, index) {
                                            print("line team index length");
                                            print(widget
                                                .matchList
                                                .teamLineups?[teamAIndex]
                                                .lineup
                                                ?.length);
                                            bool isCaptain = false;
                                            bool isWicketKeeper = false;

                                            if (widget
                                                    .matchList
                                                    .teamLineups?[teamAIndex]
                                                    .captainId ==
                                                widget
                                                    .matchList
                                                    .teamLineups?[teamAIndex]
                                                    .lineup?[index]
                                                    .id) {
                                              isCaptain = true;
                                            } else {
                                              isCaptain = false;
                                            }
                                            if (widget
                                                    .matchList
                                                    .teamLineups?[teamAIndex]
                                                    .wicketKeeperId ==
                                                widget
                                                    .matchList
                                                    .teamLineups?[teamAIndex]
                                                    .lineup?[index]
                                                    .id) {
                                              isWicketKeeper = true;
                                            } else {
                                              isWicketKeeper = false;
                                            }

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromARGB(
                                                        255, 226, 226, 226)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                          "assets/images/iv_player_image.png",
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      widget
                                                                  .matchList
                                                                  .teamLineups?[
                                                                      teamAIndex]
                                                                  .lineup?[
                                                                      index]
                                                                  .name ==
                                                              "Unknown Player"
                                                          ? Center(
                                                              child: SizedBox(
                                                                width: 90,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamAIndex].lineup?[index].id ?? ""}"
                                                                          "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                                      fontSize:
                                                                          14,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              21,
                                                                              72,
                                                                              1),
                                                                    ),
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamAIndex].lineup?[index].role.toString() == "Wicketkeeper" ? "WK-Batsman" : widget.matchList.teamLineups?[teamAIndex].lineup?[index].role}",
                                                                      fontSize:
                                                                          13,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              38,
                                                                              57,
                                                                              99,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : widget
                                                                      .matchList
                                                                      .teamLineups
                                                                      ?.length !=
                                                                  0
                                                              ? Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 90,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        commonText(
                                                                          data:
                                                                              "${widget.matchList.teamLineups?[teamAIndex].lineup?[index].name ?? ""}"
                                                                              "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                                          fontSize:
                                                                              13,
                                                                          maxLines:
                                                                              2,
                                                                          alignment:
                                                                              TextAlign.start,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              21,
                                                                              72,
                                                                              1),
                                                                        ),
                                                                        commonText(
                                                                          data:
                                                                              "${widget.matchList.teamLineups?[teamAIndex].lineup?[index].role.toString() == "WicketKeeper" ? "WK-Batsman" : widget.matchList.teamLineups?[teamAIndex].lineup?[index].role}",
                                                                          fontSize:
                                                                              13,
                                                                          maxLines:
                                                                              2,
                                                                          alignment:
                                                                              TextAlign.start,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          color: Color.fromRGBO(
                                                                              38,
                                                                              57,
                                                                              99,
                                                                              1),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox()
                                : widget.matchList.teamLineups?.length != 0
                                    ? SizedBox(
                                        height: (widget
                                                    .matchList
                                                    .teamLineups?[teamBIndex]
                                                    .lineup
                                                    ?.length ??
                                                0) *
                                            50.0,
                                        child: GridView.builder(
                                          itemCount: widget
                                              .matchList
                                              .teamLineups?[teamBIndex]
                                              .lineup
                                              ?.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 2.2,
                                                  crossAxisSpacing: 10),
                                          itemBuilder: (context, index) {
                                            print("line team index length");
                                            print(widget
                                                .matchList
                                                .teamLineups?[teamBIndex]
                                                .lineup
                                                ?.length);
                                            bool isCaptain = false;
                                            bool isWicketKeeper = false;

                                            if (widget
                                                    .matchList
                                                    .teamLineups?[teamBIndex]
                                                    .captainId ==
                                                widget
                                                    .matchList
                                                    .teamLineups?[teamBIndex]
                                                    .lineup?[index]
                                                    .id) {
                                              isCaptain = true;
                                            } else {
                                              isCaptain = false;
                                            }
                                            if (widget
                                                    .matchList
                                                    .teamLineups?[teamBIndex]
                                                    .wicketKeeperId ==
                                                widget
                                                    .matchList
                                                    .teamLineups?[teamBIndex]
                                                    .lineup?[index]
                                                    .id) {
                                              isWicketKeeper = true;
                                            } else {
                                              isWicketKeeper = false;
                                            }

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color.fromARGB(
                                                        255, 226, 226, 226)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                        child: Image.asset(
                                                          "assets/images/iv_player_image.png",
                                                          height: 50,
                                                          width: 50,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      widget
                                                                  .matchList
                                                                  .teamLineups?[
                                                                      teamBIndex]
                                                                  .lineup?[
                                                                      index]
                                                                  .name ==
                                                              "Unknown Player"
                                                          ? Center(
                                                              child: SizedBox(
                                                                width: 90,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamBIndex].lineup?[index].id ?? ""}"
                                                                          "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                                      fontSize:
                                                                          14,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              0,
                                                                              21,
                                                                              72,
                                                                              1),
                                                                    ),
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamBIndex].lineup?[index].role.toString() == "Wicketkeeper" ? "WK-Batsman" : widget.matchList.teamLineups?[teamBIndex].lineup?[index].role}",
                                                                      fontSize:
                                                                          13,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              38,
                                                                              57,
                                                                              99,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Center(
                                                              child: SizedBox(
                                                                width: 90,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamBIndex].lineup?[index].name ?? ""}"
                                                                          "${isCaptain ? " (C)" : ""}${isWicketKeeper ? " (WK)" : ""}",
                                                                      fontSize:
                                                                          13,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    commonText(
                                                                      data:
                                                                          "${widget.matchList.teamLineups?[teamBIndex].lineup?[index].role.toString() == "WicketKeeper" ? "WK-Batsman" : widget.matchList.teamLineups?[teamBIndex].lineup?[index].role}",
                                                                      fontSize:
                                                                          13,
                                                                      maxLines:
                                                                          2,
                                                                      alignment:
                                                                          TextAlign
                                                                              .start,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              38,
                                                                              57,
                                                                              99,
                                                                              1),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox()
                          ],
                        )
                ],
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
          'team': widget.teamAName,
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
          'team': widget.teamBName,

          'runs': inning.battingTeam?.runs ?? "0",
          'wickets': inning.battingTeam?.wickets ?? "0",
          'overs': inning.battingTeam?.overs ?? '0.0',
          'inningData': inning,
        });
      }
    }
    print("all innings length");
    print(allInnings.length);

    if (allInnings.length != 0) {
      final selectedInning = allInnings[selectedTabIndex]['inningData'];
      batters = selectedInning.batters ?? [];
      bowlers = selectedInning.bowlers ?? [];
      print("batters names");
      print(jsonEncode(widget.matchList.innings?[0].yetToBat));
      print(jsonEncode(widget.matchList.innings?[1].yetToBat));

      if (selectedInning.fallOfWickets.length != 0) {
        fallOfWicketsteamA = selectedInning.fallOfWickets ?? [];
      }
      if (selectedInning.partnerships.length != 0) {
        partnerships = selectedInning.partnerships ?? [];
      }

      teamAExtras = selectedInning.extras;
      if (selectedInning.yetToBat.length != 0) {
        print("Coming in yet to bet");
        print(jsonEncode(selectedInning.yetToBat));
        yetToBat = selectedInning.yetToBat ?? [];
      }
      if (selectedInning.overSummaries != null) {
        overSummaries = (selectedInning.overSummaries ?? []).reversed.toList();
      }

      var innings = widget.matchList.innings ?? [];

      // double? currentRunRate;
      // double? requiredRunRate;

      if (innings.isNotEmpty) {
        // Sort innings by inningNumber to ensure order
        innings.sort(
            (a, b) => (a.inningNumber ?? 0).compareTo(b.inningNumber ?? 0));

        final firstInning = innings.length > 0 ? innings[0] : null;
        final secondInning = innings.length > 1 ? innings[1] : null;

        print(
            "Inning 1 - CRR: ${firstInning?.currentRunRate}, RRR: ${firstInning?.requiredRunRate}");
        print(
            "Inning 2 - CRR: ${secondInning?.currentRunRate}, RRR: ${secondInning?.requiredRunRate}");

        // Priority: If second inning has both values
        if (secondInning?.currentRunRate != null &&
            secondInning?.requiredRunRate != null &&
            secondInning!.currentRunRate != 0.0 &&
            secondInning.requiredRunRate != 0.0) {
          currentRunRate = secondInning.currentRunRate?.toDouble();
          requiredRunRate = secondInning.requiredRunRate;
          print("✅ Used values from 2nd inning.");
        } else {
          // Fallback to available values

          if (secondInning?.currentRunRate != null &&
              secondInning!.currentRunRate != 0.0) {
            currentRunRate = secondInning.currentRunRate?.toDouble();
            print("✅ Used currentRunRate from 2nd inning.");
          } else if (firstInning?.currentRunRate != null &&
              firstInning!.currentRunRate != 0.0) {
            currentRunRate = firstInning.currentRunRate?.toDouble();
            print("✅ Used currentRunRate from 1st inning.");
          }

          if (secondInning?.requiredRunRate != null &&
              secondInning!.requiredRunRate != 0.0) {
            requiredRunRate = secondInning.requiredRunRate;
            print("✅ Used requiredRunRate from 2nd inning.");
          }
        }
      }

      print("✅ Final Required Run Rate: $requiredRunRate");
      print("✅ Yet to bat: ${currentRunRate}");

      debugPrint("Yet to bat: ${jsonEncode(yetToBat)}", wrapWidth: 1024);
      debugPrint("Selected Inning: ${jsonEncode(selectedInning)}",
          wrapWidth: 1024);

      updateTabController();
    }
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
          'team': widget.matchList.teamAName ??
              widget.matchList.teamAId.toString() ??
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
          'team': widget.matchList.teamBName ??
              widget.matchList.teamAId.toString() ??
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
    // log(allInnings[0]['inningData']);
    // log(allInnings[2]['inningData']);
    // log(allInnings[3]['inningData']);
    final selectedInning = allInnings[selectedTabIndex]['inningData'];
    batters = selectedInning.batters ?? [];

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

    var innings = widget.matchList.innings ?? [];

    if (innings.isNotEmpty) {
      // Sort innings based on inningNumber just in case
      innings
          .sort((a, b) => (a.inningNumber ?? 0).compareTo(b.inningNumber ?? 0));

      final lastInning = innings.last;
      final inningCount = innings.length;

      // For currentRunRate, always use last inning
      currentRunRate = lastInning.currentRunRate;

      // For requiredRunRate, use only if 2nd or 4th innings
      if (inningCount == 2 || inningCount == 4) {
        requiredRunRate = lastInning.requiredRunRate;
      } else {
        // requiredRunRate = null;
        currentRunRate = lastInning.currentRunRate;
      }
    }

    print("Yet to bat 2");
    debugPrint(jsonEncode(yetToBat), wrapWidth: 1024);
    debugPrint(jsonEncode(selectedInning), wrapWidth: 1024);
    print(requiredRunRate.toString());

    updateTabController();

    setState(() {});
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/get_country_code_abd_flag_response.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shortform.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants.dart';
import '../../../responses/socketlivematch.dart';
import '../../series/seriesmtachapiscorecard.dart';
import '../../series/seriesmtachscorecard.dart';
import '../socket/WebSocketService.dart';
import 'dart:developer' as developer;

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>
    with AutomaticKeepAliveClientMixin {
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  GetCountryCodeAndFlagResponse getCountryCodeAndFlagResponse =
      GetCountryCodeAndFlagResponse();

  final stompService = StompWebSocketService();

  List<SocketLiveMatchResponse>? liveData;
  List<SocketLiveMatchResponse>? _latestLiveData;

  @override
  void initState() {
    super.initState();

    _connectToSocket();

    liveMatchApi();

    // Expanded tile controller init
    _controller = ExpandedTileController(isExpanded: true);
    isTrue = _controller.isExpanded;
  }

  void sendMessage() {
    stompService.sendMessage(
      destination: '/app/send', // change based on your backend
      body: '{"type":"chat","content":"Hello"}',
    );
  }

  @override
  void dispose() {
    StompWebSocketService().disconnect(); // disconnect socket
    _controller.dispose(); // if your controller needs disposal
    super.dispose();
  }

  Future<void> _getLiveScoreApi() async {
    await BlocProvider.of<LiveScoreCubit>(context).getLiveScoreCall();
  }

  Future<void> _getLiveScoreApi2() async {
    await BlocProvider.of<LiveScoreCubit>(context).getLiveScoreCall1();
  }

  late ExpandedTileController _controller;
  ExpandedTileController controller3 =
      ExpandedTileController(isExpanded: false);
  bool? isTrue;
  List<bool> isTrueList = [false, false];
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    super.build(context); // required for AutomaticKeepAliveClientMixin

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
        listener: (context, state) {
          print("sate.status:${state.status}");
          print("sate.status:${jsonEncode(liveData)}");
          if (state.status == LiveScoreStatus.liveApiSuccess) {
            Loader.hide();

            // Cast the response to your expected list of models

            final parsed =
                state.responseData?.response as List<SocketLiveMatchResponse>;
            liveData =
                state.responseData?.response as List<SocketLiveMatchResponse>;

            _latestLiveData = parsed;

            if (mounted) {
              setState(() {
                liveData = parsed;
                context.read<LiveScoreCubit>().updateLiveDataFromSocket(parsed);
              });

              print("📡 Live data from API");
              // print(liveData?[0].matches?[1].innings?[0].yetToBat?.length);
              // debugPrint(jsonEncode(liveData?[0].matches?[1].innings?[0].yetToBat?[0].id.toString()), wrapWidth: 1024);
            } else {
              print("📦 Data updated from API (UI not visible)");
            }
          }

          if (state.status == LiveScoreStatus.liveScoreSuccess1) {
            // Loader.hide();
            liveScoreResponse =
                state.responseData?.response as LiveScoreResponse;
          }
          if (state.status == LiveScoreStatus.getCountryCodeAndFlagSuccess) {
            getCountryCodeAndFlagResponse =
                state.responseData?.response as GetCountryCodeAndFlagResponse;
            //   countryUtils.teamShortFormList.clear();
            teamShortFormList.clear();
            if (getCountryCodeAndFlagResponse.data != null &&
                getCountryCodeAndFlagResponse.data!.isNotEmpty) {
              //    countryUtils.teamShortFormList.addAll(getCountryCodeAndFlagResponse.data!);
              teamShortFormList.addAll(getCountryCodeAndFlagResponse.data!);
            }
          }
          if (state.status == LiveScoreStatus.liveApiError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            // UiHelper.toastMessage(message);
          }

          if (state.status == LiveScoreStatus.liveApiError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            // UiHelper.toastMessage(message);
          }
        },
        builder: (context, state) {
          if (state.status == LiveScoreStatus.liveApiLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (liveData == null) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return RefreshIndicator(
              onRefresh: againConnectToSocket,
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
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70.0),
                              child: mediumText14(
                                  textAlign: TextAlign.center,
                                  context,
                                  // error ?? '',
                                  "No Live Match Now",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  textColor: const Color(0xffFFFFFF)),
                            )
                            // statusCode == 401
                            //     ? mediumText14(
                            //         context,
                            //     // error ?? '',
                            //     "Coming Soon",
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w500,
                            //         textColor: const Color(0xffFFFFFF))
                            //     : mediumText14(
                            //         context, '$error\n\nClick to refresh.',
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w500,
                            //         textAlign: TextAlign.center,
                            //         textColor: const Color(0xffFFFFFF)),
                            ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.refresh,
                        //     color: Colors.white,
                        //     size: 35,
                        //   ),
                        //   onPressed: () {
                        //     _getLiveScoreApi();
                        //     // Handle refresh action here
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: againConnectToSocket,
            child: ExpandedTileList.builder(
                itemCount: liveData!.length.toInt(),
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
                      headerPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                                  data: liveData?[index].seriesName ??
                                      liveData![index].seriesId.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: white,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Divider(
                            thickness: 1.0,
                            color: buttonColors,
                          ),
                        ),
                      ],
                    ),
                    content: liveData?[index].matches?.length == 0
                        ? Center(
                            child: mediumText14(context, 'No match found',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                textColor: const Color(0xffFFFFFF)),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: liveData?[index].matches?.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {

                              print("All interupptions");
                              print(liveData?[index].matches?[i].interruptions?.reason.toString());
                              final teamAId =
                                  liveData?[index].matches?[i].teamAId;
                              final teamBId =
                                  liveData?[index].matches?[i].teamBId;
                              final teamAInnings = liveData?[index]
                                  .matches?[i]
                                  .innings
                                  ?.where((inning) =>
                                      inning.battingTeam?.teamId == teamAId)
                                  .toList();

                              final teamBInnings = liveData?[index]
                                  .matches?[i]
                                  .innings
                                  ?.where((inning) =>
                                      inning.battingTeam?.teamId == teamBId)
                                  .toList();

                              final tossWinnerTeamId = liveData?[index]
                                      .matches?[i]
                                      .tossInfo
                                      ?.tossWinnerTeamId ??
                                  0;
                              final tossDecision = liveData?[index]
                                      .matches?[i]
                                      .tossInfo
                                      ?.decision ??
                                  "";

                              String tossWinningTeamName = "Unknown";
                              if (tossWinnerTeamId != null) {
                                if (tossWinnerTeamId == teamAId) {
                                  tossWinningTeamName =
                                      liveData?[index].matches?[i].teamAName ??
                                          "Unknown";
                                } else if (tossWinnerTeamId == teamBId) {
                                  tossWinningTeamName =
                                      liveData?[index].matches?[i].teamBName ??
                                          "Unknown";
                                }
                              }

                              print(
                                  "Toss winner team$tossWinningTeamName and chose to $tossDecision");
                              print(
                                  "Toss winner team$teamAInnings and chose to $teamBInnings");

                              return GestureDetector(
                                onTap: () {
                                  final match = liveData?[index].matches?[i];

                                  if (match != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SeriesMatchScorecardScreen(
                                                matchList: match),
                                      ),
                                    );
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesMatchApiScorecardScreen(matchList: match),),);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonText(
                                              data:
                                                  "$tossWinningTeamName won the toss and chose to $tossDecision",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 25.w,
                                                      child: commonText(
                                                        alignment:
                                                            TextAlign.center,
                                                        data: liveData?[index]
                                                                    .matches?[i]
                                                                    .teamAName
                                                                    .toString() ==
                                                                "Unknown Team"
                                                            ? "${liveData?[index].matches?[i].teamAId.toString()}"
                                                            : "${liveData?[index].matches?[i].teamAName.toString()}",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    teamAInnings?.length != 0
                                                        ? Column(
                                                            children: [
                                                              SizedBox(
                                                                height: teamAInnings
                                                                            ?.length !=
                                                                        null
                                                                    ? teamAInnings!
                                                                            .length *
                                                                        40.0
                                                                    : 40,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.3,
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      teamAInnings
                                                                              ?.length ??
                                                                          0,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  itemBuilder:
                                                                      (context,
                                                                          inningIndex) {
                                                                    final inning =
                                                                        teamAInnings![
                                                                            inningIndex];
                                                                    return Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom:
                                                                              5),
                                                                      width: 90,
                                                                      height:
                                                                          30,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .green,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          commonText(
                                                                            data:
                                                                                "${inning.battingTeam?.runs ?? 'N/A'}",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          commonText(
                                                                            data:
                                                                                "/",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          commonText(
                                                                            data:
                                                                                "${inning.battingTeam?.wickets ?? 'N/A'}",
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                          commonText(
                                                                            data:
                                                                                " (${inning.battingTeam?.overs ?? 'N/A'} ov)",
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Text("Yet to bat"),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    commonText(
                                                      data: "• Live",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                      color: Colors.red,
                                                    ),

                                                    liveData?[index].matches?[i].interruptions!=null?

                                                    SizedBox(
                                                      width: 100,
                                                      child: commonText(
                                                        data: "${liveData?[index].matches?[i].interruptions?.reason.toString()}",
                                                        fontSize: 14,
                                                        alignment: TextAlign.center,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                        color: Colors.grey[700],
                                                      ),
                                                    )
                                                        :SizedBox()
                                                  ],
                                                ),
                                                Column(
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      child: commonText(
                                                        alignment:
                                                            TextAlign.center,
                                                        data: liveData?[index]
                                                                    .matches?[i]
                                                                    .teamBName
                                                                    .toString() ==
                                                                "Unknown Team"
                                                            ? "${liveData?[index].matches?[i].teamBId.toString()}"
                                                            : "${liveData?[index].matches?[i].teamBName.toString()}",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    teamBInnings?.length != 0
                                                        ? SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            height: teamBInnings
                                                                        ?.length !=
                                                                    null
                                                                ? teamBInnings!
                                                                        .length *
                                                                    40.0
                                                                : 40,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  teamBInnings
                                                                          ?.length ??
                                                                      0,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context,
                                                                  inningIndex) {
                                                                final inning =
                                                                    teamBInnings![
                                                                        inningIndex];
                                                                return Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              5),
                                                                  width: 90,
                                                                  height: 30,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      commonText(
                                                                        data:
                                                                            "${inning.battingTeam?.runs ?? 'N/A'}",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      commonText(
                                                                        data:
                                                                            "/",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      commonText(
                                                                        data:
                                                                            "${inning.battingTeam?.wickets ?? 'N/A'}",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      commonText(
                                                                        data:
                                                                            " (${inning.battingTeam?.overs ?? 'N/A'} ov)",
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : Text("Yet to bat"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
                }),
          );
        },
      ),
    );
  }

  Future<void> _refreshPage() async {
    await _getLiveScoreApi2();
  }

  void _connectToSocket() {
    isInternetConnected().then((value) {
      if (value == true) {
        // Restore previous live data if available
        if (_latestLiveData != null) {
          liveData = _latestLiveData!;

          log("live data in socket");
          log(_latestLiveData.toString());
        }

        // Only connect if not already connected
        if (!StompWebSocketService().isConnected) {
          StompWebSocketService().connect(
            topic: "/topic/scorecard",
            onMessage: (message) {
              try {
                final jsonData = json.decode(message);

                if (jsonData is List) {
                  final parsed = jsonData
                      .map<SocketLiveMatchResponse>(
                          (item) => SocketLiveMatchResponse.fromJson(item))
                      .toList();

                  _latestLiveData = parsed;

                  if (mounted) {
                    setState(() {
                      liveData = parsed;
                      context
                          .read<LiveScoreCubit>()
                          .updateLiveDataFromSocket(parsed);
                    });
                    log("Current Live data");

                    dynamic currentLiveData = liveData;
                    debugPrint(jsonEncode(liveData), wrapWidth: 1024);
                    log("Current Live data");
                  } else {
                    print("📦 Data updated in memory (UI not visible)");
                  }
                } else {
                  print(
                      "❌ Expected a list of JSON objects but got: ${jsonData
                          .runtimeType}");
                }

                // final jsonData = json.decode(message);
                // final parsed = SocketLiveMatchResponse.fromJson(jsonData);
                //
                // _latestLiveData = parsed;
                //
                // if (mounted) {
                //   setState(() {
                //     // liveData = parsed;
                //   });
                //   log("Live data");
                //   log(liveData.toString());
                // } else {
                //   print("📦 Data updated in memory (UI not visible)");
                // }
              } catch (e, stack) {
                print("❌ Error parsing or setting state: $e");
                print("🪵 Stack trace: $stack");
              }
            },
            onConnectCallback: () {
              print("🟢 Connected to topic");
            },
            onError: (error) {
              print("❗ Error: $error");
            },
          );
        }
      }else{
        showToast(context: context, message: notConnected);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> againConnectToSocket() async {
    // Restore previous live data if available

    isInternetConnected().then((value) async {
      if (value == true) {
        if (_latestLiveData != null) {
          liveData = _latestLiveData!;
        } else {
          liveMatchApi();
        }
        // Only connect if not already connected
        if (!StompWebSocketService().isConnected) {
          StompWebSocketService().connect(
            topic: "/topic/scorecard",
            onMessage: (message) {
              try {
                final jsonData = json.decode(message);

                if (jsonData is List) {
                  final parsed = jsonData
                      .map<SocketLiveMatchResponse>(
                          (item) => SocketLiveMatchResponse.fromJson(item))
                      .toList();

                  _latestLiveData = parsed;

                  if (mounted) {
                    setState(() {
                      liveData = parsed;
                    });
                    log("Live data updated");
                    debugPrint(jsonEncode(liveData), wrapWidth: 1024);
                    log("Live data updated ends");
                  } else {
                    print("📦 Data updated in memory (UI not visible)");
                  }
                } else {
                  print(
                      "❌ Expected a list of JSON objects but got: ${jsonData.runtimeType}");
                }

                // final parsed = SocketLiveMatchResponse.fromJson(jsonData);
                //
                // _latestLiveData = parsed;
                //
                // if (mounted) {
                //   setState(() {
                //     // liveData = parsed;
                //   });
                //
                //   log("Live data");
                //   log(liveData.toString());
                // } else {
                //   print("📦 Data updated in memory (UI not visible)");
                // }
              } catch (e, stack) {
                print("❌ Error parsing or setting state: $e");
                print("🪵 Stack trace: $stack");
              }
            },
            onConnectCallback: () {
              print("🟢 Connected to topic");
            },
            onError: (error) {
              print("❗ Error: $error");
            },
          );
        }
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }

  Future<void> liveMatchApi() async {
    isInternetConnected().then((value) async {
      if (value == true) {
        await BlocProvider.of<LiveScoreCubit>(context).getLiveMatchApiData();
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }
}

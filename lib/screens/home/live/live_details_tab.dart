import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shortform.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';



class LiveDetailsTab extends StatefulWidget {
  final LiveScoreResponse tmpLiveScoreResponse;
  const LiveDetailsTab({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);


  @override
  State<LiveDetailsTab> createState() => _LiveDetailsTabState();
}




class _LiveDetailsTabState extends State<LiveDetailsTab> {
  bool isHomeTeamBatting = false;
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  int tossWinnerTeamId = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _getLiveScoreDashboardApi1() async {
    BlocProvider.of<LiveScoreCubit>(context).getLiveScoreDashboardCall1();
  }

  String _getShortcutOfRunType(String value) {
    switch (value) {
      case 'NoBall':
        return "NB";
      case 'Wide':
        return "W";
      case 'Bye':
        return "B";
      case 'LegBye':
        return "LB";
      case 'Penalty':
        return "P";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;
    tossWinnerTeamId = data?.tossWinner?.csdId ?? 0;
    final expHomePlayerOrderList = data?.homeTeam?.players;
    final expAwayPlayerOrderList = data?.awayTeam?.players;
    expAwayPlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    expHomePlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));


    int? yetToPlayerCount = 0;


    if (isHomeTeamBatting) {
      yetToPlayerCount = (9 - (data?.homeTeam?.wickets ?? 0)) as int?;

    } else {
      yetToPlayerCount = (9 - (data?.awayTeam?.wickets ?? 0)) as int?;

    }
    print('isHomeTeamBatting:$isHomeTeamBatting');
    print('yetToPlayerCount:$yetToPlayerCount');
    return Scaffold(
        backgroundColor: bgColor,
        body: RefreshIndicator(
          onRefresh: _onRefreshPage,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                data?.status==null?
                Container(
                  height: 35,
                  color: greyColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mediumText14(context,
                           data?.tossWinner?.csdId==data?.homeTeam?.csdId?"${shortFormCountryCode(data?.homeTeam?.name??'')} Choose to ${data?.tossWinner?.decision??''}":
                           "${shortFormCountryCode(data?.awayTeam?.name??'')} Choose to ${data?.tossWinner?.decision??''}",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          textColor: primaryColors),
                      mediumText14(context,
                          data?.tossWinner?.csdId==data?.homeTeam?.csdId?"${shortFormCountryCode(data?.homeTeam?.name??'')} Won the toss":
                          "${shortFormCountryCode(data?.awayTeam?.name??'')} Won the toss",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          textColor: primaryColors),
                    ],
                  ).pOnly(left: 16,right: 16),
                ):
                Container(
                  height: 35,
                  color: greyColor,
                  child: Row(
                    mainAxisAlignment: data?.currentInning==1?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
                    children: [
                      commonText(
                          data: isHomeTeamBatting?"CRR: ${data?.homeTeam?.runRate.toStringAsFixed(2)??'0.0'}":"CRR: ${data?.awayTeam?.runRate.toStringAsFixed(2)??'0.0'}",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      data?.currentInning==1?const SizedBox():
                      commonText(
                          data: "RRR:${isHomeTeamBatting?data?.homeTeam?.requiredRunRate==null?'0.0':data?.homeTeam?.requiredRunRate.toStringAsFixed(2)??'':data?.awayTeam?.requiredRunRate==null?'0.0':data?.awayTeam?.requiredRunRate.toStringAsFixed(2)??''}",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      data?.currentInning==1?const SizedBox():
                      commonText(
                        //   data: "TN1 needs 00 run in 00 balls to win",
                          data: "${shortFormCountryCode(isHomeTeamBatting?data?.homeTeam?.name??'':data?.awayTeam?.name??'')} needs ${isHomeTeamBatting?data?.homeTeam?.requiredRuns.toString()??'':data?.awayTeam?.requiredRuns.toString()} run in ${data?.remainingBalls}",
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins",
                          color: primaryColors),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.only(left: 10, top: 6, bottom: 6, right: 10),
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(25)),
                      child: data?.currentOver==null?
                      commonText(
                        data: "Not Started",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        color: primaryColors,
                      ):
                      commonText(
                        // data: data?.currentOver==null?"Not Started":"Over ${data?.currentBall?.over.toString()}.${data?.currentBall?.ballNumber?.toString()}",
                        data: isHomeTeamBatting?"Over ${data?.homeTeam?.overs.toString()??''}.${data?.homeTeam?.balls.toString()??''}":
                        "Over ${data?.awayTeam?.overs.toString()??''}.${data?.awayTeam?.balls.toString()??''}",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        color: primaryColors,
                      )

                     /* child: mediumText14(context, isHomeTeamBatting?"${liveScoreResponse.data?.homeTeam?.overs.toString()??''}.${liveScoreResponse.data?.homeTeam?.balls.toString()??''}":
                      "${liveScoreResponse.data?.awayTeam?.overs.toString()??''}.${liveScoreResponse.data?.awayTeam?.balls.toString()??''}",
                          fontSize: 13, fontWeight: FontWeight.w400, textColor: primaryColors,),*/
                    ).p(15),
                    data?.currentOver==null?const SizedBox():
                    Expanded(
                      flex: 9,
                      child: SizedBox(
                        height: 30,
                        // width: 58.w,
                        child:ListView.builder(
                            shrinkWrap: true,
                            itemCount: data?.currentOver?.ballByBall?.length,
                            scrollDirection: Axis.horizontal,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              int? runByBall = 0;
                              String? runType = "";
                              data?.currentOver!.ballByBall![index].runs?.toJson().forEach((key, value) {
                                if (value != 0) {
                                  runByBall = value;
                                  runType = _getShortcutOfRunType(key);
                                }
                              });
                              print('runByBall:$runByBall');
                              print('runType:$runType');
                              return Container(
                                width: 32,
                                decoration: runByBall == 4 || runByBall == 6
                                    ? const BoxDecoration(
                                    shape: BoxShape.circle, color: buttonColors):
                                BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: disableColors)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      commonText(
                                        data: runByBall.toString(),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        color: runByBall == 4 || runByBall == 6 ? black : Colors.white,
                                      ),
                                      commonText(
                                        //  data: liveScoreResponse.data?.currentOver?.ballByBall![index].runs?.inField.toString()??'',
                                        data: runType.toString(),
                                        fontSize: 6,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                        color: runByBall == 4 || runByBall == 6 ? black : Colors.white,
                                      ).pOnly(top: 6),
                                    ],
                                  ),
                                ),
                              ).p(2);
                            }),
                      ),
                    ),
                    data?.currentOver==null?const SizedBox():
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: disableColors),
                        ),
                        child: Center(
                          child: commonText(
                            data: data?.currentOver?.runs.toString()??'',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            color: white,
                          ).pOnly(left: 8,right: 8,top: 4,bottom: 4),
                        ),
                      ).p(15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Info.png",
                      height: 13,
                      width: 13,
                      color: white,
                    ),
                    const SizedBox(width: 10),
                    commonText(
                        data: "Realtime Win %",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        color: white),
                  ],
                ),
                1.h.heightBox,
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        height: 38,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          // border: Border.all(color: primaryColors),
                          color: buttonColors,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, top: 3, bottom: 3, right: 3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: commonText(
                                data: "56 %",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black,
                              ),
                            ).pOnly(left: 10),
                            commonText(
                              data: "  TM1",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: primaryColors,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 38,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          // border: Border.all(color: primaryColors),
                          color: Color(0xff3A65F4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            commonText(
                              data: "TM1",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: white.withOpacity(0.8),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 5, top: 3, bottom: 3, right: 3),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: commonText(
                                data: "44 %",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black,
                              ),
                            ).pOnly(left: 10, right: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    commonText(
                        data: "Total Votes: 20K",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        color: white),
                  ],
                ).pOnly(right: 18),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: buttonColors,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: commonText(
                        data: "Bet",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Poppins",
                        color: black),
                  ),
                ).pOnly(left: 20, right: 20, top: 20),

                data?.status==null?Center(child: largeText16(context, 'Match not started yet',textColor: white,fontSize: 18)).pOnly(top: 100):
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18,),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width:double.infinity,
                      //      width: MediaQuery.of(context).size.width,
                      //   padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: disableColors),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: <Widget>[
                              Flexible(
                                flex: 7,
                                fit: FlexFit.tight,
                                child: mediumText14(context,
                                    "Batter",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ), //Container
                              ), //Flexible
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: mediumText14(context,
                                    "R",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ), //Container
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: mediumText14(context,
                                    "B",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ), //Container
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: mediumText14(context,
                                    "4s",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ), //Container
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: mediumText14(context,
                                    "6s",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ), //Container
                              ),
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: Center(
                                  child: mediumText14(context,
                                      "S/R",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      textColor: Colors.black
                                  ),
                                ), //Container
                              ),//Flexible
                            ],
                          ).pOnly(left: 18, right: 10,top: 20),
                          const SizedBox(height: 18,),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: data?.batsmen?.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return  Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          flex: 7,
                                          fit: FlexFit.tight,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: mediumText14(context,
                                                  data?.batsmen![index].shortName??'',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: Colors.black,
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              1.w.widthBox,
                                              data?.batsmen![index].isOnStrike==true?Padding(
                                                padding: const EdgeInsets.only(right:2),
                                                child: Image.asset(
                                                  "assets/images/bat.png",
                                                  scale: 3,
                                                ),
                                              ):const SizedBox(),
                                            ],
                                          ), //Container
                                        ), //Flexible
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: mediumText14(context,
                                              data?.batsmen![index].batsmanRuns.toString()??'',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ), //Container
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: mediumText14(context,
                                              data?.batsmen![index].balls.toString()??'',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ), //Container
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: mediumText14(context,
                                              data?.batsmen![index].fours.toString()??'',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ), //Container
                                        ),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: mediumText14(context,
                                              data?.batsmen![index].sixes.toString()??'',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ), //Container
                                        ),
                                        Flexible(
                                          flex: 3,
                                          fit: FlexFit.tight,
                                          child: Center(
                                            child: mediumText14(context,
                                                data?.batsmen![index].strikeRate!=null?data?.batsmen![index].strikeRate.toStringAsFixed(2)??'':"0.0",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                textColor: Colors.black
                                            ),
                                          ), //Container
                                        ),//Flexible

                                      ],
                                    ),
                                    const SizedBox(height: 12,)
                                  ],
                                );
                              }).pOnly(left: 14, right: 14,bottom: 24),
                          Container(
                            decoration: const BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            height: 3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    4.w.widthBox,
                                    Image.asset(
                                      'assets/images/partnership2.png',
                                      scale: 3,
                                    ),
                                    2.w.widthBox,
                                    commonText(
                                        data: isHomeTeamBatting?'${data?.homeTeam?.partnershipScore.toString()} (${data?.homeTeam?.partnershipBalls.toString()})':
                                        '${data?.awayTeam?.partnershipScore.toString()} (${data?.awayTeam?.partnershipBalls.toString()})',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ),
                                data?.lastBatsmanOut==null?const SizedBox():
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/LastWicket.png',
                                      scale: 3,
                                    ),
                                    2.w.widthBox,
                                    commonText(
                                        data:  data?.lastBatsmanOut?.shortName??'',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                    2.w.widthBox,
                                    commonText(
                                        data: '${data?.lastBatsmanOut?.batsmanRuns.toString()} (${data?.lastBatsmanOut?.balls.toString()})',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                    4.w.widthBox,
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ).pOnly(left: 20, right: 20),
                    2.h.heightBox,
                    data?.bowler==null?const SizedBox():
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: disableColors),
                      ),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 4,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mediumText14(context,
                                    "Bowler",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                  data?.bowler?.shortName??'',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  textColor: Colors.black,
                                  maxLines: 1,overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ), //Container
                          ), //Flexible
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mediumText14(context,
                                    "O",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                    data?.bowler?.overs.toString()??'',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black
                                ),
                              ],
                            ), //Container
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mediumText14(context,
                                    "M",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                    data?.bowler?.maidens.toString()??'',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black
                                ),
                              ],
                            ), //Container
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mediumText14(context,
                                    "R",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                    data?.bowler?.bowlerRuns.toString()??'',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black
                                ),
                              ],
                            ), //Container
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mediumText14(context,
                                    "W",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                    data?.bowler?.wickets.toString()??'',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black
                                ),
                              ],
                            ), //Container
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mediumText14(context,
                                    "ECON",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textColor: Colors.black
                                ),
                                const SizedBox(height: 12,),
                                mediumText14(context,
                                    data?.bowler?.economy==null?"0.0":data?.bowler?.economy.toStringAsFixed(2)??'',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textColor: Colors.black
                                ),
                              ],
                            ), //Container
                          ),//Flexible

                        ],
                      ),
                    ).pOnly(left: 20, right: 20),
                    1.h.heightBox,
                     const Text(
                      'Yet to Bat',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                     ).pOnly(left: 20, top: 30),

                    GridView.builder(
                   //     itemCount: isHomeTeamBatting?expHomePlayerOrderList?.length:expAwayPlayerOrderList?.length,
                        itemCount: yetToPlayerCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
                        itemBuilder: (context, index) {
                          int hidePlayerCount = 11 - yetToPlayerCount!;
                          print(hidePlayerCount);
                          int customIndex = index + hidePlayerCount;
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                2.w.widthBox,
                                CircleAvatar(
                                  backgroundColor: const Color(0xff001548),
                                  child: Image.asset(
                                    'assets/images/batternew.png',
                                    scale: 3,
                                  ),
                                ),
                                3.w.widthBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(isHomeTeamBatting?expHomePlayerOrderList![customIndex].shortName??'': expAwayPlayerOrderList![customIndex].shortName??'',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        isHomeTeamBatting?commonText(
                                            data: expHomePlayerOrderList![customIndex].strikeRate==null? "0.0":
                                            "SR: ${expHomePlayerOrderList[customIndex].strikeRate.toStringAsFixed(2)??''}",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: primaryColors):
                                        commonText(
                                            data: expAwayPlayerOrderList![customIndex].strikeRate==null? "0.0":
                                            "SR: ${expAwayPlayerOrderList[customIndex].strikeRate.toStringAsFixed(2)??''}",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: primaryColors),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }).pOnly(left: 10, right: 10),

                    2.h.heightBox,
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: disableColors),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SvgCustomWidget(imageUrl: getCountryFlag(data?.homeTeam?.name??''),),
                                  const SizedBox(width: 12,),
                                  isHomeTeamBatting?Image.asset(
                                    'assets/images/bat.png',
                                    scale: 3,
                                  ):const SizedBox(),
                                ],
                              ),
                              1.h.heightBox,
                              commonText(
                                  data: isHomeTeamBatting||data?.currentInning==2?"${data?.homeTeam?.score.toString()??''}-${data?.homeTeam?.wickets.toString()??''}":
                                  "Not yet",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: primaryColors)
                            ],
                          ),
                          Column(
                            children: [
                              1.h.heightBox,
                              commonText(
                                  data: isHomeTeamBatting?"${data?.homeTeam?.overs.toString()??''}.${data?.homeTeam?.balls.toString()??''}":
                                  "${data?.awayTeam?.overs.toString()??''}.${data?.awayTeam?.balls.toString()??''}",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: primaryColors)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  isHomeTeamBatting==false?Image.asset(
                                    'assets/images/bat.png',
                                    scale: 3,
                                  ):const SizedBox(),
                                  3.w.widthBox,
                                  SvgCustomWidget(imageUrl: getCountryFlag(data?.awayTeam?.name??'')),
                                ],
                              ),
                              1.h.heightBox,
                              commonText(
                                  data: isHomeTeamBatting==false ||data?.currentInning==2 ?"${data?.awayTeam?.score.toString()??''}-${data?.awayTeam?.wickets.toString()??''}":
                                  "Not yet",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: primaryColors)
                            ],
                          ),
                        ],
                      ).pSymmetric(h: 10, v: 10),
                    ).pOnly(left: 20, right: 20),
                    2.h.heightBox,
                  ],
                )
              ],
            ),
          ),
        )

    );
  }
  Future<void> _onRefreshPage() async{
    await _getLiveScoreDashboardApi1();
  }
}

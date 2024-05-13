import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';

class LiveMatchDetailsFirst extends StatefulWidget {
   final LiveScoreResponse tmpLiveScoreResponse;
    const LiveMatchDetailsFirst({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);

  @override
  State<LiveMatchDetailsFirst> createState() => _LiveMatchDetailsFirstState();
}

class _LiveMatchDetailsFirstState extends State<LiveMatchDetailsFirst> {
  bool isHomeTeamBatting = false;
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;
    print('isHomeTeamBatting:$isHomeTeamBatting');
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 35,
              color: greyColor,
              child: Row(
                mainAxisAlignment: data?.currentInning==1?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
                children: [
                  commonText(
                    //  data: "CRR: 9.04",
                      data: isHomeTeamBatting?"CRR: ${data?.homeTeam?.runRate.toStringAsFixed(2)}":"CRR: ${data?.awayTeam?.runRate.toStringAsFixed(2)}",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                  data?.currentInning==1?const SizedBox():
                  commonText(
                      data: isHomeTeamBatting?data?.homeTeam?.requiredRunRate.toString()??'':data?.awayTeam?.requiredRunRate.toString()??'',
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                  data?.currentInning==1?const SizedBox():
                  commonText(
                      data: "TN1 needs 00 run in 00 balls to win",
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
                  const EdgeInsets.only(left: 14, top: 6, bottom: 6, right: 14),
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: commonText(
                    data: data?.currentOver==null?"Not Started":"Over ${data?.currentOver?.overNumber.toString()}.${data?.currentOver?.ballByBall?.length.toString()}",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: primaryColors,
                  ),
                ).p(15),
                data?.currentOver==null?const SizedBox():
                SizedBox(
                  height: 30,
                  width: 50.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data?.currentOver?.ballByBall?.length,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        int? runByBall = 0;
                        data?.currentOver!.ballByBall![index].runs?.toJson().forEach((key, value) {
                          if (value != 0) {
                            runByBall = value;
                          }
                        });
                        print('runByBall:$runByBall');
                        return Container(
                          width: 35,
                          decoration: runByBall == 4 || runByBall == 6
                              ? const BoxDecoration(
                              shape: BoxShape.circle, color: buttonColors):
                          BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: disableColors)),
                          child: Center(
                            child: commonText(
                              //  data: liveScoreResponse.data?.currentOver?.ballByBall![index].runs?.inField.toString()??'',
                              data: runByBall.toString(),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: runByBall == 4 || runByBall == 6 ? black : Colors.white,
                            ),
                          ),
                        ).p(2);
                      }),
                ),
                data?.currentOver==null?const SizedBox():
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: disableColors),
                    ),
                    child: commonText(
                      data: data?.currentOver?.runs.toString()??'',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      color: white,
                    ).pSymmetric(h: 20, v: 2),
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
            Container(
              clipBehavior: Clip.hardEdge,
              width:double.infinity,
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: disableColors),
                  borderRadius: BorderRadius.circular(10)),
              child:  data?.batsmen?.length==0?Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 30),
                child: Center(child: mediumText14(context, 'Match Not started', textColor: Colors.black,fontSize: 14)),
              ):Column(
                children: [
                 Table(
                    columnWidths: const {0: FlexColumnWidth(2),},
                    border: const TableBorder(horizontalInside: BorderSide(color: white, width: 10.0)),
                    children: [
                      //This table row is for the table header which is static
                      const TableRow(
                          decoration: BoxDecoration(color: white),
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Batter",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "R",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "B",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "4s",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "6s",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "S/R",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
                          children:  [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: mediumText14(context,
                                      data?.batsmen![0].shortName.toString()??'',
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  data?.batsmen![0].isOnStrike==true?Image.asset(
                                    "assets/images/bat.png",
                                    scale: 3,
                                  ):const SizedBox(),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text( data?.batsmen![0].batsmanRuns.toString()??'',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(data?.batsmen![0].balls.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child:Text(data?.batsmen![0].fours.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child:Text(data?.batsmen![0].sixes.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(data?.batsmen![0].strikeRate.toStringAsFixed(2),),
                              ),
                            ),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
                          children:  [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: mediumText14(context,
                                      data?.batsmen![1].shortName.toString()??'',
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  3.w.widthBox,
                                  data?.batsmen![1].isOnStrike==true?Image.asset(
                                    "assets/images/bat.png",
                                    scale: 3,
                                  ):const SizedBox(),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text( data?.batsmen![1].batsmanRuns.toString()??'',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Text(data?.batsmen![1].balls.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child:Text(data?.batsmen![1].fours.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child:Text(data?.batsmen![1].sixes.toString()??'',),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                              //  child: Text(data?.batsmen![1].strikeRate.toStringAsFixed(2),),
                                child: Text(data?.batsmen![1].strikeRate.toString()??'',),
                              ),
                            ),
                          ]),
                    ],
                  ).pSymmetric(h: 10),
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
            ).p(20),

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
                            data?.bowler?.economy.toStringAsFixed(2)??'',
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
                          3.w.widthBox,
                          Image.asset(
                            'assets/images/indiaflag.png',
                            scale: 3,
                          ),
                          3.w.widthBox,
                          isHomeTeamBatting?Image.asset(
                            'assets/images/bat.png',
                            scale: 3,
                          ):const SizedBox(),
                        ],
                      ),
                      1.h.heightBox,
                      commonText(
                       /*   data: isHomeTeamBatting?"${data?.homeTeam?.score.toString()??''}-${data?.homeTeam?.wickets.toString()??''}":
                          "Not yet",*/
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
                          //data: "at 00.0 Overs",
                          data: "${data?.currentBall?.over.toString()??''}.${data?.currentBall?.ballNumber.toString()??''}",
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
                          Image.asset(
                            'assets/images/ausflag.png',
                            scale: 3,
                          ),

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
            2.h.heightBox
          ],
        ),
      )

    );
  }
}

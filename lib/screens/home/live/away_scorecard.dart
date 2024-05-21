import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/default_player_response.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
class AwayScorecard extends StatefulWidget {
  final LiveScoreResponse tmpLiveScoreResponse;
  const AwayScorecard({super.key, required this.tmpLiveScoreResponse});

  @override
  State<AwayScorecard> createState() => _AwayScorecardState();
}

class _AwayScorecardState extends State<AwayScorecard> {
  bool isHomeTeamBatting = false;


  Widget _wicketWidget(String value, String bowlerName, String catcherName) {
    print('value:$value');
    switch (value) {
      case AppConstants.bowled:
        return smallText12(context,
          "b $bowlerName",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.caught:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4,),
            smallText12(context,
              "b $bowlerName",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              maxLines: 1,overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4,),
            smallText12(context,
              "c $catcherName",
              fontSize: 11,
              fontWeight: FontWeight.w400,
              textColor: Colors.black,
              maxLines: 1,overflow: TextOverflow.ellipsis,
            ),

          ],
        ).pOnly(left: 4);
      case AppConstants.lBW:
        return smallText12(context,
          "lbw $bowlerName",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.runOut:
        return smallText12(context,
          "Run out",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.stumped:
        return smallText12(context,
          "Stumped",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.hitWicket:
        return smallText12(context,
          "Hit Wicket",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.handlingTheBall:
        return smallText12(context,
          "Handling the ball",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.hittingTheBallTwice:
        return smallText12(context,
          "Ball hit twice",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      case AppConstants.obstructingTheField:
        return smallText12(context,
          "Obs",
          fontSize: 11,
          fontWeight: FontWeight.w400,
          textColor: Colors.black,
          maxLines: 1,overflow: TextOverflow.ellipsis,
        ).pOnly(left: 4,top: 4);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;

    final actualAwayPlayerOrderList = data?.awayTeam?.players;
    final bowlingHomePlayerList = data?.homeTeam?.players;

    actualAwayPlayerOrderList?.sort((a, b) => a.actBatOrder.compareTo(b.actBatOrder));
    bowlingHomePlayerList?.sort((a, b) => a.bowlOrder.compareTo(b.bowlOrder));



    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14,right: 14),
          child: data?.status==null?Center(child: largeText16(context, 'Match not started yet',textColor: white,fontSize: 18)).pOnly(top: 100):Column(
            children: [
              1.h.heightBox,
              (isHomeTeamBatting==true&&data?.currentInning==1)?
              Padding(
                padding: const EdgeInsets.only(top: 100,bottom: 100),
                child: Center(child: mediumText14(context, 'Second Innings',textColor: white,fontSize: 20)),
              ):
              Column(
                children: [
                  2.h.heightBox,
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 7, fit: FlexFit.tight,
                        child: mediumText14(context, "Batter", fontSize: 14, fontWeight: FontWeight.w700, textColor: white).pOnly(left: 18), //Container
                      ), //Flexible
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "  R", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, " B", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "4s", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "6s", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 3, fit: FlexFit.tight,
                        child: Center(child: mediumText14(context, "S/R", fontSize: 14, fontWeight: FontWeight.w700, textColor: white)), //Container
                      ),
                    ],
                  ),
                  1.h.heightBox,
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: actualAwayPlayerOrderList?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        print(actualAwayPlayerOrderList![index].actBatOrder.toString());
                        String bowlerName = "Unknown";
                        String catcherName = "Unknown";
                       if(actualAwayPlayerOrderList![index].actBatOrder!=0){
                         int bowlerID =actualAwayPlayerOrderList[index].bowled??0;
                         int catcherID =actualAwayPlayerOrderList[index].caught??0;
                         print('bowlerID:$bowlerID');
                         var bowlerPlayers = data?.homeTeam?.players?.firstWhere(
                               (player) => player.csdId == bowlerID,
                           orElse: () => defaultPlayer,);
                         var catchPlayers = data?.homeTeam?.players?.firstWhere(
                               (player) => player.csdId == catcherID,
                           orElse: () => defaultPlayer,);
                         bowlerName = bowlerPlayers?.shortName ?? 'Unknown';
                         catcherName = catchPlayers?.shortName ?? 'Unknown';
                       }
                       print('bowlerName:$bowlerName');
                       print('catcherName:$catcherName');

                        Widget wicketWidget=  _wicketWidget(data?.awayTeam?.players![index].howOut.toString()??'',bowlerName,catcherName);

                        return  actualAwayPlayerOrderList[index].actBatOrder==0?const SizedBox():Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width:double.infinity,
                              padding: const EdgeInsets.only(left: 12,right: 8,top: 12,bottom: 12),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: disableColors),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 7,
                                        fit: FlexFit.tight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: mediumText14(context,
                                                    actualAwayPlayerOrderList[index].shortName??'',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: Colors.black,
                                                    maxLines: 1,overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                2.w.widthBox,
                                                actualAwayPlayerOrderList[index].isOnStrike==true?Image.asset(
                                                  "assets/images/bat.png",
                                                  scale: 3,
                                                ):const SizedBox(),
                                              ],
                                            ),
                                            actualAwayPlayerOrderList[index].howOut==null?const SizedBox():
                                            wicketWidget,
                                          ],
                                        ), //Container
                                      ), //Flexible
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            actualAwayPlayerOrderList[index].batsmanRuns.toString()??'',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            actualAwayPlayerOrderList[index].balls.toString()??'',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,actualAwayPlayerOrderList[index].fours==0?'  -':
                                        "  ${actualAwayPlayerOrderList[index].fours.toString()??''}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,actualAwayPlayerOrderList[index].sixes==0?'   -':
                                        "  ${actualAwayPlayerOrderList[index].sixes.toString()??''}",
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
                                              actualAwayPlayerOrderList[index].strikeRate!=null?actualAwayPlayerOrderList[index].strikeRate.toStringAsFixed(2)??'':"0.0",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ),
                                        ), //Container
                                      ),//Flexible
                                    ],
                                  ),

                                ],
                              ),
                           /*   child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 7,
                                        fit: FlexFit.tight,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: mediumText14(context,
                                                actualAwayPlayerOrderList[index].shortName??'',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                textColor: Colors.black,
                                                maxLines: 1,overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            2.w.widthBox,
                                            actualAwayPlayerOrderList[index].isOnStrike==true?Image.asset(
                                              "assets/images/bat.png",
                                              scale: 3,
                                            ):const SizedBox(),
                                          ],
                                        ), //Container
                                      ), //Flexible
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            actualAwayPlayerOrderList[index].batsmanRuns.toString()??'',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            actualAwayPlayerOrderList[index].balls.toString()??'',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,actualAwayPlayerOrderList[index].fours==0?'  -':
                                        "  ${actualAwayPlayerOrderList[index].fours.toString()??''}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,actualAwayPlayerOrderList[index].sixes==0?'   -':
                                        "  ${actualAwayPlayerOrderList[index].sixes.toString()??''}",
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
                                              actualAwayPlayerOrderList[index].strikeRate!=null?actualAwayPlayerOrderList[index].strikeRate.toStringAsFixed(2)??'':"0.0",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              textColor: Colors.black
                                          ),
                                        ), //Container
                                      ),//Flexible
                                    ],
                                  ),
                                  actualAwayPlayerOrderList[index].howOut==null?const SizedBox():
                                  Row(
                                    children: [
                                      smallText12(context, "b",fontSize: 9),
                                      2.w.widthBox,
                                      Flexible(
                                        child: mediumText14(context,
                                          bowlerName,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      2.w.widthBox,
                                      smallText12(context, "c",fontSize: 9),
                                      2.w.widthBox,
                                      Flexible(
                                        child: mediumText14(context,
                                          catcherName,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ).pOnly(top: 4),
                                ],
                              ),*/
                            ),
                            const SizedBox(height: 12,)
                          ],
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Extras:",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: white),
                      Row(
                        children: [
                          commonText(
                              data: (data?.awayTeam?.legByes + data?.awayTeam?.byes + data?.awayTeam?.noBalls + data?.awayTeam?.wides).toString(),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: white),
                          commonText(
                              data: " (b ${data?.awayTeam?.byes}, lb ${data?.awayTeam?.legByes}, w ${data?.awayTeam?.wides}, nb ${data?.awayTeam?.noBalls})",
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: white),
                        ],
                      )
                    ],
                  ).pOnly(left: 18, right: 18, top: 10),
                  6.h.heightBox,
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 4, fit: FlexFit.tight,
                        child: mediumText14(context, "Bowling", fontSize: 14, fontWeight: FontWeight.w700, textColor: white).pOnly(left: 18), //Container
                      ), //Flexible
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "  O", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, " M", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "R", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "W", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                      Flexible(
                        flex: 2, fit: FlexFit.tight,
                        child: mediumText14(context, "ER", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                      ),
                    ],
                  ),
                  const SizedBox(height: 18,),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: bowlingHomePlayerList?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return  bowlingHomePlayerList![index].bowlOrder==0?const SizedBox():
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              width:double.infinity,
                              padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: disableColors),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    flex: 4,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context, bowlingHomePlayerList![index].shortName??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black,
                                      maxLines: 1,overflow: TextOverflow.ellipsis,
                                    ), //Container
                                  ), //Flexible
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context,
                                        bowlingHomePlayerList[index].overs.toString()??'',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black
                                    ), //Container
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context,
                                        bowlingHomePlayerList[index].maidens.toString()??'',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black
                                    ), //Container
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context,
                                        bowlingHomePlayerList[index].bowlerRuns.toString()??'',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black
                                    ), //Container
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context, bowlingHomePlayerList[index].wickets.toString()??'',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black
                                    ), //Container
                                  ),
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: mediumText14(context,bowlingHomePlayerList[index].economy==null?'0.0':
                                    bowlingHomePlayerList[index].economy.toStringAsFixed(2)??'',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black
                                    ), //Container
                                  ),//Flexible

                                ],
                              ),
                            ),
                            const SizedBox(height: 12,)
                          ],
                        );
                      }),
                  const SizedBox(height: 18,),
                  data?.awayTeam?.fOW?.length==0?const SizedBox(): Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 8, fit: FlexFit.tight,
                            child: mediumText14(context, "Fall Of Wickets", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                          ),//Flexible
                          Flexible(
                            flex: 2, fit: FlexFit.tight,
                            child: mediumText14(context, "Score", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                          ),
                          Flexible(
                            flex: 2, fit: FlexFit.tight,
                            child: mediumText14(context, "Over", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                          ),
                        ],
                      ).pOnly(left: 18),
                      const SizedBox(height: 18,),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data?.awayTeam?.fOW?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            int playerId = data?.awayTeam?.fOW![index].bat;
                            print('playerId:$playerId');
                            var playerName = data?.awayTeam?.players?.firstWhere(
                                  (player) => player.csdId == playerId,);
                            String shortName = playerName?.shortName ?? 'Unknown';
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  width:double.infinity,
                                  padding: const EdgeInsets.only(left: 12,right: 12,top: 12,bottom: 12),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: disableColors),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 10,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                          shortName,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                        ), //Container
                                      ),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            "${data?.awayTeam?.fOW![index].runs}-${data?.awayTeam?.fOW![index].wkt}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),//Flexible
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: mediumText14(context,
                                            data?.awayTeam?.fOW![index].overs??'',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black
                                        ), //Container
                                      ),
                                      //Flexible

                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12,)
                              ],
                            );
                          }),
                      const SizedBox(height: 18,),
                      mediumText14(context, "Partnership", fontSize: 14, fontWeight: FontWeight.w700, textColor: white).pOnly(left: 12, right: 12),
                      const SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mediumText14(context, "Batter - 1", fontSize: 12, fontWeight: FontWeight.w500, textColor: const Color(0xff96A0B7)),
                          mediumText14(context, "Batter - 2", fontSize: 12, fontWeight: FontWeight.w500, textColor: const Color(0xff96A0B7)),
                        ],
                      ).pOnly(left: 12, right: 12),
                      const SizedBox(height: 18,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/Info.png",
                            height: 13,
                            width: 13,
                            color: white,
                          ),
                          SizedBox(width: 10),
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
                              margin: EdgeInsets.only(left: 20),
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
                      const SizedBox(height: 2),
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
                      const SizedBox(height: 2),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
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
                      ).pOnly(left: 20, right: 20, top: 20, bottom: 30),
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

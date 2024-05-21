import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/screens/home/live/away_scorecard.dart';
import 'package:kisma_livescore/screens/home/live/home_scorecard.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
class LiveScoreCardTab extends StatefulWidget {
  final LiveScoreResponse tmpLiveScoreResponse;
  const LiveScoreCardTab({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);

  @override
  State<LiveScoreCardTab> createState() => _LiveScoreCardTabState();
}

class _LiveScoreCardTabState extends State<LiveScoreCardTab> with TickerProviderStateMixin {
  bool isHomeTeamBatting = false;
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  bool hasHomeButtonClicked = true;
  TabController? _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;

    //Expected next batting player list
    final expHomePlayerOrderList = widget.tmpLiveScoreResponse.data?.homeTeam?.players;
    final expAwayPlayerOrderList = widget.tmpLiveScoreResponse.data?.awayTeam?.players;

    //Actual next batting player list
    final actualHomePlayerOrderList = widget.tmpLiveScoreResponse.data?.homeTeam?.players;
    final actualAwayPlayerOrderList = widget.tmpLiveScoreResponse.data?.awayTeam?.players;

    //bowling player list
    final bowlingHomePlayerList = widget.tmpLiveScoreResponse.data?.awayTeam?.players;
    final bowlingAwayPlayerList = widget.tmpLiveScoreResponse.data?.homeTeam?.players;

    expHomePlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    expAwayPlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));



    print('actualAwayPlayerOrderList:$actualAwayPlayerOrderList');

    actualHomePlayerOrderList?.sort((a, b) => a.actBatOrder.compareTo(b.actBatOrder));
    actualHomePlayerOrderList?.removeWhere((player) => player.actBatOrder == 0);

    actualAwayPlayerOrderList?.sort((a, b) => a.actBatOrder.compareTo(b.actBatOrder));
    actualAwayPlayerOrderList?.removeWhere((player) => player.actBatOrder == 0);



    bowlingHomePlayerList?.sort((a, b) => a.bowlOrder.compareTo(b.bowlOrder));
    bowlingHomePlayerList?.removeWhere((player) => player.bowlOrder == 0);

    bowlingAwayPlayerList?.sort((a, b) => a.bowlOrder.compareTo(b.bowlOrder));
    bowlingAwayPlayerList?.removeWhere((player) => player.bowlOrder == 0);




    print('isHomeTeamBatting:$isHomeTeamBatting');
    print('bowlingAwayPlayerList:$bowlingAwayPlayerList');

    int? yetToPlayerCount = 0;

    if (isHomeTeamBatting) {
      yetToPlayerCount = (9 - (data?.homeTeam?.wickets ?? 0)) as int?;
    } else {
      yetToPlayerCount = (9 - (data?.awayTeam?.wickets ?? 0)) as int?;
    }*/
    final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;

    final expHomePlayerOrderList = data?.homeTeam?.players;
    final expAwayPlayerOrderList = data?.awayTeam?.players;
    final actualHomePlayerOrderList = data?.homeTeam?.players;
    final actualAwayPlayerOrderList = data?.awayTeam?.players;
    final bowlingHomePlayerList = data?.homeTeam?.players;
    final bowlingAwayPlayerList = data?.awayTeam?.players;

    //  expHomePlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    // expAwayPlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    actualHomePlayerOrderList?.sort((a, b) => a.actBatOrder.compareTo(b.actBatOrder));
    actualAwayPlayerOrderList?.sort((a, b) => a.actBatOrder.compareTo(b.actBatOrder));
    bowlingHomePlayerList?.sort((a, b) => a.bowlOrder.compareTo(b.bowlOrder));
    bowlingAwayPlayerList?.sort((a, b) => a.bowlOrder.compareTo(b.bowlOrder));
    /* bowlingHomePlayerList?.removeWhere((player) => player.bowlOrder == 0);
    bowlingAwayPlayerList?.removeWhere((player) => player.bowlOrder == 0);
    actualAwayPlayerOrderList?.removeWhere((player) => player.actBatOrder == 0);
    actualHomePlayerOrderList?.removeWhere((player) => player.actBatOrder == 0);*/







    int? yetToPlayerCount = 0;

    if (isHomeTeamBatting) {
      yetToPlayerCount = (9 - (data?.homeTeam?.wickets ?? 0)) as int?;
    } else {
      yetToPlayerCount = (9 - (data?.awayTeam?.wickets ?? 0)) as int?;
    }


    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      data: "RRR:${isHomeTeamBatting?data?.homeTeam?.requiredRunRate.toStringAsFixed(2)??'':data?.awayTeam?.requiredRunRate.toStringAsFixed(2)??''}",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                  data?.currentInning==1?const SizedBox():
                  commonText(
                    //   data: "TN1 needs 00 run in 00 balls to win",
                      data: "${getInitials(isHomeTeamBatting?data?.homeTeam?.name??'':data?.awayTeam?.name??'')} needs ${isHomeTeamBatting?data?.homeTeam?.requiredRuns.toString()??'':data?.awayTeam?.requiredRuns.toString()} run in ${data?.remainingBalls}",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                ],
              ),
            ),
            1.h.heightBox,
            SizedBox(
              height: 46,
              child: AppBar(
                backgroundColor: const Color(0xff001548).withOpacity(0.7),
                bottom: ButtonsTabBar(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  radius: 6,
                  height: 45,
                  unselectedBackgroundColor: Colors.white,
                  decoration: BoxDecoration(color: neonColor),
                  controller: _controller,
                  tabs:  [
                    Tab(
                      child: Center(
                        child: Row(
                          children: [
                            commonText(
                                data: getInitials(data?.homeTeam?.name??''),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black),
                            commonText(
                                data: "  ${data?.homeTeam?.score??''}-${data?.homeTeam?.wickets??''} (${data?.homeTeam?.overs.toString()??''}.${data?.homeTeam?.balls.toString()??''}) ",
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: black)
                                .pOnly(top: 8),
                          ],
                        ).pOnly(left: 20),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Row(
                          children: [
                            commonText(
                                data: getInitials(data?.awayTeam?.name??''),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black),
                            commonText(
                              //  data: "  000-0 (00.0)",
                                data: "  ${data?.awayTeam?.score??''}-${data?.awayTeam?.wickets??''} (${data?.awayTeam?.overs.toString()??''}.${data?.awayTeam?.balls.toString()??''}) ",
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: black)
                                .pOnly(top: 8),
                          ],
                        ).pOnly(left: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*   Expanded(
              child: TabBarView(
                controller: _controller,
                children: const [
                  HomeScorecard(),
                  AwayScorecard(),
                ],
              ),
            ),*/

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: MyInkWell(
                    onTap: ()async{
                      setState(() {
                        hasHomeButtonClicked = true;
                      });
                      print('hasHomeButtonClicked:$hasHomeButtonClicked');
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: hasHomeButtonClicked?buttonColors:greyColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Row(
                          children: [
                            commonText(
                                data: getInitials(data?.homeTeam?.name??''),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black),
                            commonText(
                                data: "  ${data?.homeTeam?.score??''}-${data?.homeTeam?.wickets??''} (${data?.homeTeam?.overs.toString()??''}.${data?.homeTeam?.balls.toString()??''}) ",
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: black)
                                .pOnly(top: 8),
                          ],
                        ).pOnly(left: 20),
                      ),
                    ).pOnly(left: 20, top: 20),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: MyInkWell(
                    onTap: ()async{
                      setState(() {
                        hasHomeButtonClicked = false;
                      });
                      print('hasHomeButtonClicked:$hasHomeButtonClicked');
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration:  BoxDecoration(
                          color: hasHomeButtonClicked?greyColor:buttonColors,
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Row(
                          children: [
                            commonText(
                                data: getInitials(data?.awayTeam?.name??''),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black),
                            commonText(
                              //  data: "  000-0 (00.0)",
                                data: "  ${data?.awayTeam?.score??''}-${data?.awayTeam?.wickets??''} (${data?.awayTeam?.overs.toString()??''}.${data?.awayTeam?.balls.toString()??''}) ",
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: black)
                                .pOnly(top: 8),
                          ],
                        ).pOnly(left: 20),
                      ),
                    ).pOnly(left: 5, right: 20, top: 20),
                  ),
                ),
              ],
            ),
            2.h.heightBox,
            const SizedBox(height: 18,),

            hasHomeButtonClicked? (isHomeTeamBatting==false&&data?.currentInning==1)?
            Padding(
              padding: const EdgeInsets.only(top: 100,bottom: 100),
              child: Center(child: mediumText14(context, 'Second Innings',textColor: white,fontSize: 20)),
            ):
            Column(
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4, fit: FlexFit.tight,
                      child: mediumText14(context, "    Batter", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
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
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "S/R", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                  ],
                ).pOnly(left: 12, right: 10,top: 20),
                1.h.heightBox,
                /* isHomeTeamBatting?ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?.batsmen?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                                  flex: 4,
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
                                      2.w.widthBox,
                                      data?.batsmen![index].isOnStrike==true?Image.asset(
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
                                  child: mediumText14(context,data?.batsmen![index].fours==0?'  -':
                                  "  ${data?.batsmen![index].fours.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,data?.batsmen![index].sixes==0?'   -':
                                  "  ${data?.batsmen![index].sixes.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      data?.batsmen![index].strikeRate!=null?data?.batsmen![index].strikeRate.toStringAsFixed(2)??'':"0.0",
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
                    }).pOnly(left: 10, right: 10):
                (isHomeTeamBatting==false&&data?.currentInning==2)?*/
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: actualHomePlayerOrderList?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  actualHomePlayerOrderList![index].actBatOrder==0?const SizedBox():Column(
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
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: mediumText14(context,
                                          actualHomePlayerOrderList![index].shortName??'',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          textColor: Colors.black,
                                          maxLines: 1,overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      2.w.widthBox,
                                      actualHomePlayerOrderList[index].isOnStrike==true?Image.asset(
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
                                      actualHomePlayerOrderList[index].batsmanRuns.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      actualHomePlayerOrderList[index].balls.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,actualHomePlayerOrderList[index].fours==0?'  -':
                                  "  ${actualHomePlayerOrderList[index].fours.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,actualHomePlayerOrderList[index].sixes==0?'   -':
                                  "  ${actualHomePlayerOrderList[index].sixes.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      actualHomePlayerOrderList[index].strikeRate!=null?actualHomePlayerOrderList[index].strikeRate.toStringAsFixed(2)??'':"0.0",
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
                    }).pOnly(left: 10, right: 10),
                //      : mediumText14(context, 'Not Started',textColor: white),
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
                            data: (data?.homeTeam?.legByes + data?.homeTeam?.byes + data?.homeTeam?.noBalls + data?.homeTeam?.wides).toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: white),
                        commonText(
                            data: " (b ${data?.homeTeam?.byes}, lb ${data?.homeTeam?.legByes}, w ${data?.homeTeam?.wides}, nb ${data?.homeTeam?.noBalls})",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: white),
                      ],
                    )
                  ],
                ).pOnly(left: 30, right: 30, top: 10),
                6.h.heightBox,
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4, fit: FlexFit.tight,
                      child: mediumText14(context, "    Bowling", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
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
                ).pOnly(left: 12, right: 12),
                const SizedBox(height: 18,),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: bowlingAwayPlayerList?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  bowlingAwayPlayerList![index].bowlOrder==0?const SizedBox():
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
                                  child: mediumText14(context, bowlingAwayPlayerList![index].shortName??'',
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
                                      bowlingAwayPlayerList[index].overs.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      bowlingAwayPlayerList[index].maidens.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      bowlingAwayPlayerList[index].bowlerRuns.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context, bowlingAwayPlayerList[index].wickets.toString()??'',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,bowlingAwayPlayerList[index].economy==null?'0.0':
                                  bowlingAwayPlayerList[index].economy.toStringAsFixed(2)??'',
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
                    }).pOnly(left: 12, right: 12),
                const SizedBox(height: 18,),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 9, fit: FlexFit.tight,
                      child: mediumText14(context, "    Fall Of Wickets", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ), //Flexible
                    Flexible(
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "Score", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                    Flexible(
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "Over", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                  ],
                ).pOnly(left: 12, right: 12,top: 20),
                const SizedBox(height: 18,),
                data?.homeTeam?.fOW?.length==0?Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: mediumText14(context, "No Wickets",textColor: white,fontSize: 18),
                ):
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?.homeTeam?.fOW?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                                    data?.homeTeam?.fOW![index].bat.toString()??'',
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
                                      "${data?.homeTeam?.fOW![index].runs}-${data?.homeTeam?.fOW![index].wkt}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),//Flexible
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      data?.homeTeam?.fOW![index].overs??'',
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
                    }).pOnly(left: 12, right: 12),
                /* const Text(
                  'Yet to Bat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ).pOnly(left: 20, top: 30),
                (expHomePlayerOrderList?.length==0 || expAwayPlayerOrderList?.length==0)?
                mediumText14(context, 'There is not player announced',textColor: white).pOnly(left: 20, top: 20,bottom: 20):
                GridView.builder(
                  //  itemCount: isHomeTeamBatting?expHomePlayerOrderList?.length:expAwayPlayerOrderList?.length,
                    itemCount: isHomeTeamBatting?expHomePlayerOrderList?.length:expAwayPlayerOrderList?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 2.5),
                    itemBuilder: (context, index) {
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
                                Text(isHomeTeamBatting?expHomePlayerOrderList![index].shortName??'': expAwayPlayerOrderList![index].shortName??'',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Row(
                                  children: [
                                    isHomeTeamBatting?commonText(
                                        data: expHomePlayerOrderList![index].strikeRate==null? "0.0":
                                        "SR: ${expHomePlayerOrderList[index].strikeRate.toStringAsFixed(2)??''}",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: primaryColors):
                                    commonText(
                                        data: expAwayPlayerOrderList![index].strikeRate==null? "0.0":
                                        "SR: ${expAwayPlayerOrderList[index].strikeRate.toStringAsFixed(2)??''}",
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
                    }).pOnly(left: 10, right: 10),*/
              ],
            ):
            (isHomeTeamBatting==true&&data?.currentInning==1)?
            Padding(
              padding: const EdgeInsets.only(top: 100,bottom: 100),
              child: Center(child: mediumText14(context, 'Second Innings',textColor: white,fontSize: 20)),
            ):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4, fit: FlexFit.tight,
                      child: mediumText14(context, "    Batter", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
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
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "S/R", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                  ],
                ).pOnly(left: 12, right: 10,top: 20),
                1.h.heightBox,

                /*    isHomeTeamBatting==false?
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?.batsmen?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                                  flex: 4,
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
                                      2.w.widthBox,
                                      data?.batsmen![index].isOnStrike==true?Image.asset(
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
                                  child: mediumText14(context,data?.batsmen![index].fours==0?'  -':
                                  "  ${data?.batsmen![index].fours.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,data?.batsmen![index].sixes==0?'   -':
                                  "  ${data?.batsmen![index].sixes.toString()??''}",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: Colors.black
                                  ), //Container
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      data?.batsmen![index].strikeRate!=null?data?.batsmen![index].strikeRate.toStringAsFixed(2)??'':"0.0",
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
                    }).pOnly(left: 12, right: 12):*/
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: actualAwayPlayerOrderList?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {



                      return  (actualAwayPlayerOrderList![index].actBatOrder==0 || actualAwayPlayerOrderList![index].actBatOrder==null)?const SizedBox():
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
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: mediumText14(context,
                                          actualAwayPlayerOrderList![index].shortName??'',
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
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: mediumText14(context,
                                      actualAwayPlayerOrderList[index].strikeRate!=null?actualAwayPlayerOrderList[index].strikeRate.toStringAsFixed(2)??'':"0.0",
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
                    }).pOnly(left: 12, right: 12),
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
                ).pOnly(left: 30, right: 30, top: 10),
                const SizedBox(height: 18,),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4, fit: FlexFit.tight,
                      child: mediumText14(context, "    Bowling", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
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
                ).pOnly(left: 12, right: 12,top: 20),
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
                    }).pOnly(left: 12, right: 12),
                const SizedBox(height: 18,),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 9, fit: FlexFit.tight,
                      child: mediumText14(context, "    Fall Of Wickets", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ), //Flexible
                    Flexible(
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "Score", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                    Flexible(
                      flex: 2, fit: FlexFit.tight,
                      child: mediumText14(context, "Over", fontSize: 14, fontWeight: FontWeight.w700, textColor: white), //Container
                    ),
                  ],
                ).pOnly(left: 12, right: 12,top: 20),
                const SizedBox(height: 18,),
                data?.awayTeam?.fOW?.length==0?mediumText14(context, "No Wickets",textColor: white):
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?.awayTeam?.fOW?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
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
                                    data?.awayTeam?.fOW![index].bat.toString()??'',
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
                    }).pOnly(left: 12, right: 12),
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
      ),
    );
  }
}
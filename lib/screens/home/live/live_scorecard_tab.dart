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
      body: Column(
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
                    data: "RRR:${isHomeTeamBatting?data?.homeTeam?.requiredRunRate==null?'0.0':data?.homeTeam?.requiredRunRate.toStringAsFixed(2)??'':data?.awayTeam?.requiredRunRate==null?'0.0':data?.awayTeam?.requiredRunRate.toStringAsFixed(2)??''}",
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 45),
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
          Expanded(
            child: TabBarView(
              controller: _controller,
              children:  [
                HomeScorecard(tmpLiveScoreResponse: widget.tmpLiveScoreResponse,),
                AwayScorecard(tmpLiveScoreResponse: widget.tmpLiveScoreResponse,),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/screens/home/lineall16.dart';
import 'package:kisma_livescore/screens/home/linebat8.dart';
import 'package:kisma_livescore/screens/home/lineupar2.dart';
import 'package:kisma_livescore/screens/home/lineupbowl6.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shortform.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';
class LiveLineUpTab extends StatefulWidget {
  final LiveScoreResponse tmpLiveScoreResponse;
  const LiveLineUpTab({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);

  @override
  State<LiveLineUpTab> createState() => _LiveLineUpTabState();
}



class _LiveLineUpTabState extends State<LiveLineUpTab> with TickerProviderStateMixin {
  bool isHomeTeamBatting = false;
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  TabController? _controller;
 // int _currentIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 1, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.tmpLiveScoreResponse.data;
    isHomeTeamBatting = data?.homeTeam?.isBattingTeam ?? false ;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
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
          1.h.heightBox,
          SizedBox(
            height: 40,
            child: AppBar(
              backgroundColor: const Color(0xff001548).withOpacity(0.7),
              bottom: ButtonsTabBar(
                contentPadding: const EdgeInsets.symmetric(horizontal: 27),
                radius: 30,
                height: 35,
                unselectedBackgroundColor: Colors.white,
                decoration: BoxDecoration(color: neonColor),
                controller: _controller,
                tabs: const [
                  Tab(
                    // height: 20,
                    child: Text(
                      'All',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                /*  Tab(
                    // height: 20,
                    child: Text(
                      'Bat 8',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'Bowl 6',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    // height: 20,
                    child: Text(
                      'AR 2',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children:  [
                // LineAll16(tmpLiveScoreResponse: widget.tmpLiveScoreResponse,),
              /*  const LineBat8(),
                const LineUpBowl6(),
                const LineUpAr2(),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
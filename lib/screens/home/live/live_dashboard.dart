import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/responses/live_score_response.dart' as dfr;
import 'package:kisma_livescore/screens/home/live/live_details_tab.dart';
import 'package:kisma_livescore/screens/home/live/live_lineup_tab.dart';
import 'package:kisma_livescore/screens/home/live/live_scorecard_tab.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shortform.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveDashboard extends StatefulWidget {
  const LiveDashboard({super.key});

  @override
  State<LiveDashboard> createState() => _LiveDashboardState();
}


class _LiveDashboardState extends State<LiveDashboard> with TickerProviderStateMixin {
  bool isHomeTeamBatting = false;
  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  List<dfr.Data>? tmpLiveScoreList=[];

  LiveScoreResponse tmpLiveScoreResponse = LiveScoreResponse();
  @override
  void initState() {
    // initialize controller
    _getLiveScoreApi();
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> _getLiveScoreApi() async {
    BlocProvider.of<LiveScoreCubit>(context).getLiveScoreDashboardCall();
  }
  TabController? _controller;
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      appBar:  CustomAppBar(
        title: "Live",
        titleFontSize:15,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == LiveScoreStatus.liveScoreDashboardSuccess){
            Loader.hide();
            liveScoreResponse = state.responseData?.response as LiveScoreResponse;
            isHomeTeamBatting = liveScoreResponse.data?.homeTeam?.isBattingTeam??false;
            setState(() {
              tmpLiveScoreList!.clear();
              tmpLiveScoreList?.addAll(liveScoreResponse.data != null ? [liveScoreResponse.data!] : []);

              tmpLiveScoreResponse = liveScoreResponse;
            });

          }
          if(state.status == LiveScoreStatus.liveScoreDashboardSuccess1){
            Loader.hide();
            liveScoreResponse = state.responseData?.response as LiveScoreResponse;
            isHomeTeamBatting = liveScoreResponse.data?.homeTeam?.isBattingTeam??false;
            setState(() {
              tmpLiveScoreList!.clear();
              tmpLiveScoreList?.addAll(liveScoreResponse.data != null ? [liveScoreResponse.data!] : []);

              tmpLiveScoreResponse = liveScoreResponse;
            });

          }
          if(state.status == LiveScoreStatus.liveScoreDashboardError){
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage( message);
          }
        },
        builder: (context,state){
          if (state.status == LiveScoreStatus.liveScoreDashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.liveScoreDashboardError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return SingleChildScrollView(
              // physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: screenHeight * 0.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 14),
                  child: RefreshIndicator(
                    key: const Key('some_value'),
                    onRefresh: _getLiveScoreApi,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //  Image.asset('assets/images/error.png', height: 45, width: 45),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left :50.0 , right: 50.0),
                          child: statusCode == 401
                              ? mediumText14(
                              context, error ?? '',//'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textColor:const Color(0xffFFFFFF)
                          ) : mediumText14 (
                              context, '$error\n\nClick to refresh.',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor:const Color(0xffFFFFFF)
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh,color: Colors.white,size: 35,),
                          onPressed: () {
                            _getLiveScoreApi();
                            // Handle refresh action here
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 4),
                // margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff001548).withOpacity(0.7),
                  // border: Border.all(color: txtGrey),
                  // borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgCustomWidget(imageUrl: getCountryFlag(isHomeTeamBatting?liveScoreResponse.data?.homeTeam?.name??'':liveScoreResponse.data?.awayTeam?.name??''),),
                              5.w.widthBox,
                              Image.asset(
                                'assets/images/bat.png',
                                scale: 2.5,
                                color: neonColor,
                              )
                            ],
                          ),
                          1.h.heightBox,
                          mediumText14(context, isHomeTeamBatting?liveScoreResponse.data?.homeTeam?.name??'':liveScoreResponse.data?.awayTeam?.name??'',textColor: const Color(0xffE4E5E9),maxLines: 2,overflow:  TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(color: neonColor, borderRadius: BorderRadius.circular(14)),
                                child:mediumText14(context, isHomeTeamBatting?"${liveScoreResponse.data?.homeTeam?.score.toString()}/${liveScoreResponse.data?.homeTeam?.wickets.toString()}":
                                "${liveScoreResponse.data?.awayTeam?.score.toString()}/${liveScoreResponse.data?.awayTeam?.wickets.toString()}",textColor: const Color(0xff001648), fontWeight: FontWeight.w700).pOnly(left: 12, right: 12, top: 3, bottom: 3),
                              ),
                              3.w.widthBox,
                              //  mediumText14(context, "${liveScoreResponse.data?.currentOver?.overNumber.toString()??''}.${liveScoreResponse.data?.currentOver?.ballByBall?.length.toString()??''}",textColor: const Color(0xffE4E5E9),fontWeight: FontWeight.w700 ),
                              mediumText14(context, isHomeTeamBatting?"${liveScoreResponse.data?.homeTeam?.overs.toString()??''}.${liveScoreResponse.data?.homeTeam?.balls.toString()??''}":
                              "${liveScoreResponse.data?.awayTeam?.overs.toString()??''}.${liveScoreResponse.data?.awayTeam?.balls.toString()??''}",textColor: const Color(0xffE4E5E9),fontWeight: FontWeight.w700 ),
                            ],
                          ),
                          1.h.heightBox,
                          liveScoreResponse.data?.currentInning==1?mediumText14(context, '1st Innings',fontSize: 11,textColor: Colors.white):
                          mediumText14(context,"Target: ${liveScoreResponse.data?.homeTeam?.target!=null?liveScoreResponse.data?.homeTeam?.target.toString()??'':liveScoreResponse.data?.awayTeam?.target.toString()??''}",fontSize: 11,textColor: Colors.white)
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: buttonColors),
                        ),
                        child: commonText(
                            data: liveScoreResponse.data?.currentOver?.runs.toString()??'0',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: buttonColors)
                            .p(20),
                      ),
                    )
                  ],
                ).pSymmetric(h: 30, v: 20),
              ),
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: const Color(0xff001548).withOpacity(0.7),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: ButtonsTabBar(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                      radius: 30,
                      height: 35,
                      unselectedBackgroundColor: Colors.white,
                      decoration: BoxDecoration(color: neonColor),
                      controller: _controller,
                      tabs: const [
                        Tab(
                          // height: 20,
                          child: Text(
                            'Details',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Tab(
                          // height: 20,
                          child: Text(
                            'Scorecard',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Tab(
                          // height: 20,
                          child: Text(
                            'Lineup',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ).objectCenterLeft(),
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children:  [
                    LiveDetailsTab(tmpLiveScoreResponse:tmpLiveScoreResponse),
                    LiveScoreCardTab(tmpLiveScoreResponse:tmpLiveScoreResponse),
                    LiveLineUpTab(tmpLiveScoreResponse:tmpLiveScoreResponse),
                  ],
                ),
              ),
            ],
          );

        },
      ),

    );
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/get_country_code_abd_flag_response.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/screens/home/live/live_dashboard.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shortform.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {

  LiveScoreResponse liveScoreResponse = LiveScoreResponse();
  GetCountryCodeAndFlagResponse getCountryCodeAndFlagResponse = GetCountryCodeAndFlagResponse();
  @override
  void initState() {
    // initialize controller
    _getLiveScoreApi();
    _controller = ExpandedTileController(isExpanded: true);

    isTrue = _controller.isExpanded;

    /*  _timer = Timer.periodic(const Duration(
        seconds: 10
    ), (timer) {
      _getLiveScoreApi2();
    });*/
    super.initState();
  }

  @override
  void dispose() {
    /// Cancel the timer when the widget is disposed
    //  _timer?.cancel();
    super.dispose();
  }

  Future<void> _getLiveScoreApi() async {
    await BlocProvider.of<LiveScoreCubit>(context).getLiveScoreCall();
  }

  Future<void> _getLiveScoreApi2() async {
    await BlocProvider.of<LiveScoreCubit>(context).getLiveScoreCall1();
  }

  late ExpandedTileController _controller;
  ExpandedTileController controller3 = ExpandedTileController(isExpanded: false);
  bool? isTrue;
  List<bool> isTrueList = [false, false];
  Timer? _timer;


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == LiveScoreStatus.liveScoreSuccess){
            Loader.hide();
            liveScoreResponse = state.responseData?.response as LiveScoreResponse;
            BlocProvider.of<LiveScoreCubit>(context).getCountryCodeAndFlagCall();
          }
          if(state.status == LiveScoreStatus.liveScoreSuccess1){
            // Loader.hide();
            liveScoreResponse = state.responseData?.response as LiveScoreResponse;
          }
          if(state.status == LiveScoreStatus.getCountryCodeAndFlagSuccess){
            getCountryCodeAndFlagResponse = state.responseData?.response as GetCountryCodeAndFlagResponse;
            //   countryUtils.teamShortFormList.clear();
            teamShortFormList.clear();
            if(getCountryCodeAndFlagResponse.data!=null && getCountryCodeAndFlagResponse.data!.isNotEmpty){
              //    countryUtils.teamShortFormList.addAll(getCountryCodeAndFlagResponse.data!);
              teamShortFormList.addAll(getCountryCodeAndFlagResponse.data!);
            }
          }
          if(state.status == LiveScoreStatus.liveScoreError){
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage( message);
          }

          if(state.status == LiveScoreStatus.liveScoreError1){
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage( message);
          }
        },
        builder: (context,state){
          if (state.status == LiveScoreStatus.liveScoreLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.liveScoreError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: screenHeight * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14,right: 14,top: 14),
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
          return RefreshIndicator(
            onRefresh: _refreshPage,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 12,right: 12,top: 12),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return MyInkWell(
                    onTap: () async {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const LiveDashboard(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                        PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: disableColors),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          children: [
                            Container(
                              height: 14.h,
                              width: 2.w,
                              decoration: BoxDecoration(
                                  color: neonColor,
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(7),
                                      topLeft: Radius.circular(7))),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    1.h.heightBox,
                                     Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            children: [
                                              mediumText14(context, liveScoreResponse.data?.homeTeam?.name??'', maxLines: 1,overflow:TextOverflow.ellipsis),
                                              const SizedBox(height: 12,),
                                              liveScoreResponse.data?.homeTeam?.isBattingTeam==true || liveScoreResponse.data?.currentInning == 2?
                                              Container(
                                                padding: const EdgeInsets.only(left: 12, top: 5, bottom: 5, right: 12),
                                                decoration: BoxDecoration(color: buttonColors, borderRadius: BorderRadius.circular(30)),
                                                child: commonText(
                                                  data: "${liveScoreResponse.data?.homeTeam?.score.toString()??''}/${liveScoreResponse.data?.homeTeam?.wickets.toString()??''}",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: black,
                                                ),
                                              ):
                                              mediumText14(context, "Not yet").pOnly(top: 3,bottom: 6),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              commonText(
                                                data: "• Live",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                color: Colors.red,
                                              ),
                                              const SizedBox(height: 12,),
                                              liveScoreResponse.data?.currentBall==null?
                                              commonText(data:"Not Started",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Poppins",
                                                color: overColor,
                                                alignment: TextAlign.center

                                              ):commonText(
                                                //  data: liveScoreResponse.data?.currentOver==null?"Not Started":"${liveScoreResponse.data?.currentOver?.overNumber.toString()??''}.${liveScoreResponse.data?.currentOver?.ballByBall?.length.toString()??''}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                //  data: liveScoreResponse.data?.currentBall==null?"Not Started":"${liveScoreResponse.data?.currentBall?.over.toString()??''}.${liveScoreResponse.data?.currentBall?.ballNumber?.toString()??''}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                data: liveScoreResponse.data?.homeTeam?.isBattingTeam==true?"${liveScoreResponse.data?.homeTeam?.overs}.${liveScoreResponse.data?.homeTeam?.balls}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov":"${liveScoreResponse.data?.awayTeam?.overs}.${liveScoreResponse.data?.awayTeam?.balls}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                fontFamily: "Poppins",
                                                color: overColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            children: [
                                              mediumText14(context,liveScoreResponse.data?.awayTeam?.name??'', maxLines: 1,overflow:TextOverflow.ellipsis),
                                              const SizedBox(height: 12,),
                                              liveScoreResponse.data?.awayTeam?.isBattingTeam==true || liveScoreResponse.data?.currentInning == 2?
                                              Container(
                                                padding: const EdgeInsets.only(left: 12, top: 5, bottom: 5, right: 12),
                                                decoration: BoxDecoration(color: buttonColors, borderRadius: BorderRadius.circular(30)),
                                                child: commonText(
                                                  data: "${liveScoreResponse.data?.awayTeam?.score.toString()??''}/${liveScoreResponse.data?.awayTeam?.wickets.toString()??''}",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: black,
                                                ),
                                              ):
                                             /* commonText(
                                                data: "${liveScoreResponse.data?.awayTeam?.score.toString()??''}/${liveScoreResponse.data?.awayTeam?.wickets.toString()??''}",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                                color: black,
                                              )*/
                                              mediumText14(context, "Not yet").pOnly(top: 3,bottom: 6),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    2.h.heightBox
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );

        },
      ),
    );
  }

  Future<void> _refreshPage() async{
    await _getLiveScoreApi2();
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/responses/get_country_code_abd_flag_response.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/screens/home/live/live_dashboard.dart';
import 'package:kisma_livescore/screens/home/live/live_details_tab.dart';
import 'package:kisma_livescore/screens/socket/socketdummy.dart';
import 'package:kisma_livescore/screens/socket/socketdummy2.dart';
import 'package:kisma_livescore/screens/socket/textjfjkd.dart';
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
  final ExpandedTileController _controller2 = ExpandedTileController(isExpanded: false);
  ExpandedTileController controller3 = ExpandedTileController(isExpanded: false);
  bool isTrue2 = false;
  bool isTrue3 = false;
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  2.h.heightBox,
                  Image.asset(
                    "assets/images/banner3.png",
                    scale: 3.8,
                  ),
                  2.h.heightBox,
                  ExpandedTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      // size: 40,
                      color: Color(0xff96A0B7),
                    ).rotate90(),
                    contentseparator: 3.0,
                    trailingRotation: 180,
                    theme: const ExpandedTileThemeData(
                      headerPadding: EdgeInsets.symmetric(horizontal: 10),
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
                                  data: "International T20 Matches",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: white,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Spacer(),
                            Container(
                              width: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: buttonColors),
                              child: Center(
                                child: commonText(
                                  data: "1",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: black,
                                ),
                              ),
                            ).p(2)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Divider(
                            thickness: 1.0,
                            color: buttonColors,
                          ),
                        ),
                      ],
                    ),
                    content: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
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
                                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      SvgCustomWidget(imageUrl: getCountryFlag(liveScoreResponse.data?.homeTeam?.name??''),),
                                                      3.w.widthBox,
                                                      Flexible(
                                                        child: mediumText14(context, shortFormCountryCode(liveScoreResponse.data?.homeTeam?.name??''), maxLines: 1,overflow:TextOverflow.ellipsis),
                                                      ),
                                                    ],
                                                  ).pOnly(left: 15),
                                                ),
                                                commonText(
                                                  data: "• Live",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: Colors.red,
                                                ),
                                                Flexible(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      SvgCustomWidget(imageUrl: getCountryFlag(liveScoreResponse.data?.awayTeam?.name??''),),
                                                      3.w.widthBox,
                                                      Flexible(
                                                        child:mediumText14(context,shortFormCountryCode(liveScoreResponse.data?.awayTeam?.name??''), maxLines: 1,overflow:TextOverflow.ellipsis),),
                                                    ],
                                                  ).pOnly(right: 15),
                                                ),
                                              ],
                                            ),
                                            2.h.heightBox,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
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
                                                  mediumText14(context, "not yet"),
                                                  liveScoreResponse.data?.currentBall==null?
                                                  commonText(data:"Not Started",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: "Poppins",
                                                    color: overColor,
                                                  ):commonText(
                                                  //  data: liveScoreResponse.data?.currentOver==null?"Not Started":"${liveScoreResponse.data?.currentOver?.overNumber.toString()??''}.${liveScoreResponse.data?.currentOver?.ballByBall?.length.toString()??''}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                  //  data: liveScoreResponse.data?.currentBall==null?"Not Started":"${liveScoreResponse.data?.currentBall?.over.toString()??''}.${liveScoreResponse.data?.currentBall?.ballNumber?.toString()??''}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                    data: liveScoreResponse.data?.homeTeam?.isBattingTeam==true?"${liveScoreResponse.data?.homeTeam?.overs}.${liveScoreResponse.data?.homeTeam?.balls}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov":"${liveScoreResponse.data?.awayTeam?.overs}.${liveScoreResponse.data?.awayTeam?.balls}/${liveScoreResponse.data?.oversPerInning?.toString()??''} ov",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: "Poppins",
                                                    color: overColor,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 18.0),
                                                    child: liveScoreResponse.data?.awayTeam?.isBattingTeam==true || liveScoreResponse.data?.currentInning == 2?
                                                    commonText(
                                                      data: "${liveScoreResponse.data?.awayTeam?.score.toString()??''}/${liveScoreResponse.data?.awayTeam?.wickets.toString()??''}",
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                      color: black,
                                                    ): mediumText14(context, "not yet"),
                                                  ),
                                                ],
                                              ),
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
                  ),
                  2.h.heightBox,
                  ExpandedTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      // size: 40,
                      color: Color(0xff96A0B7),
                    ).rotate90(),
                    contentseparator: 3.0,
                    trailingRotation: 180,
                    theme: const ExpandedTileThemeData(
                      headerPadding: EdgeInsets.symmetric(horizontal: 10),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      headerColor: bgColor,
                      headerSplashColor: transparent,
                      contentBackgroundColor: bgColor,
                    ),
                    controller: _controller2,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            isTrue2!
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
                                  data: "The Hundred",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: white,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Divider(
                            thickness: 1.0,
                            color: buttonColors,
                          ),
                        ),
                      ],
                    ),
                    content: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                            /*  PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const LiveDashboard(),
                                withNavBar: true, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                              );*/
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                               screen: const WebsocketDemo(),
                           //     screen:  NumberInputWithIncrementDecrement(),
                           //     screen:  const MyHomePage( title: "Socket",),
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
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(7),
                                              topLeft: Radius.circular(7))),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          1.h.heightBox,
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/team2.png",
                                                      scale: 4,
                                                    ),
                                                    3.w.widthBox,
                                                    commonText(
                                                      data: "Zimbabwe",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Poppins",
                                                      color: teamColor,
                                                    ),
                                                  ],
                                                ),
                                                commonText(
                                                  data: "• Live",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  color: Colors.red,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/team1.png",
                                                      scale: 4,
                                                    ),
                                                    3.w.widthBox,
                                                    commonText(
                                                      data: "Bangladesh",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Poppins",
                                                      color: teamColor,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 20.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 12,
                                                      top: 5,
                                                      bottom: 5,
                                                      right: 12),
                                                  decoration: BoxDecoration(
                                                      color: buttonColors,
                                                      borderRadius:
                                                      BorderRadius.circular(30)),
                                                  child: commonText(
                                                    data: "146/2",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Poppins",
                                                    color: black,
                                                  ),
                                                ),
                                                commonText(
                                                  data: "39.2/45 ov",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily: "Poppins",
                                                  color: overColor,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 18.0),
                                                  child: commonText(
                                                    data: "175",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "Poppins",
                                                    color: black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          2.h.heightBox
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    onTap: () {
                      if (_controller2.isExpanded == true) {
                        setState(() {
                          isTrue2 = _controller2.isExpanded;
                        });
                      } else {
                        setState(() {
                          isTrue2 = false;
                        });
                      }
                      debugPrint("tapped!!");
                    },
                    onLongTap: () {
                      debugPrint("long tapped!!");
                    },
                  ),
                  2.h.heightBox,
                  ExpandedTile(
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        // size: 40,
                        color: Color(0xff96A0B7),
                      ).rotate90(),
                      trailingRotation: 180,
                      theme: const ExpandedTileThemeData(
                        headerColor: bgColor,
                        headerSplashColor: transparent,
                        contentBackgroundColor: bgColor,
                        headerPadding: EdgeInsets.symmetric(horizontal: 10),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      controller: controller3,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              isTrue3
                                  ? Image.asset(
                                "assets/images/doticon.png",
                                height: 25,
                                width: 25,
                              )
                                  : SizedBox(),
                              2.w.widthBox,
                              commonText(
                                data: "The Hundred - Womens ",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: white,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: Divider(
                              thickness: 1.0,
                              color: buttonColors,
                            ),
                          ),
                        ],
                      ),
                      content: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      commonText(
                                        data: "Coming soon",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.withOpacity(0.6),
                                      ),
                                    ],
                                  ),
                                  2.h.heightBox,
                                  Container(
                                    margin: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        border: Border.all(color: disableColors),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          0.5.h.heightBox,
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              commonText(
                                                data: "",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                color: matchTitleColor,
                                              ),
                                              commonText(
                                                data: "International T20 Matches",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                                color: Colors.grey.withOpacity(0.3),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 4.0, top: 4.0),
                                                child: Image.asset(
                                                  "assets/images/notification.png",
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  "assets/images/team2.png",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 3,
                                                      bottom: 3),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(20.0)),
                                                      color: buttonColors),
                                                  child: Center(
                                                    child: commonText(
                                                      alignment: TextAlign.center,
                                                      data: "Starting \n in 26’",
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                      color: black,
                                                    ),
                                                  ),
                                                ).pOnly(left: 32, right: 32),
                                                Image.asset(
                                                  "assets/images/team1.png",
                                                  height: 40,
                                                  width: 40,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0.0, left: 8.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                commonText(
                                                  data: "Zimbabwe",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  color: Colors.grey.withOpacity(0.6),
                                                ),
                                                commonText(
                                                  data: "Bangladesh",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  color: Colors.grey.withOpacity(0.6),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      onTap: () {
                        if (controller3.isExpanded == true) {
                          setState(() {
                            isTrue3 = controller3.isExpanded;
                          });
                        } else {
                          setState(() {
                            isTrue3 = false;
                          });
                        }
                        debugPrint("tapped!!");
                      },
                      onLongTap: () {
                        debugPrint("long tapped!!");
                      }),
                  3.h.heightBox,
                  // ExpandedTile(
                  //     trailing: Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       // size: 40,
                  //       color: Color(0xff96A0B7),
                  //     ).rotate90(),
                  //     trailingRotation: 180,
                  //     theme: const ExpandedTileThemeData(
                  //       headerColor: bgColor,
                  //       headerSplashColor: transparent,
                  //       contentBackgroundColor: bgColor,
                  //       headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     ),
                  //     controller: controller3,
                  //     title: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             isTrue3
                  //                 ? Image.asset(
                  //               "assets/images/doticon.png",
                  //               height: 25,
                  //               width: 25,
                  //             )
                  //                 : SizedBox(),
                  //             2.w.widthBox,
                  //             commonText(
                  //               data: "The Hundred - Womens ",
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: "Poppins",
                  //               color: white,
                  //             ),
                  //           ],
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  //           child: Divider(
                  //             thickness: 1.0,
                  //             color: buttonColors,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     content: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 1,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, i) {
                  //           return GestureDetector(
                  //             onTap: () {},
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     commonText(
                  //                       data: "Coming soon",
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w400,
                  //                       color: Colors.grey.withOpacity(0.6),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 2.h.heightBox,
                  //                 Container(
                  //                   margin: const EdgeInsets.all(0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.2),
                  //                       border: Border.all(color: disableColors),
                  //                       borderRadius: BorderRadius.circular(7)),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(1.0),
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         0.5.h.heightBox,
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             commonText(
                  //                               data: "",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w500,
                  //                               fontFamily: "Poppins",
                  //                               color: matchTitleColor,
                  //                             ),
                  //                             commonText(
                  //                               data: "International T20 Matches",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               fontFamily: "Poppins",
                  //                               color: Colors.grey.withOpacity(0.3),
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.only(
                  //                                   right: 4.0, top: 4.0),
                  //                               child: Image.asset(
                  //                                 "assets/images/notification.png",
                  //                                 height: 15,
                  //                                 width: 15,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(12.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               Image.asset(
                  //                                 "assets/images/team2.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               ),
                  //                               Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     left: 10,
                  //                                     right: 10,
                  //                                     top: 3,
                  //                                     bottom: 3),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius: BorderRadius.all(
                  //                                         Radius.circular(20.0)),
                  //                                     color: buttonColors),
                  //                                 child: Center(
                  //                                   child: commonText(
                  //                                     alignment: TextAlign.center,
                  //                                     data: "Starting \n in 26’",
                  //                                     fontSize: 10,
                  //                                     fontWeight: FontWeight.w700,
                  //                                     fontFamily: "Poppins",
                  //                                     color: black,
                  //                                   ),
                  //                                 ),
                  //                               ).pOnly(left: 32, right: 32),
                  //                               Image.asset(
                  //                                 "assets/images/team1.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 0.0, left: 8.0, right: 8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               commonText(
                  //                                 data: "Zimbabwe",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                               commonText(
                  //                                 data: "Bangladesh",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //     onTap: () {
                  //       if (controller3.isExpanded == true) {
                  //         setState(() {
                  //           isTrue3 = controller3.isExpanded;
                  //         });
                  //       } else {
                  //         setState(() {
                  //           isTrue3 = false;
                  //         });
                  //       }
                  //       debugPrint("tapped!!");
                  //     },
                  //     onLongTap: () {
                  //       debugPrint("long tapped!!");
                  //     }),
                  // 3.h.heightBox,
                  // ExpandedTile(
                  //     trailing: Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       // size: 40,
                  //       color: Color(0xff96A0B7),
                  //     ).rotate90(),
                  //     trailingRotation: 180,
                  //     theme: const ExpandedTileThemeData(
                  //       headerColor: bgColor,
                  //       headerSplashColor: transparent,
                  //       contentBackgroundColor: bgColor,
                  //       headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     ),
                  //     controller: controller3,
                  //     title: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             isTrue3
                  //                 ? Image.asset(
                  //               "assets/images/doticon.png",
                  //               height: 25,
                  //               width: 25,
                  //             )
                  //                 : SizedBox(),
                  //             2.w.widthBox,
                  //             commonText(
                  //               data: "The Hundred - Womens ",
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: "Poppins",
                  //               color: white,
                  //             ),
                  //           ],
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  //           child: Divider(
                  //             thickness: 1.0,
                  //             color: buttonColors,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     content: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 1,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, i) {
                  //           return GestureDetector(
                  //             onTap: () {},
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     commonText(
                  //                       data: "Coming soon",
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w400,
                  //                       color: Colors.grey.withOpacity(0.6),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 2.h.heightBox,
                  //                 Container(
                  //                   margin: const EdgeInsets.all(0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.2),
                  //                       border: Border.all(color: disableColors),
                  //                       borderRadius: BorderRadius.circular(7)),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(1.0),
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         0.5.h.heightBox,
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             commonText(
                  //                               data: "",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w500,
                  //                               fontFamily: "Poppins",
                  //                               color: matchTitleColor,
                  //                             ),
                  //                             commonText(
                  //                               data: "International T20 Matches",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               fontFamily: "Poppins",
                  //                               color: Colors.grey.withOpacity(0.3),
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.only(
                  //                                   right: 4.0, top: 4.0),
                  //                               child: Image.asset(
                  //                                 "assets/images/notification.png",
                  //                                 height: 15,
                  //                                 width: 15,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(12.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               Image.asset(
                  //                                 "assets/images/team2.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               ),
                  //                               Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     left: 10,
                  //                                     right: 10,
                  //                                     top: 3,
                  //                                     bottom: 3),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius: BorderRadius.all(
                  //                                         Radius.circular(20.0)),
                  //                                     color: buttonColors),
                  //                                 child: Center(
                  //                                   child: commonText(
                  //                                     alignment: TextAlign.center,
                  //                                     data: "Starting \n in 26’",
                  //                                     fontSize: 10,
                  //                                     fontWeight: FontWeight.w700,
                  //                                     fontFamily: "Poppins",
                  //                                     color: black,
                  //                                   ),
                  //                                 ),
                  //                               ).pOnly(left: 32, right: 32),
                  //                               Image.asset(
                  //                                 "assets/images/team1.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 0.0, left: 8.0, right: 8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               commonText(
                  //                                 data: "Zimbabwe",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                               commonText(
                  //                                 data: "Bangladesh",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //     onTap: () {
                  //       if (controller3.isExpanded == true) {
                  //         setState(() {
                  //           isTrue3 = controller3.isExpanded;
                  //         });
                  //       } else {
                  //         setState(() {
                  //           isTrue3 = false;
                  //         });
                  //       }
                  //       debugPrint("tapped!!");
                  //     },
                  //     onLongTap: () {
                  //       debugPrint("long tapped!!");
                  //     }),
                  // 3.h.heightBox,
                  // ExpandedTile(
                  //     trailing: Icon(
                  //       Icons.arrow_forward_ios_outlined,
                  //       // size: 40,
                  //       color: Color(0xff96A0B7),
                  //     ).rotate90(),
                  //     trailingRotation: 180,
                  //     theme: const ExpandedTileThemeData(
                  //       headerColor: bgColor,
                  //       headerSplashColor: transparent,
                  //       contentBackgroundColor: bgColor,
                  //       headerPadding: EdgeInsets.symmetric(horizontal: 10),
                  //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //     ),
                  //     controller: controller3,
                  //     title: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             isTrue3
                  //                 ? Image.asset(
                  //               "assets/images/doticon.png",
                  //               height: 25,
                  //               width: 25,
                  //             )
                  //                 : SizedBox(),
                  //             2.w.widthBox,
                  //             commonText(
                  //               data: "The Hundred - Womens ",
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: "Poppins",
                  //               color: white,
                  //             ),
                  //           ],
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  //           child: Divider(
                  //             thickness: 1.0,
                  //             color: buttonColors,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     content: ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: 1,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemBuilder: (context, i) {
                  //           return GestureDetector(
                  //             onTap: () {},
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     commonText(
                  //                       data: "Coming soon",
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.w400,
                  //                       color: Colors.grey.withOpacity(0.6),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 2.h.heightBox,
                  //                 Container(
                  //                   margin: const EdgeInsets.all(0),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.2),
                  //                       border: Border.all(color: disableColors),
                  //                       borderRadius: BorderRadius.circular(7)),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.all(1.0),
                  //                     child: Column(
                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                  //                       children: [
                  //                         0.5.h.heightBox,
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                           children: [
                  //                             commonText(
                  //                               data: "",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w500,
                  //                               fontFamily: "Poppins",
                  //                               color: matchTitleColor,
                  //                             ),
                  //                             commonText(
                  //                               data: "International T20 Matches",
                  //                               fontSize: 14,
                  //                               fontWeight: FontWeight.w400,
                  //                               fontFamily: "Poppins",
                  //                               color: Colors.grey.withOpacity(0.3),
                  //                             ),
                  //                             Padding(
                  //                               padding: const EdgeInsets.only(
                  //                                   right: 4.0, top: 4.0),
                  //                               child: Image.asset(
                  //                                 "assets/images/notification.png",
                  //                                 height: 15,
                  //                                 width: 15,
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.all(12.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               Image.asset(
                  //                                 "assets/images/team2.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               ),
                  //                               Container(
                  //                                 padding: EdgeInsets.only(
                  //                                     left: 10,
                  //                                     right: 10,
                  //                                     top: 3,
                  //                                     bottom: 3),
                  //                                 decoration: BoxDecoration(
                  //                                     borderRadius: BorderRadius.all(
                  //                                         Radius.circular(20.0)),
                  //                                     color: buttonColors),
                  //                                 child: Center(
                  //                                   child: commonText(
                  //                                     alignment: TextAlign.center,
                  //                                     data: "Starting \n in 26’",
                  //                                     fontSize: 10,
                  //                                     fontWeight: FontWeight.w700,
                  //                                     fontFamily: "Poppins",
                  //                                     color: black,
                  //                                   ),
                  //                                 ),
                  //                               ).pOnly(left: 32, right: 32),
                  //                               Image.asset(
                  //                                 "assets/images/team1.png",
                  //                                 height: 40,
                  //                                 width: 40,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(
                  //                               top: 0.0, left: 8.0, right: 8.0),
                  //                           child: Row(
                  //                             mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             children: [
                  //                               commonText(
                  //                                 data: "Zimbabwe",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                               commonText(
                  //                                 data: "Bangladesh",
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 fontFamily: "Poppins",
                  //                                 color: Colors.grey.withOpacity(0.6),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }),
                  //     onTap: () {
                  //       if (controller3.isExpanded == true) {
                  //         setState(() {
                  //           isTrue3 = controller3.isExpanded;
                  //         });
                  //       } else {
                  //         setState(() {
                  //           isTrue3 = false;
                  //         });
                  //       }
                  //       debugPrint("tapped!!");
                  //     },
                  //     onLongTap: () {
                  //       debugPrint("long tapped!!");
                  //     }),
                  // 3.h.heightBox
                ],
              ),
            ),
          );

        },
      ),
    );
  }

  Future<void> _refreshPage() async{
    await _getLiveScoreApi2();
  }
}

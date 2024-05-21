// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:kisma_livescore/cubit/livescore_cubit.dart';
// import 'package:kisma_livescore/customwidget/commonwidget.dart';
// import 'package:kisma_livescore/utils/colorfile.dart';
// import 'package:kisma_livescore/utils/custom_widgets.dart';
// import 'package:kisma_livescore/utils/ui_helper.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:kisma_livescore/responses/live_score_response.dart';
//
// class LiveMatchDetailsFirst extends StatefulWidget {
//   final LiveScoreResponse tmpLiveScoreResponse;
//   const LiveMatchDetailsFirst({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);
//
//   @override
//   State<LiveMatchDetailsFirst> createState() => _LiveMatchDetailsFirstState();
// }
//
// class _LiveMatchDetailsFirstState extends State<LiveMatchDetailsFirst> {
//   bool homeTeamBatting = false;
//   LiveScoreResponse liveScoreResponse = LiveScoreResponse();
//   @override
//   void initState() {
//     // initialize controller
//     _getLiveScoreApi();
//     super.initState();
//   }
//
//   Future<void> _getLiveScoreApi() async {
//     BlocProvider.of<LiveScoreCubit>(context).getLiveScoreCall1();
//   }
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     final data = widget.tmpLiveScoreResponse.data;
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
//         listener: (context,state){
//           print("sate.status:${state.status}");
//           if(state.status == LiveScoreStatus.liveScoreSuccess1){
//             Loader.hide();
//             liveScoreResponse = state.responseData?.response as LiveScoreResponse;
//             homeTeamBatting = liveScoreResponse.data?.homeTeam?.isBattingTeam??false;
//
//           }
//           if(state.status == LiveScoreStatus.liveScoreError1){
//             Loader.hide();
//             String message = state.errorData?.message ?? state.error ?? '';
//             UiHelper.toastMessage( message);
//           }
//         },
//         builder: (context,state){
//           if (state.status == LiveScoreStatus.liveScoreLoading1) {
//             return const Center(
//               child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
//             );
//           }
//           if (state.status == LiveScoreStatus.liveScoreError1) {
//             int statusCode = state.errorData?.code ?? 0;
//             String? error = state.errorData?.message ?? state.error;
//             print('error:$error');
//             return SingleChildScrollView(
//               // physics: const AlwaysScrollableScrollPhysics(),
//               child: SizedBox(
//                 height: screenHeight * 0.5,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 14,right: 14,top: 14),
//                   child: RefreshIndicator(
//                     key: const Key('some_value'),
//                     onRefresh: _getLiveScoreApi,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         //  Image.asset('assets/images/error.png', height: 45, width: 45),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.only(left :50.0 , right: 50.0),
//                           child: statusCode == 401
//                               ? mediumText14(
//                               context, error ?? '',//'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               textColor:const Color(0xffFFFFFF)
//                           ) : mediumText14 (
//                               context, '$error\n\nClick to refresh.',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               textAlign: TextAlign.center,
//                               textColor:const Color(0xffFFFFFF)
//                           ),
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.refresh,color: Colors.white,size: 35,),
//                           onPressed: () {
//                             _getLiveScoreApi();
//                             // Handle refresh action here
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 35,
//                   color: greyColor,
//                   child: Row(
//                     mainAxisAlignment: liveScoreResponse.data?.currentInning==1?MainAxisAlignment.center:MainAxisAlignment.spaceEvenly,
//                     children: [
//                       commonText(
//                         //  data: "CRR: 9.04",
//                           data: homeTeamBatting?"CRR: ${liveScoreResponse.data?.homeTeam?.runRate.toStringAsFixed(2)}":"CRR: ${liveScoreResponse.data?.awayTeam?.runRate.toStringAsFixed(2)}",
//                           fontSize: 11,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: "Poppins",
//                           color: primaryColors),
//                       liveScoreResponse.data?.currentInning==1?const SizedBox():
//                       commonText(
//                           data: "RRR: 7.57",
//                           fontSize: 11,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: "Poppins",
//                           color: primaryColors),
//                       liveScoreResponse.data?.currentInning==1?const SizedBox():
//                       commonText(
//                           data: "TN1 needs 00 run in 00 balls to win",
//                           fontSize: 11,
//                           fontWeight: FontWeight.w300,
//                           fontFamily: "Poppins",
//                           color: primaryColors),
//                     ],
//                   ),
//                 ),
//                 Text(data!.status.toString()),
//
//                 Row(
//                   children: [
//                     Container(
//                       padding:
//                       const EdgeInsets.only(left: 14, top: 6, bottom: 6, right: 14),
//                       decoration: BoxDecoration(
//                           color: greyColor,
//                           borderRadius: BorderRadius.circular(25)),
//                       child: commonText(
//                         data: liveScoreResponse.data?.currentOver==null?"Not Started":"Over ${liveScoreResponse.data?.currentOver?.overNumber.toString()}.${liveScoreResponse.data?.currentOver?.ballByBall?.length.toString()}",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Poppins",
//                         color: primaryColors,
//                       ),
//                     ).p(15),
//                     liveScoreResponse.data?.currentOver==null?const SizedBox():
//                     SizedBox(
//                       height: 30,
//                       width: 50.w,
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: liveScoreResponse.data?.currentOver?.ballByBall?.length,
//                           scrollDirection: Axis.horizontal,
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             int? runByBall = 0;
//                             liveScoreResponse.data?.currentOver!.ballByBall![index].runs?.toJson().forEach((key, value) {
//                               if (value != 0) {
//                                 runByBall = value;
//                               }
//                             });
//                             print('runByBall:$runByBall');
//                             return Container(
//                               width: 35,
//                               decoration: runByBall == 4 || runByBall == 6
//                                   ? const BoxDecoration(
//                                   shape: BoxShape.circle, color: buttonColors):
//                               BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(color: disableColors)),
//                               child: Center(
//                                 child: commonText(
//                                   //  data: liveScoreResponse.data?.currentOver?.ballByBall![index].runs?.inField.toString()??'',
//                                   data: runByBall.toString(),
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w700,
//                                   fontFamily: "Poppins",
//                                   color: runByBall == 4 || runByBall == 6 ? black : Colors.white,
//                                 ),
//                               ),
//                             ).p(2);
//                           }),
//                     ),
//                     liveScoreResponse.data?.currentOver==null?const SizedBox():
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(color: disableColors),
//                         ),
//                         child: commonText(
//                           data: liveScoreResponse.data?.currentOver?.runs.toString()??'',
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           fontFamily: "Poppins",
//                           color: white,
//                         ).pSymmetric(h: 20, v: 2),
//                       ).p(15),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/images/Info.png",
//                       height: 13,
//                       width: 13,
//                       color: white,
//                     ),
//                     const SizedBox(width: 10),
//                     commonText(
//                         data: "Realtime Win %",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Poppins",
//                         color: white),
//                   ],
//                 ),
//                 1.h.heightBox,
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         margin: EdgeInsets.only(left: 20),
//                         height: 38,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(5),
//                               bottomLeft: Radius.circular(5)),
//                           // border: Border.all(color: primaryColors),
//                           color: buttonColors,
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.only(
//                                   left: 5, top: 3, bottom: 3, right: 3),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(30)),
//                               child: commonText(
//                                 data: "56 %",
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "Poppins",
//                                 color: black,
//                               ),
//                             ).pOnly(left: 10),
//                             commonText(
//                               data: "  TM1",
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         height: 38,
//                         margin: EdgeInsets.only(right: 20),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(5),
//                               topRight: Radius.circular(5)),
//                           // border: Border.all(color: primaryColors),
//                           color: Color(0xff3A65F4),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             commonText(
//                               data: "TM1",
//                               fontSize: 12,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: white.withOpacity(0.8),
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(
//                                   left: 5, top: 3, bottom: 3, right: 3),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(30)),
//                               child: commonText(
//                                 data: "44 %",
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: "Poppins",
//                                 color: black,
//                               ),
//                             ).pOnly(left: 10, right: 10),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 2),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     commonText(
//                         data: "Total Votes: 20K",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         fontFamily: "Poppins",
//                         color: white),
//                   ],
//                 ).pOnly(right: 18),
//                 Container(
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                       color: buttonColors,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Center(
//                     child: commonText(
//                         data: "Bet",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: "Poppins",
//                         color: black),
//                   ),
//                 ).pOnly(left: 20, right: 20, top: 20),
//                 Container(
//                   clipBehavior: Clip.hardEdge,
//                   decoration: BoxDecoration(
//                       color: white,
//                       border: Border.all(color: disableColors),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     children: [
//                       Table(
//                         columnWidths: {
//                           0: FlexColumnWidth(2),
//                         },
//                         border: TableBorder(
//                             horizontalInside:
//                             BorderSide(color: white, width: 10.0)),
//                         children: [
//                           //This table row is for the table header which is static
//                           TableRow(
//                               decoration: BoxDecoration(color: white),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 10),
//                                   child: Text(
//                                     "Batter",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black87),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "R",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "B",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "4s",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "6s",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                     child: Text(
//                                       "S/R",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black87),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//
//                           TableRow(
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   // color: Color(0xffF6F6F8),
//                                   borderRadius: BorderRadius.circular(10)),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 6),
//                                   child: Text(
//                                     'N.Name',
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text('1',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w700)),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '2',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '-',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '-',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '50.00',
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                           TableRow(
//                               decoration: BoxDecoration(
//                                   color: white,
//                                   // color: Color(0xffF6F6F8),
//                                   borderRadius: BorderRadius.circular(10)),
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 20, horizontal: 6),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         'N.Name',
//                                       ),
//                                       3.w.widthBox,
//                                       Image.asset(
//                                         "assets/images/bat.png",
//                                         scale: 3,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text('1',
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w700)),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '2',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '-',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '-',
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Padding(
//                                     padding:
//                                     const EdgeInsets.symmetric(vertical: 20),
//                                     child: Text(
//                                       '50.00',
//                                     ),
//                                   ),
//                                 ),
//                               ])
//                         ],
//                       ).pSymmetric(h: 10),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: greyColor,
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10))),
//                         height: 3.h,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 4.w.widthBox,
//                                 Image.asset(
//                                   'assets/images/partnership2.png',
//                                   scale: 3,
//                                 ),
//                                 2.w.widthBox,
//                                 commonText(
//                                     data: '62 (37)',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w400)
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   'assets/images/LastWicket.png',
//                                   scale: 3,
//                                 ),
//                                 2.w.widthBox,
//                                 commonText(
//                                     data: 'N Name',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w400),
//                                 2.w.widthBox,
//                                 commonText(
//                                     data: '39 (25)',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w400),
//                                 4.w.widthBox,
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ).p(20),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: white,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: disableColors),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           commonText(
//                               data: "Bowler",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black),
//                           commonText(
//                               data: "O",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black),
//                           commonText(
//                               data: "M",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black),
//                           commonText(
//                               data: "R",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black),
//                           commonText(
//                               data: "W",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black),
//                           commonText(
//                               data: "ECON",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w700,
//                               fontFamily: "Poppins",
//                               color: Colors.black)
//                         ],
//                       ).pOnly(left: 10, right: 10, top: 5),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           commonText(
//                               data: "Name",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors),
//                           commonText(
//                               data: "1",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors),
//                           commonText(
//                               data: "2",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors),
//                           commonText(
//                               data: "-",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors),
//                           commonText(
//                               data: "-",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors),
//                           commonText(
//                               data: "-",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors)
//                         ],
//                       ).pOnly(left: 10, right: 10, top: 10, bottom: 10),
//                     ],
//                   ),
//                 ).pOnly(left: 20, right: 20),
//                 1.h.heightBox,
//                 Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                     color: greyColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: disableColors),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               3.w.widthBox,
//                               Image.asset(
//                                 'assets/images/indiaflag.png',
//                                 scale: 3,
//                               ),
//                               3.w.widthBox,
//                               Image.asset(
//                                 'assets/images/bat.png',
//                                 scale: 3,
//                               ),
//                             ],
//                           ),
//                           1.h.heightBox,
//                           commonText(
//                               data: "124-3",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors)
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           1.h.heightBox,
//                           commonText(
//                               data: "at 00.0 Overs",
//                               fontSize: 10,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors)
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/ausflag.png',
//                             scale: 3,
//                           ),
//                           1.h.heightBox,
//                           commonText(
//                               data: "97-3",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               fontFamily: "Poppins",
//                               color: primaryColors)
//                         ],
//                       ),
//                     ],
//                   ).pSymmetric(h: 10, v: 10),
//                 ).pOnly(left: 20, right: 20),
//                 2.h.heightBox
//               ],
//             ),
//           );
//
//         },
//       ),
//
//     );
//   }
// }

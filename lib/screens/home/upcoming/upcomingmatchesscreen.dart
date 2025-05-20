import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/upcoming_series_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class UpcomingMatchScreen extends StatefulWidget {
  const UpcomingMatchScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingMatchScreen> createState() => _UpcomingMatchScreenState();
}

class _UpcomingMatchScreenState extends State<UpcomingMatchScreen> {
  UpcomingSeriesResponse upcomingSeriesResponse = UpcomingSeriesResponse();

  late ExpandedTileController _controller;
  bool? isTrue;
  List<bool> isTrueList = [false, false];

  getUpcoming() async {
    await BlocProvider.of<LiveScoreCubit>(context).getUpcomingSeries();
  }

  Future<void> _refreshPage() async {
    await getUpcoming();
  }

  void initState() {
    getUpcoming();
    // initialize controller
    _controller = ExpandedTileController(isExpanded: true);
    isTrue = _controller.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: bgColor,
        body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
            listener: (context, state) {
          print(state.status.toString() + " this is status");
          if (state.status == LiveScoreStatus.upcomingSeriesSuccess) {
            upcomingSeriesResponse =
                state.responseData?.response as UpcomingSeriesResponse;
            Loader.hide();
          }
          if (state.status == LiveScoreStatus.upcomingSeriesError) {
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage(message);
          }

          // if (state.status == LiveScoreStatus.upcomingSeriesLoading) {
          //   Loader.show(context);
          // }
        }, builder: (context, state) {
          if (state.status == LiveScoreStatus.upcomingSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.upcomingSeriesError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            print('error:$error');
            return RefreshIndicator(
              onRefresh: _refreshPage,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: screenHeight * 0.5,
                  width: MediaQuery.of(context).size.width,

                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 14, right: 14, top: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //  Image.asset('assets/images/error.png', height: 45, width: 45),
                        const SizedBox(height: 10),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: statusCode == 401
                              ? Center(
                                child: mediumText14(
                                    context,
                                    error ??
                                        '', //'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    textColor: const Color(0xffFFFFFF)),
                              )
                              : mediumText14(
                                  // context, '$error\n\nClick to refresh.',
                              context, "${"No data found"}\n \n Click to refresh",

                              fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xffFFFFFF)),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 35,
                          ),
                          onPressed: () {
                            getUpcoming();
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
              child: Column(
                children: [
                  2.h.heightBox,
                  upcomingSeriesResponse.data?.length == null &&
                          upcomingSeriesResponse.data?.length == 0
                      ? Center(
                          child: mediumText14(context, 'No Upcoming Series',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.center,
                              textColor: const Color(0xffFFFFFF)),
                        )
                      :
                  (upcomingSeriesResponse.data?.isNotEmpty ?? false)
                      ?
                  ExpandedTileList.builder(
                          itemCount: upcomingSeriesResponse.data?.length ?? 0,
                          shrinkWrap: true,
                          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          itemBuilder: (context, index, con) {
                            return ExpandedTile(
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Color(0xff96A0B7),
                              ).rotate90(),
                              contentseparator: 3.0,
                              trailingRotation: 180,
                              theme: const ExpandedTileThemeData(
                                headerPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
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
                                            data: upcomingSeriesResponse
                                                    .data?[index].seriesName ??
                                                "",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: white,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 12.0),
                                    child: Divider(
                                      thickness: 1.0,
                                      color: buttonColors,
                                    ),
                                  ),
                                ],
                              ),
                              content:
                                      upcomingSeriesResponse
                                              .data?[index].fixtures?.length ==
                                          0
                                  ? Center(
                                      child: mediumText14(
                                          context, 'No match found',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          textAlign: TextAlign.center,
                                          textColor: const Color(0xffFFFFFF)),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: upcomingSeriesResponse
                                              .data?[index].fixtures?.length ??
                                          0,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              2.h.heightBox,
                                              Container(
                                                margin: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                        color: disableColors),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      0.5.h.heightBox,
                                                      commonText(
                                                        data: upcomingSeriesResponse
                                                                .data?[index]
                                                                .seriesName ??
                                                            "",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Poppins",
                                                        color: Colors.grey
                                                            .withOpacity(0.9),
                                                      ).centered(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Flexible(
                                                            //   child: SizedBox(
                                                            //     width: 25.w,
                                                            //     child:
                                                            //         commonText(
                                                            //       data: upcomingSeriesResponse
                                                            //               .data?[
                                                            //                   index]
                                                            //               .fixtures?[
                                                            //                   i]
                                                            //               .homeTeam
                                                            //               ?.name ??
                                                            //           "N/A",
                                                            //       fontSize: 14,
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w400,
                                                            //       fontFamily:
                                                            //           "Poppins",
                                                            //       color: Colors
                                                            //           .grey
                                                            //           .withOpacity(
                                                            //               0.9),
                                                            //     ),
                                                            //   ),
                                                            // ),

                                                            Flexible(
                                                              child: SizedBox(
                                                                width: 25.w,
                                                                child: commonText(
                                                                  data: upcomingSeriesResponse.data?[index].fixtures?[i].homeTeam?.name != null
                                                                      ? upcomingSeriesResponse.data![index].fixtures![i].homeTeam!.name!
                                                                      : upcomingSeriesResponse.data![index].fixtures![i].homeTeam?.id?.toString() ?? "N/A",
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "Poppins",
                                                                  color: Colors.grey.withOpacity(0.9),
                                                                ),
                                                              ),
                                                            ),

                                                            Container(
                                                              width: 25.w,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      top: 3,
                                                                      bottom:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0)),
                                                                  color:
                                                                      buttonColors),
                                                              child: Center(
                                                                child:
                                                                    commonText(
                                                                  alignment:
                                                                      TextAlign
                                                                          .center,
                                                                  data:
                                                                      "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(upcomingSeriesResponse.data?[index].fixtures?[i].startTimes?.first.date ?? "2025-04-04T10:00:00"))}",
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  color: black,
                                                                ),
                                                              ),
                                                            ).pOnly(
                                                                left: 32,
                                                                right: 32),
                                                            // Flexible(
                                                            //   child: SizedBox(
                                                            //     width: 25.w,
                                                            //     child:
                                                            //         commonText(
                                                            //       data: upcomingSeriesResponse
                                                            //               .data?[
                                                            //                   index]
                                                            //               .fixtures?[
                                                            //                   i]
                                                            //               .awayTeam
                                                            //               ?.name ??
                                                            //           "N/A",
                                                            //       fontSize: 14,
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w400,
                                                            //       fontFamily:
                                                            //           "Poppins",
                                                            //       color: Colors
                                                            //           .grey
                                                            //           .withOpacity(
                                                            //               0.9),
                                                            //     ),
                                                            //   ),
                                                            // ),

                                                            Flexible(
                                                              child: SizedBox(
                                                                width: 25.w,
                                                                child: commonText(
                                                                  data: upcomingSeriesResponse.data?[index].fixtures?[i].awayTeam?.name != null
                                                                      ? upcomingSeriesResponse.data![index].fixtures![i].awayTeam!.name!
                                                                      : upcomingSeriesResponse.data![index].fixtures![i].awayTeam?.id?.toString() ?? "N/A",
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "Poppins",
                                                                  color: Colors.grey.withOpacity(0.9),
                                                                ),
                                                              ),
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
                            );
                          }):Center(
                    child: mediumText14(
                      context,
                      'No Upcoming Series',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xffFFFFFF),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}


//      

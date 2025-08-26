import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/seriesmatches.dart';
import 'package:kisma_livescore/screens/events/myeventseries/myeventseriesdetail.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../cubit/livescore_cubit.dart';
import '../../series/FinishedMatchscorecard.dart';

class SeriesEventScreen extends StatefulWidget {
  String seriesId;

  SeriesEventScreen({super.key, required this.seriesId});

  @override
  State<SeriesEventScreen> createState() => _SeriesEventScreenState();
}

class _SeriesEventScreenState extends State<SeriesEventScreen> {
  bool isLoading = false;
  bool hasMore = true;
  int selectedIndex = 0;
  int pageNo = 0;
  List<MyEventsData> seriesCategoryList = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _fetchPage(pageNo);

    _scrollController.addListener(() {
      // Load more when near the end (e.g. 100 px from the right end)
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !isLoading &&
          hasMore) {
        _fetchPage(pageNo);
      }
    });

    print("Page no. in series");
    print(pageNo.toString());

    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      await BlocProvider.of<LiveScoreCubit>(context)
          .seriesMatches(widget.seriesId, pageKey.toString());
      // The actual response handling will be done in BlocConsumer listener
    } catch (e) {
      // Handle error if needed
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
        listener: (context, state) {
          if (state.status == LiveScoreStatus.seriesMatchesSuccess) {
            final response =
                state.responseData?.response as SeriesMatchesResponse;

            final newItems = response.data?.content ?? [];
            final isLastPage = response.data?.last ?? true;

            if (!mounted) return;

            setState(() {
              pageNo = (response.data?.number?.toInt() ?? 0) + 1;
              hasMore = !isLastPage;
              seriesCategoryList.addAll(newItems);

              if (selectedIndex >= seriesCategoryList.length) {
                selectedIndex = 0;
              }
            });
            Loader.hide();
          }

          if (state.status == LiveScoreStatus.seriesMatchesError) {
            showToast(
                context: context,
                message: state.errorData?.message.toString() ?? "");
          }
        },
        builder: (context, state) {
          // if (seriesCategoryList.isEmpty) {
          //   return Center(

          //     child: commonText(
          //         data: "No result found", fontSize: 14, color: Colors.white))}

          print("Page no in builder");
          print(pageNo.toString());

          if (state.status == LiveScoreStatus.seriesMatchesLoading &&
              pageNo == 0) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            controller: _scrollController,
            itemCount: seriesCategoryList.length + (hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == seriesCategoryList.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              final item = seriesCategoryList[index];
              return item.status == "Upcoming"
                  ? _buildUpcomingMatchItem(item)
                  : _buildCompletedMatchItem(item);
            },
          );
        },
      ),
    );
  }

  Widget _buildUpcomingMatchItem(MyEventsData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonText(
                  alignment: TextAlign.center,
                  data: item.seriesName ?? "",
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.homeTeamFlag.toString().isNotEmpty
                                ? item.homeTeamFlag.toString()
                                : "assets/images/iv_noflag.png",
                            // better fallback
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/iv_noflag.png",
                              fit: BoxFit.cover,
                            ),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: commonText(
                              data: item.homeTeam ?? "N/A",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Container(
                      width: 25.w,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: buttonColors,
                      ),
                      child: Center(
                        child: commonText(
                          alignment: TextAlign.center,
                          data:
                              "Starting on\n ${DateFormat("d/M/yy").format(DateTime.parse(item.matchDateTime ?? "2025-04-04T10:00:00"))}",
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: black,
                        ),
                      ),
                    ).pOnly(left: 32, right: 32),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.awayTeamFlag.toString().isNotEmpty
                                ? item.awayTeamFlag.toString()
                                : "assets/images/iv_noflag.png",
                            // better fallback
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/iv_noflag.png",
                              fit: BoxFit.cover,
                            ),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: commonText(
                              data: item.awayTeam ?? "N/A",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedMatchItem(MyEventsData item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          if (item.result == true) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return FinishedMatchScorecardScreen(
                    matchId: item.fixtureId.toString() ?? "",
                    winningTeam: item.winningTeamName.toString() ?? "");
              },
            ));
          } else {
            showToast(context: context, message: "Result not found");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: commonText(
                    alignment: TextAlign.center,
                    data: item.seriesName ?? "",
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: commonText(
                                data: item.homeTeam ?? "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (item.homeTeamRuns?.isNotEmpty ?? false)
                              Column(
                                children: List.generate(
                                  item.homeTeamRuns!.length,
                                  (i) => commonText(
                                    data:
                                        "${item.homeTeamRuns![i]}/${item.homeTeamWickets![i]}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            else
                              commonText(
                                data: "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                      item.winningTeamName != null
                          ? Center(
                              child: commonText(
                                alignment: TextAlign.center,
                                data: "${item.winningTeamName} won" ?? "N/A",
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            )
                          : Center(
                              child: commonText(
                                alignment: TextAlign.center,
                                data: "N/A",
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: commonText(
                                data: item.awayTeam ?? "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (item.awayTeamRuns?.isNotEmpty ?? false)
                              Column(
                                children: List.generate(
                                  item.awayTeamRuns!.length,
                                  (i) => commonText(
                                    data:
                                        "${item.awayTeamRuns![i]}/${item.awayTeamWickets![i]}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            else
                              commonText(
                                data: "N/A",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

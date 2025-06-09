import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kisma_livescore/utils/colorfile.dart';

import '../../cubit/livescore_cubit.dart';
import '../../responses/seriescategory.dart';
import '../../commonwidget.dart';
import 'myeventseries/seriesevent.dart';

class MyEventsSeriesScreen extends StatefulWidget {
  const MyEventsSeriesScreen({super.key});

  @override
  State<MyEventsSeriesScreen> createState() => _MyEventsSeriesScreenState();
}

class _MyEventsSeriesScreenState extends State<MyEventsSeriesScreen> {
  List<SeriesCategory> seriesCategoryList = [];
  int pageNo = 0;
  bool isLoading = false;
  bool hasMore = true;
  int selectedIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
  }

  Future<void> _fetchPage(int pageKey) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      await BlocProvider.of<LiveScoreCubit>(context)
          .seriesCategory(pageKey.toString());
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
          if (state.status == LiveScoreStatus.seriesCategorySuccess) {
            final response =
            state.responseData?.response as SeriesCategoryResponse;

            final newItems = response.data?.content ?? [];
            final isLastPage = response.data?.last ?? true;

            if (!mounted) return;

            setState(() {
              pageNo = (response.data?.number?.toInt() ?? 0) + 1;
              hasMore = !isLastPage;
              seriesCategoryList.addAll(newItems);

              // Reset selected index if out of range
              if (selectedIndex >= seriesCategoryList.length) {
                selectedIndex = 0;
              }
            });
            Loader.hide();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 10),

              // Horizontal scroll list with manual pagination
              SizedBox(
                height: 40,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: seriesCategoryList.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == seriesCategoryList.length) {
                      // Loading indicator at the end
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),
                          ),
                        ),
                      );
                    }

                    final item = seriesCategoryList[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? neonColor : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              color: isSelected ? neonColor : Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            item.name ?? "Unnamed",
                            style: TextStyle(
                              fontSize: 14,
                              color:  Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              // Dynamic content for selected item
              Expanded(
                child: seriesCategoryList.isNotEmpty
                    ? SeriesEventScreen(
                  key: ValueKey(seriesCategoryList[selectedIndex].id1),
                  seriesId: seriesCategoryList[selectedIndex].id1.toString() ?? "",
                )
                    : const SizedBox(),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Loader.hide();
    super.dispose();
  }
}

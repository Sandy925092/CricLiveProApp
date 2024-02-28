import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/events/myeventsdays.dart';
import 'package:kisma_livescore/events/myeventsseries.dart';
import 'package:kisma_livescore/events/seriesevent.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  PageController _pageController = PageController();
  int activePageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 8, top: 8, bottom: 0, right: 8),
              decoration: BoxDecoration(
                color: const Color(0xff263963),
                // borderRadius: BorderRadius.circular(
                //     6.0), // Customize border radius as desired
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: _onPressedMyFeed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // color: Colors.amber,
                          height: 30,
                          child: Center(
                            child: Text(
                              'Days',
                              style: TextStyle(
                                color: activePageIndex == 0
                                    ? neonColor
                                    : const Color(0xff96A0B7),
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        activePageIndex == 0
                            ? Container(
                                height: 2.5,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFF95E53C),
                                ),
                              )
                            : Container(
                                height: 2.5,
                                width: 80,
                                decoration:
                                    BoxDecoration(color: Color(0xff263963)),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  InkWell(
                    onTap: _onPressedDiscover,
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          child: Center(
                            child: Text(
                              'Series',
                              style: TextStyle(
                                color: activePageIndex == 1
                                    ? neonColor
                                    : const Color(0xff96A0B7),
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        activePageIndex == 1
                            ? Container(
                                height: 2.5,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFF95E53C),
                                ),
                              )
                            : Container(
                                height: 2.5,
                                width: 80,
                                decoration:
                                    BoxDecoration(color: Color(0xff263963)),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (int i) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setState(() {
                    activePageIndex = i;
                  });
                },
                children: <Widget>[
                  MyEventsDaysScreen(),
                  MyEventsSeriesScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedMyFeed() {
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 5), curve: Curves.decelerate);
  }

  void _onPressedDiscover() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 5), curve: Curves.decelerate);
  }
}

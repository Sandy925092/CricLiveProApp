import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/screens/events/myeventdays/myallevents.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants.dart';
import '../../cubit/livescore_cubit.dart';
import '../../main.dart';
import '../../utils/colorfile.dart';
import '../../utils/custom_widgets.dart';

class MyEventsDaysScreen extends StatefulWidget {
  const MyEventsDaysScreen({super.key});

  @override
  State<MyEventsDaysScreen> createState() => _MyEventsDaysScreenState();
}

class _MyEventsDaysScreenState extends State<MyEventsDaysScreen>
    with TickerProviderStateMixin {
  TabController? _controller;
  final List<String> tabTypes = ['OneDay', 'T20', 'MultiDay', 'The100', 'T10'];
  String selectedTabType = 'OneDay';


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabTypes.length, vsync: this);
    selectedTabType = tabTypes[_controller!.index];

    _controller!.addListener(() {
      if (!_controller!.indexIsChanging) {
        setState(() {
          selectedTabType = tabTypes[_controller!.index];

          print("selectedTabType");
          print(selectedTabType);
        });
      }
    });

    getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: AppBar(
              backgroundColor: const Color(0xff263963),
              bottom: ButtonsTabBar(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                radius: 30,
                height: 35,
                unselectedBackgroundColor: Colors.white,
                decoration: BoxDecoration(color: neonColor),
                controller: _controller,
                tabs: tabTypes
                    .map(
                      (type) => Tab(
                        child: Text(
                          type,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   'Today',
                //   style: TextStyle(
                //       color: white, fontSize: 16, fontWeight: FontWeight.w700),
                // ),
                Expanded(
                  child: Column(
                    children: [
                      2.h.heightBox,
                      Text(
                        selectedDate,
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {

                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
                        print("selected Date in my Event");
                        print(selectedDate);
                        getApi(0);
                      });
                    }
                  },
                  child: Icon(
                    MyFlutterApp.calendar,
                    color: white,
                    size: 30,
                  ),
                )
              ],
            ).pSymmetric(h: 3),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: List.generate(
                tabTypes.length,
                (index) => MyAllEventsScreen(tabType: tabTypes[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getApi(int pageKey) {
    isInternetConnected().then((value) {
      if (value == true) {
        BlocProvider.of<LiveScoreCubit>(context).getMyEvents(
          selectedDate,
          selectedTabType,
          pageKey.toString(),
        );
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }

  void getCurrentDate() {
    DateTime now = DateTime.now();
    selectedDate = DateFormat('yyyy-MM-dd').format(now);

    print("selectedDate");
    print(selectedDate);
  }}

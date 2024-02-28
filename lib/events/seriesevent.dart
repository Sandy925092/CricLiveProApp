import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesEventScreen extends StatefulWidget {
  const SeriesEventScreen({super.key});

  @override
  State<SeriesEventScreen> createState() => _SeriesEventScreenState();
}

class _SeriesEventScreenState extends State<SeriesEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                      color: darkBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Column(
                  children: [
                    Text(
                      '08/12',
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '16:02',
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Icon(
                  MyFlutterApp.calendar,
                  color: Color(0xff96A0B7),
                  size: 30,
                )
              ],
            ),
            ListView.builder(
                itemCount: 14,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 228, 228),
                        border: Border.all(color: txtGrey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        1.h.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                              '2nd T20 Big Bash League 2023-24',
                              style: TextStyle(
                                  color: txtGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.notifications_none_outlined,
                              color: txtGrey,
                              size: 18,
                            )
                          ],
                        ),
                        1.h.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/indiaflag.png',
                                  scale: 3,
                                ),
                                1.heightBox,
                                Text(
                                  'Team Name 1',
                                  style: TextStyle(
                                      color: Color(0xff313132),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: neonColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      'TN1 Won',
                                      style: TextStyle(
                                          color: Color(0xff001648),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                1.heightBox,
                                Text(
                                  'by 8 runs',
                                  style: TextStyle(
                                      color: Color(0xff001648),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/ausflag.png',
                                  scale: 3,
                                ),
                                1.heightBox,
                                Text(
                                  'Team Name 2',
                                  style: TextStyle(
                                      color: Color(0xff313132),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        ),
                        1.h.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: neonColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      '175/6',
                                      style: TextStyle(
                                          color: Color(0xff001648),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Text(
                                  '20.0 ov',
                                  style: TextStyle(
                                      color: Color(0xff001648),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      // color: neonColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Text(
                                      '175/6',
                                      style: TextStyle(
                                          color: Color(0xff001648),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Text(
                                  '20.0 ov',
                                  style: TextStyle(
                                      color: Color(0xff001648),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                        1.h.heightBox
                      ],
                    ).pSymmetric(h: 10),
                  );
                })
          ],
        ).pSymmetric(h: 10),
      ),
    );
  }
}

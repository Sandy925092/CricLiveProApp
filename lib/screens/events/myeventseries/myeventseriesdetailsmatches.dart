import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class MyEventSeriesDetailsMatchesScreen extends StatefulWidget {
  const MyEventSeriesDetailsMatchesScreen({super.key});

  @override
  State<MyEventSeriesDetailsMatchesScreen> createState() =>
      _MyEventSeriesDetailsMatchesScreenState();
}

class _MyEventSeriesDetailsMatchesScreenState
    extends State<MyEventSeriesDetailsMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            2.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Matches',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'All Matches >',
                  style: TextStyle(
                      color: Color(0xff96A0B7),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            ListView.builder(
                itemCount: 14,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF6F6F8),
                        borderRadius: BorderRadius.circular(7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/indiaflag.png',
                              scale: 3,
                            ),
                            1.h.heightBox,
                            Text('India')
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '1st T20 on',
                              style: TextStyle(
                                  color: txtGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            1.h.heightBox,
                            Text(
                              '11/08',
                              style: TextStyle(
                                  color: darkBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '15:03',
                              style: TextStyle(
                                  color: darkBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/ausflag.png',
                              scale: 3,
                            ),
                            1.h.heightBox,
                            Text('India')
                          ],
                        ),
                      ],
                    ).pSymmetric(h: 10, v: 10),
                  );
                })
          ],
        ).pSymmetric(h: 10),
      ),
    );
  }
}

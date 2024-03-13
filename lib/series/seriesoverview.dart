import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/series/seriesallmatches.dart';
import 'package:kisma_livescore/series/seriesmtachscorecard.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesOverviewScreen extends StatefulWidget {
  const SeriesOverviewScreen({super.key});

  @override
  State<SeriesOverviewScreen> createState() => _SeriesOverviewScreenState();
}

class _SeriesOverviewScreenState extends State<SeriesOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
                ).onTap(() {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                        builder: (context) => const SeriesAllMatchesScreen()),
                  );
                })
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
                        color: Colors.white,
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
                  ).onTap(() {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              const SeriesMatchScorecardScreen()),
                    );
                  });
                })
          ],
        ).pSymmetric(h: 10),
      ),
    );
  }
}

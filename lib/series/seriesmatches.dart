import 'package:flutter/material.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SeriesMatchesScreen extends StatefulWidget {
  const SeriesMatchesScreen({super.key});

  @override
  State<SeriesMatchesScreen> createState() => _SeriesMatchesScreenState();
}

class _SeriesMatchesScreenState extends State<SeriesMatchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
            itemCount: 14,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  1.h.heightBox,
                  Text(
                    'Thursday, January 25',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  1.h.heightBox,
                  Container(
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
                  ),
                ],
              );
            }).pSymmetric(h: 10),
      ),
    );
  }
}

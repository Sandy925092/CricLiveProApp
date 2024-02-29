import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveMatchDetailsFirst extends StatefulWidget {
  const LiveMatchDetailsFirst({Key? key}) : super(key: key);

  @override
  State<LiveMatchDetailsFirst> createState() => _LiveMatchDetailsFirstState();
}

class _LiveMatchDetailsFirstState extends State<LiveMatchDetailsFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 35,
              color: greyColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  commonText(
                      data: "CRR: 9.04",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                  commonText(
                      data: "RRR: 7.57",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                  commonText(
                      data: "TN1 needs 00 run in 00 balls to win",
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      fontFamily: "Poppins",
                      color: primaryColors),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 14, top: 6, bottom: 6, right: 14),
                  decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: commonText(
                    data: "Over 12",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: primaryColors,
                  ),
                ).p(15),
                SizedBox(
                  height: 30,
                  width: 50.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 35,
                          decoration: index == 1
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: disableColors))
                              : BoxDecoration(
                                  shape: BoxShape.circle, color: buttonColors),
                          child: Center(
                            child: commonText(
                              data: index == 1
                                  ? "2"
                                  : index == 2
                                      ? "6"
                                      : "4",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: index == 1 ? primaryColors : black,
                            ),
                          ),
                        ).p(2);
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: disableColors),
                  ),
                  child: commonText(
                    data: "24",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: primaryColors,
                  ).pSymmetric(h: 20, v: 2),
                ).p(15),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/Info.png", height: 13, width: 13),
                SizedBox(width: 10),
                commonText(
                    data: "Realtime Win %",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: primaryColors),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: primaryColors),
                      color: buttonColors,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 5, top: 3, bottom: 3, right: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: commonText(
                            data: "56 %",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: black,
                          ),
                        ).pOnly(left: 10),
                        commonText(
                          data: "  TM1",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 38,
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: primaryColors),
                      color: primaryColors,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        commonText(
                          data: "TM1",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: white.withOpacity(0.8),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 5, top: 3, bottom: 3, right: 3),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: commonText(
                            data: "44 %",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: black,
                          ),
                        ).pOnly(left: 10, right: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                commonText(
                    data: "Total Votes: 20K",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: primaryColors),
              ],
            ).pOnly(right: 18),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: buttonColors,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: commonText(
                    data: "Bet",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: black),
              ),
            ).pOnly(left: 20, right: 20, top: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: disableColors),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Batter",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "R",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "B",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "4s",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "6s",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "S/R",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black)
                    ],
                  ).pOnly(left: 10, right: 10, top: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "1",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "2",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "50.00",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ).pOnly(left: 10, right: 10, top: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),

                      // Image.asset("assets/images/bat.png" , height: 15, width: 15),

                      commonText(
                          data: "1",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "2",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "50.00",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ).pOnly(left: 10, right: 10, top: 10),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            3.w.widthBox,
                            Image.asset(
                              'assets/images/Partnership.png',
                              scale: 3,
                            ),
                            2.w.widthBox,
                            commonText(
                                data: "62(37)",
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: primaryColors),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/LastWicket.png',
                              height: 20,
                              width: 20,
                            ),
                            2.w.widthBox,
                            commonText(
                                data: "N Name 39 (25)",
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: primaryColors),
                            3.w.widthBox,
                          ],
                        ),
                      ],
                    ),
                  ).pOnly(
                    top: 18,
                  ),
                ],
              ),
            ).p(20),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: disableColors),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Bowler",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "O",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "M",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "R",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "W",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black),
                      commonText(
                          data: "ECON",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: Colors.black)
                    ],
                  ).pOnly(left: 10, right: 10, top: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(
                          data: "Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "1",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "2",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors),
                      commonText(
                          data: "-",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ).pOnly(left: 10, right: 10, top: 10, bottom: 10),
                ],
              ),
            ).pOnly(left: 20, right: 20),
            1.h.heightBox,
            Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: disableColors),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          3.w.widthBox,
                          Image.asset(
                            'assets/images/indiaflag.png',
                            scale: 3,
                          ),
                          3.w.widthBox,
                          Image.asset(
                            'assets/images/bat.png',
                            scale: 3,
                          ),
                        ],
                      ),
                      1.h.heightBox,
                      commonText(
                          data: "124-3",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ),
                  Column(
                    children: [
                      1.h.heightBox,
                      commonText(
                          data: "at 00.0 Overs",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/ausflag.png',
                        scale: 3,
                      ),
                      1.h.heightBox,
                      commonText(
                          data: "97-3",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: primaryColors)
                    ],
                  ),
                ],
              ).pSymmetric(h: 10, v: 10),
            ).pOnly(left: 20, right: 20),
          ],
        ),
      ),
    );
  }
}

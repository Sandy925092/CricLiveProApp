import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveScoredDetails extends StatefulWidget {
  const LiveScoredDetails({Key? key}) : super(key: key);

  @override
  State<LiveScoredDetails> createState() => _LiveScoredDetailsState();
}

class _LiveScoredDetailsState extends State<LiveScoredDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: buttonColors,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        children: [
                          commonText(
                              data: "IND",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: black),
                          commonText(
                                  data: "  146-2 (20.0)",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins",
                                  color: black)
                              .pOnly(top: 8),
                        ],
                      ).pOnly(left: 20),
                    ),
                  ).pOnly(left: 20, top: 20),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Row(
                        children: [
                          commonText(
                              data: "AUS",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: black),
                          commonText(
                                  data: "  000-0 (00.0)",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins",
                                  color: black)
                              .pOnly(top: 8),
                        ],
                      ).pOnly(left: 20),
                    ),
                  ).pOnly(left: 5, right: 20, top: 20),
                ),
              ],
            ),
            2.h.heightBox,

            Table(
              columnWidths: {
                0: FlexColumnWidth(2),
              },
              border: TableBorder(
                  horizontalInside: BorderSide(color: bgColor, width: 10.0)),
              children: [
                //This table row is for the table header which is static
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Batter",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: white),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "R",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "B",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "4s",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "6s",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "S/R",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: white),
                      ),
                    ),
                  ),
                ]),

                TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffF6F6F8),
                        borderRadius: BorderRadius.circular(10)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 6),
                        child: Row(
                          children: [
                            Text(
                              'N.Name',
                            ),
                            3.w.widthBox,
                            Image.asset(
                              "assets/images/bat.png",
                              scale: 3,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('1',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '2',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '-',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '-',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '50.00',
                          ),
                        ),
                      ),
                    ]),
                TableRow(
                    decoration: BoxDecoration(
                        color: Color(0xffF6F6F8),
                        borderRadius: BorderRadius.circular(10)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 6),
                        child: Row(
                          children: [
                            Text(
                              'N.Name',
                            ),
                            3.w.widthBox,
                            Image.asset(
                              "assets/images/bat.png",
                              scale: 3,
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text('1',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '2',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '-',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '-',
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            '50.00',
                          ),
                        ),
                      ),
                    ])
              ],
            ).pSymmetric(h: 10),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     commonText(
            //         data: "Batter",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black),
            //     commonText(
            //         data: "R",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black),
            //     commonText(
            //         data: "B",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black),
            //     commonText(
            //         data: "4s",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black),
            //     commonText(
            //         data: "6s",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black),
            //     commonText(
            //         data: "S/R",
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: "Poppins",
            //         color: Colors.black)
            //   ],
            // ).pOnly(left: 30, right: 30, top: 5),
            // 1.h.heightBox,
            // Container(
            //   height: 35,
            //   color: greyColor.withOpacity(0.4),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       commonText(
            //           data: "Name",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "1",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "2",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "-",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "-",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "50.00",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors)
            //     ],
            //   ).pOnly(left: 10, right: 10, top: 8, bottom: 10),
            // ).pOnly(left: 20, right: 20, top: 5),
            // 1.h.heightBox,
            // Container(
            //   height: 35,
            //   color: greyColor.withOpacity(0.4),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       commonText(
            //           data: "Name",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "1",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "2",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "-",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "-",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors),
            //       commonText(
            //           data: "50.00",
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Poppins",
            //           color: primaryColors)
            //     ],
            //   ).pOnly(left: 10, right: 10, top: 8, bottom: 10),
            // ).pOnly(left: 20, right: 20, top: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                    data: "Extras:",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: white),
                commonText(
                    data: "10",
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: white)
              ],
            ).pOnly(left: 30, right: 30, top: 10),
            Text(
              'Yet to Bat',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ).pOnly(left: 20, top: 30),
            GridView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.5),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        2.w.widthBox,
                        CircleAvatar(
                          backgroundColor: Color(0xff001548),
                          child: Image.asset(
                            'assets/images/batternew.png',
                            scale: 3,
                          ),
                        ),
                        3.w.widthBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'R Sharma (c)',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                commonText(
                                    data: "SR: 114.73",
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: primaryColors),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }).pOnly(left: 10, right: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Info.png",
                  height: 13,
                  width: 13,
                  color: white,
                ),
                SizedBox(width: 10),
                commonText(
                    data: "Realtime Win %",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    color: white),
              ],
            ),
            1.h.heightBox,
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      // border: Border.all(color: primaryColors),
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
                      // border: Border.all(color: Color(0xff3A65F4)),
                      color: Color(0xff3A65F4),
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
            ).pOnly(left: 20, right: 20, top: 20, bottom: 30),
          ],
        ),
      ),
    );
  }
}

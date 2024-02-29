import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class ForYouMatchDetails extends StatefulWidget {
  const ForYouMatchDetails({Key? key}) : super(key: key);

  @override
  State<ForYouMatchDetails> createState() => _ForYouMatchDetailsState();
}

class _ForYouMatchDetailsState extends State<ForYouMatchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
              data: "The Hundred - Womens",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
              color: Colors.white)
              .p(10),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                "assets/images/backicon.png",
                height: 0,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: primaryColors.withOpacity(0.85)
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  // Add your card title here
                  0.5.h.heightBox,

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/images/indiaflag.png",
                          height: 40,
                          width: 40,
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 3,
                                  bottom: 3),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          20.0)),
                                  color: buttonColors),
                              child: Center(
                                child: commonText(
                                  alignment: TextAlign.center,
                                  data: "Starting \n in 26’",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: black,
                                ),
                              ),
                            ).pOnly(left: 32, right: 32),
                          ],
                        ).pOnly(top: 20),
                        Image.asset(
                          "assets/images/team1.png",
                          height: 40,
                          width: 40,
                        ).pOnly(right: 30)
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        commonText(
                          data: " India",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                        commonText(
                          data: "Bangladesh",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ).pOnly(right: 10),
                      ],
                    ),
                  ),

                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
          Container(
            height: 35,
            color: greyColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                    data: "Ind Choose to bat",
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins",
                    color: primaryColors).pOnly(left : 20),

                commonText(
                    data: "India won the Toss",
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: primaryColors).pOnly(right : 20),
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
                      color: greyColor,
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
                            data: "BGD",
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
        ],
      ),
    );
  }
}

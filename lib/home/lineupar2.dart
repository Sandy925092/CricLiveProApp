import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LineUpAr2 extends StatefulWidget {
  const LineUpAr2({Key? key}) : super(key: key);

  @override
  State<LineUpAr2> createState() => _LineUpAr2State();
}

class _LineUpAr2State extends State<LineUpAr2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            1.h.heightBox,
            GridView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.5),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 226, 226, 226),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/rohit.png',
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
                                Image.asset(
                                  'assets/images/bat.png',
                                  scale: 3,
                                ),
                                1.w.widthBox,
                                Text(
                                  'All Rounder',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w200),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }).pOnly(left: 10, right: 10),
          ],
        ),
      ),
    );
  }
}

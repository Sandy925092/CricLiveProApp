import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:velocity_x/velocity_x.dart';

class LiveMatchDetails extends StatefulWidget {
  const LiveMatchDetails({Key? key}) : super(key: key);

  @override
  State<LiveMatchDetails> createState() => _LiveMatchDetailsState();
}

class _LiveMatchDetailsState extends State<LiveMatchDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Live",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              "assets/images/backicon.png",
              height: 0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            color: primaryColors1,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/team2.png",
                                  height: 35,
                                  width: 45,
                                ),
                              ],
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: commonText(
                                data: "",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                color: Colors.white)
                            .p(10)),
                  ],
                )
              ],
            ),
          ),
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
                    color: greyColor, borderRadius: BorderRadius.circular(25)),
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
                width: 230,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                   scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    return Container(
                      width: 35,
                      decoration: index == 1 ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: disableColors)
                      ) :  BoxDecoration(
                          shape: BoxShape.circle,
                        color: buttonColors),
                      child: Center(
                        child: commonText(
                          data: index == 1 ? "2" : index == 2 ? "6" : "4",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: index == 1 ?  primaryColors : black,
                        ),
                      ),).p(2);
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
                ).pSymmetric(h: 20 , v: 2),
              ).p(15),
            ],
          )
        ],
      ),
    );
  }
}

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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Info.png" , height: 13, width: 13),
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
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                      border: Border.all(color: primaryColors),
                      color: buttonColors,),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left : 5 , top : 3 , bottom: 3, right: 3),
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
                  height: 50,
                  margin: EdgeInsets.only(right: 20),

                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: primaryColors),
                    color: primaryColors,),
                  child:Row(
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
                        padding: EdgeInsets.only(left : 5 , top : 3 , bottom: 3, right: 3),
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
                      ).pOnly(left: 10 , right: 10),
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
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),

            child: Center(
              child: commonText(
                  data: "Bet",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                  color: black),
            ),
          ).pOnly(left: 20 , right: 20 , top: 20),

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
                ).pOnly(left: 10 , right: 10 , top: 5),

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
                ).pOnly(left: 10 , right: 10 , top: 10),

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
                ).pOnly(left: 10 , right: 10 , top: 10),

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
                ).pOnly(top: 20),

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
                ).pOnly(left: 10 , right: 10 , top: 5),

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
                ).pOnly(left: 10 , right: 10 , top: 0 , bottom: 10),


              ],
            ),
          ).pOnly(left : 20 , right: 20),

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
                ).pOnly(left: 10 , right: 10 , top: 5),

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
                ).pOnly(left: 10 , right: 10 , top: 0 , bottom: 10),


              ],
            ),
          ).pOnly(left : 20 , right: 20)






        ],
      ),
    );
  }
}

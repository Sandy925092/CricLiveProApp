import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/banner.png"),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/doticon.png",
                    height: 25,
                    width: 25,
                  ),
                  commonText(
                    data: "International Twenty20 Matches",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: black,
                  ),
                  Image.asset(
                    "assets/images/dropdown.png",
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Divider(
                  thickness: 1.0,
                  color: buttonColors,
                ),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: disableColors)),


                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add your card title here

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonText(
                              data: "",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: matchTitleColor,
                            ),
                            commonText(
                              data: "International Twenty20 Matches",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              color: disableColors,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right : 4.0 , top: 4.0),
                              child: Image.asset(
                                "assets/images/notification.png",
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/team2.png" , height: 40, width: 40,),
                              commonText(
                                data: "* Live",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                color: black,
                              ),
                              Image.asset("assets/images/team1.png" , height: 40, width: 40,)
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top : 0.0 , left : 8.0 , right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonText(
                                data: "Zimbabwe",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: teamColor,
                              ),
                              commonText(
                                data: "Bangladesh",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: teamColor,
                              ),
                            ],
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(top : 10.0 , left : 8.0 , right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left : 12 , top : 5 , bottom: 5, right: 12),
                                decoration: BoxDecoration(
                                    color: buttonColors,
                                    borderRadius: BorderRadius.circular(30)),
                                child: commonText(
                                  data: "146/2",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: black,
                                ),
                              ),
                              commonText(
                                data: "39.2/45 ov",
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins",
                                color: overColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right : 18.0),
                                child: commonText(
                                  data: "175",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/doticon.png",
                    height: 25,
                    width: 25,
                  ),
                  commonText(
                    data: "International Twenty20 Matches",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: black,
                  ),
                  Image.asset(
                    "assets/images/dropdown.png",
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Divider(
            thickness: 1.0,
            color: buttonColors,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/doticon.png",
                    height: 25,
                    width: 25,
                  ),
                  commonText(
                    data: "International Twenty20 Matches",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: black,
                  ),
                  Image.asset(
                    "assets/images/dropdown.png",
                    height: 25,
                    width: 25,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Divider(
            thickness: 1.0,
            color: buttonColors,
          ),
        ),
      ],
    );
  }
}

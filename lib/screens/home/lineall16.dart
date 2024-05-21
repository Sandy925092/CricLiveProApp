import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/live_score_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class LineAll16 extends StatefulWidget {
  final LiveScoreResponse tmpLiveScoreResponse;
  const LineAll16({Key? key,required this.tmpLiveScoreResponse}) : super(key: key);


  @override
  State<LineAll16> createState() => _LineAll16State();
}

class _LineAll16State extends State<LineAll16> {
  @override
  Widget build(BuildContext context) {
    final data = widget.tmpLiveScoreResponse.data;
    final expHomePlayerOrderList = data?.homeTeam?.players;
    final expAwayPlayerOrderList = data?.awayTeam?.players;
    expAwayPlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    expHomePlayerOrderList?.sort((a, b) => a.expBatOrder.compareTo(b.expBatOrder));
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: buttonColors,
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonText(
                                    data: getInitials(data?.homeTeam?.name??''),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black),
                                commonText(
                                        data: "  ${data?.homeTeam?.score.toString()}-${data?.homeTeam?.wickets.toString()} (${data?.homeTeam?.overs.toString()}.${data?.homeTeam?.balls.toString()})",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Poppins",
                                        color: black)
                                    .pOnly(top: 8),
                              ],
                            ),
                          ),
                        ),
                        2.h.heightBox,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: expHomePlayerOrderList?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return  expHomePlayerOrderList![index].expBatOrder==0?const SizedBox():
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Color(0xff001548),
                                      child: Image.asset(
                                        'assets/images/batternew.png',
                                        scale: 3,
                                      ),
                                    ),
                                    2.w.widthBox,
                                    Expanded(
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                flex:8,
                                                child: mediumText14(context, expHomePlayerOrderList![index].shortName??'',fontWeight:FontWeight.w700,
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ),
                                              const SizedBox(width: 2,),
                                              (expHomePlayerOrderList[index].isCap==true && expHomePlayerOrderList[index].isWK==true)?
                                              Flexible(
                                                flex:5,
                                                child: mediumText14(context,"(C&WK)",fontWeight:FontWeight.w400,fontSize: 11, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):expHomePlayerOrderList[index].isCap==true?
                                              Flexible(
                                                flex:3,
                                                child: mediumText14(context,"(C)",fontWeight:FontWeight.w500,fontSize: 12, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):expHomePlayerOrderList[index].isWK==true?
                                              Flexible(
                                                flex:3,
                                                child: mediumText14(context,"(WK)",fontWeight:FontWeight.w500,fontSize: 12, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):const SizedBox(),

                                            ],
                                          ),
                                         /* Row(
                                            children: [
                                              smallText12(context, 'LH',fontSize: 11),
                                              1.w.widthBox,
                                              Image.asset(
                                                'assets/images/bat.png',
                                                scale: 3,
                                              ),
                                            ],
                                          )*/
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                commonText(
                                    data: getInitials(data?.awayTeam?.name??''),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: black),
                                commonText(
                                    data: "  ${data?.awayTeam?.score.toString()}-${data?.awayTeam?.wickets.toString()} (${data?.awayTeam?.overs.toString()}.${data?.awayTeam?.balls.toString()})",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: "Poppins",
                                        color: black)
                                    .pOnly(top: 8),
                              ],
                            )
                          ),
                        ),
                        2.h.heightBox,
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: expAwayPlayerOrderList?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return  expAwayPlayerOrderList![index].expBatOrder==0?const SizedBox():Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(3)),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xff001548),
                                      child: Image.asset(
                                        'assets/images/batternew.png',
                                        scale: 3,
                                      ),
                                    ),
                                    2.w.widthBox,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                flex:8,
                                                child: mediumText14(context, expAwayPlayerOrderList[index].shortName??'',fontWeight:FontWeight.w700,
                                                  maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ),
                                              const SizedBox(width: 2,),
                                              (expAwayPlayerOrderList[index].isCap==true && expAwayPlayerOrderList[index].isWK==true)?
                                              Flexible(
                                                flex:5,
                                                child: mediumText14(context,"(C&WK)",fontWeight:FontWeight.w400,fontSize: 11, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):expAwayPlayerOrderList[index].isCap==true?
                                              Flexible(
                                                flex:3,
                                                child: mediumText14(context,"(C)",fontWeight:FontWeight.w500,fontSize: 12, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):expAwayPlayerOrderList[index].isWK==true?
                                              Flexible(
                                                flex:3,
                                                child: mediumText14(context,"(WK)",fontWeight:FontWeight.w500,fontSize: 12, maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ):const SizedBox(),

                                            ],
                                          ),
                                          /* Row(
                                            children: [
                                              smallText12(context, 'LH',fontSize: 11),
                                              1.w.widthBox,
                                              Image.asset(
                                                'assets/images/bat.png',
                                                scale: 3,
                                              ),
                                            ],
                                          )*/
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              8.h.heightBox,

            ],
          ),
        ),
      ),
    );
  }
}

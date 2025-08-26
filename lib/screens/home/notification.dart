import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/notification.dart';

import '../../constants.dart';
import '../../cubit/livescore_cubit.dart';
import '../../utils/colorfile.dart';
import '../../utils/custom_widgets.dart';
import '../../utils/shared_preference.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String token = "";

  List<NotificationData> notificationList = [];

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A3C),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(57.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          centerTitle: false,
          titleSpacing: 17,
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
              const SizedBox(width: 8),
              commonText(
                data: "Notification",
                fontSize: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
        listener: (context, state) {
          if (state.status == LiveScoreStatus.getNotificationsSuccess) {
            NotificationResponse notificationResponse =
                state.responseData?.response as NotificationResponse;

            if (notificationResponse.data?.length != 0) {
              notificationList.addAll(notificationResponse.data ?? []);
            }
          }
        },
        builder: (context, state) {
          if (state.status == LiveScoreStatus.getNotificationsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return notificationList.length != 0
              ? ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    DateTime utcDate = DateTime.parse(
                        notificationList[index].createdAt.toString());
                    DateTime localDate = utcDate.toLocal();
                    String formattedTime =
                        DateFormat('hh:mm a').format(localDate);
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(localDate);

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: commonText(
                                data: "$formattedDate, $formattedTime",
                                fontSize: 13,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.all(
                                    Radius.circular(10)),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(color: neonColor),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: commonText(
                                        data: notificationList[index]
                                            .title
                                            .toString(),
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: commonText(
                                      data: notificationList[index]
                                          .message
                                          .toString(),
                                      fontSize: 14,
                                      maxLines: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.white,
                          )
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: commonText(
                      data: "No Notification Found",
                      fontSize: 14,
                      color: Colors.white),
                );
        },
      ),
    );
  }

  void getToken() {
    token = PreferenceManager.getStringValue(key: "token") ?? '';

    isInternetConnected().then((value) async {
      if (value == true) {
        await BlocProvider.of<LiveScoreCubit>(context).getNotifications(token);
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/home/homeScreen.dart';
import 'package:kisma_livescore/settings/helpandsupport.dart';
import 'package:kisma_livescore/settings/privacypolicy.dart';
import 'package:kisma_livescore/settings/termsandcondition.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColors,
          elevation: 0.0,
          leadingWidth: 30,
          centerTitle: false,
          title: commonText(
                  data: "Settings",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  color: Colors.white)
              .p(10),
          // leading: GestureDetector(
          //   onTap: () {
          //     PersistentNavBarNavigator.pushNewScreen(
          //       context,
          //       screen: const HomeScreen(),
          //       withNavBar: true, // OPTIONAL VALUE. True by default.
          //       pageTransitionAnimation:
          //       PageTransitionAnimation.cupertino,
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10.0),
          //     child: Image.asset(
          //       "assets/images/backicon.png",
          //       height: 0,
          //     ),
          //   ),
          // ),
        ),
      ),
      body: Column(
        children: [
          1.5.h.heightBox,
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                  data: "Help and Support",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: primaryColors1,
                ).pOnly(left: 20),
                Image.asset(
                  "assets/images/forward.png",
                  height: 23,
                ).pOnly(right: 20)
              ],
            ),
          ).pOnly(left: 20, right: 20, top: 20).onTap(() {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const HelpAndSupport(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                  data: "Privacy Policy",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: primaryColors1,
                ).pOnly(left: 20),
                Image.asset(
                  "assets/images/forward.png",
                  height: 23,
                ).pOnly(right: 20)
              ],
            ),
          ).pOnly(left: 20, right: 20, top: 13).onTap(() {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const PrivacyPolicy(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                  data: "Terms and Conditions",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: primaryColors1,
                ).pOnly(left: 20),
                Image.asset(
                  "assets/images/forward.png",
                  height: 23,
                ).pOnly(right: 20)
              ],
            ),
          ).pOnly(left: 20, right: 20, top: 13).onTap(() {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const TermsAndCondition(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/screens/auth/login.dart';
import 'package:kisma_livescore/screens/home/homeScreen.dart';
import 'package:kisma_livescore/screens/settings/helpandsupport.dart';
import 'package:kisma_livescore/screens/settings/privacypolicy.dart';
import 'package:kisma_livescore/screens/settings/termsandcondition.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
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
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonText(
                  data: "Logout",
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
            logoutBottomSheet(context);
          }),
        ],
      ),
    );
  }
}


Future<void> logoutBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.only(left: 24,right: 24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UiHelper.verticalSpace(height: 14),
                    Center(
                      child: Container(
                        height: 9,
                        width: 85,
                        decoration:  BoxDecoration(
                        //  color: Colors.grey.shade200,
                          color: Color(0xffD9D9D9),
                          borderRadius: const BorderRadius.all(Radius.circular(4.5)),
                        ),
                      ),
                    ),
                    UiHelper.verticalSpace(height: 28),
                    largeText16(context, 'Are you sure you want to logout?',fontSize: 20,
                        fontWeight:FontWeight.w400,textColor: Color(0xff000000)),
                    UiHelper.verticalSpace(height: 36),
                    commonButton(context: context, labelText: 'Yes',
                        height: 45,
                        buttonColor: Color(0xff009e49),
                        textColor: Colors.white,
                        onTap: (){
                          UiHelper.toastMessage('Logout Successfully');
                          PreferenceManager.clearPreferences();
                          CustomNavigator.pushAndRemoveUntil(context: context, screen: const Login());
                        }
                    ),
                    UiHelper.verticalSpace(height: 12),
                    commonButton(context: context,
                        height: 45,
                        labelText: 'Cancel',buttonColor: const Color(0xffBF0A30),
                        textColor: Colors.white,
                        onTap: (){Navigator.of(context).pop();}),
                    UiHelper.verticalSpace(height: 35),
                  ],
                ),
              ),
            );
          });
    },
  );
  // }
}
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/screens/auth/login.dart';
import 'package:kisma_livescore/screens/auth/reset_password.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
class OTPVerification extends StatefulWidget {
  // final Contests contest; // Accept the whole contest object
  final String fromPage;
  const OTPVerification({super.key, required this.fromPage});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int quantity = 5; // Initial quantity value
  int remainingTime = 300; // 5 minutes in seconds
  late Timer countdownTimer;
  bool isResendButtonEnabled = false;
  String currentText = "";
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(
            bottom: keyboardHeight, // Add padding for the keyboard
          ),
          decoration: const BoxDecoration(
            color: Color(0xff2D3E67),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top:16,left: 16, right: 16, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 10,width: 89,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.5),
                    color: const Color(0xffD9D9D9),
                  ),
                ),
                UiHelper.verticalSpace(height: 14),

               // largeText16(context, 'Verification Code', fontSize: 24, fontWeight: FontWeight.w500, textColor: buttonColors),

                Text('Verification Code',style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, color: buttonColors),),
                const SizedBox(height: 14),
                Text('Verification code sent to your Email Id',style: GoogleFonts.inter(color: Color(0xffFFFFFF),fontSize: 16),),
               // mediumText14(context, 'Verification code sent to your Email/Phone Number',textColor: Color(0xffFFFFFF)),
                UiHelper.verticalSpace(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              length: 4,
                              obscureText: false,
                             // backgroundColor:const Color(0xffFFFFFF),
                              obscuringCharacter: 'number',
                              blinkWhenObscuring: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                activeColor: const Color(0xffFFFFFF),
                                selectedColor: const Color(0xffFFFFFF),
                                inactiveColor: const Color(0xffFFFFFF),
                                disabledColor: const Color(0xffFFFFFF),
                                activeFillColor: const Color(0xffFFFFFF),
                                selectedFillColor:const Color(0xffFFFFFF),
                                inactiveFillColor:const Color(0xffFFFFFF),
                                errorBorderColor:const Color(0xffFFFFFF),
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(10), // Rounded corners
                                fieldHeight: 50,
                                fieldWidth: 50,
                                // inactiveColor: Colors.grey,
                                borderWidth: 1.0,
                              ),
                              cursorColor: const Color(0xff000000),
                              animationDuration: const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              //   errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),  // Shadow color
                                  offset: const Offset(0.0, -2.0),     // Only apply shadow at the top (negative Y-axis)
                                  blurRadius: 4.0,                     // Blur to spread the shadow softly
                                  spreadRadius: 2.0,                   // Spread the shadow a bit
                                ),
                              ],
                              onCompleted: (v) {
                                debugPrint("Completed");
                              },
                              onChanged: (value) {
                                debugPrint(value);
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                debugPrint("Allowing to paste $text");
                                return true;
                              },
                            ),
                          ),
                          UiHelper.verticalSpace(height: 25),
                          commonButton(
                              context: context,
                              height: 45,
                              labelText: 'Submit',
                              onTap: (){

                                if(currentText.isEmpty){
                                  UiHelper.toastMessage("Please Enter An OTP");
                                }
                                else if(currentText.length != 4){
                                  UiHelper.toastMessage("OTP Should Be Of Four Digits");
                                }else{
                                  String otp = currentText.toString();
                                  print("otp123:$otp");
                                  if(widget.fromPage=="forgotPassword"){
                                    Navigator.of(context).pop();
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                      //   BottomSheetContent(contest: contest!),
                                      const ResetPassword(),
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                    );
                                  }else{
                                //    CustomNavigator.push(context: context, screen: const FaceVerification());
                                  }

                                  /*   if(widget.fromPage=="ForgotPassword"){
                                    BlocProvider.of<SpotsBallCubit>(context).forgotOtpVerifyCall(otp,resendOtpToken.isEmpty?widget.token??'':resendOtpToken);
                                  }else{
                                    BlocProvider.of<SpotsBallCubit>(context).registerOTPVerifyCall(otp,resendOtpToken.isEmpty?widget.token??'':resendOtpToken);
                                  }*/
                                }
                              }),
                          UiHelper.verticalSpace(height: 25),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
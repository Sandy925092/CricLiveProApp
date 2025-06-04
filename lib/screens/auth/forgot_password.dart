import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/screens/auth/otp_verification.dart';
import 'package:kisma_livescore/screens/auth/reset_password.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return BlocConsumer<LiveScoreCubit, LiveScoreState>(
      listener: (context, state) {
        print('state.status:${state.status}');
        if (state.status == LiveScoreStatus.forgotPasswordSuccess) {
          UiHelper.toastMessage(state.responseData?.response ?? '');
          //  CustomNavigator.pushReplacement(context: context, screen: const ResetPassword());
          //   Navigator.of(context).pop();
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                //   BottomSheetContent(contest: contest!),
                OTPVerification(
              fromPage: 'forgotPassword',
              emailId: emailController.text.toString().toLowerCase(),
            ),
            isScrollControlled: true,
            useRootNavigator: true,
          );
        } else if (state.status == LiveScoreStatus.forgotPasswordError) {
          print(state.errorData?.message);
          String message = state.errorData?.message ?? state.error ?? "";
          UiHelper.toastMessage(message);
        }
      },
      builder: (context, state) {
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
                padding: const EdgeInsets.only(
                    top: 16, left: 22, right: 22, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.5),
                        color: const Color(0xffD9D9D9),
                      ),
                    ),
                    UiHelper.verticalSpace(height: 36),
                    Text(
                      'Forgot Password',
                      style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: buttonColors),
                    ),
                    UiHelper.verticalSpace(height: 30),
                    const SizedBox(
                      height: 16,
                    ),
                    dashboardTextField(
                      controller: emailController,
                      hintText: 'Email Id',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Image.asset(
                        "assets/images/email.png",
                        height: 16,
                        width: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    commonButton(
                        context: context,
                        labelText: 'Submit',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 45,
                        isLoading: state.status ==
                            LiveScoreStatus.forgotPasswordLoading,
                        onTap: () {
                          RegExp emailRegExp = RegExp(emailPattern.trim());
                          if (emailController.text.isEmpty) {
                            UiHelper.toastMessage("Please enter Email ID");
                          } else if (!emailRegExp
                              .hasMatch(emailController.text)) {
                            UiHelper.toastMessage(
                                "Please enter a valid email address");
                          } else {
                            isInternetConnected().then((value) {
                              if (value == true) {
                                BlocProvider.of<LiveScoreCubit>(context)
                                    .forgotPasswordCall(emailController.text
                                        .toString()
                                        .toLowerCase());
                              } else {
                                showToast(
                                    context: context, message: notConnected);
                              }
                            });
                          }
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

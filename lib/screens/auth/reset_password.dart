import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/screens/auth/otp_verification.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
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
            padding: const EdgeInsets.only(top:16,left: 22, right: 22, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 10,width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.5),
                    color: const Color(0xffD9D9D9),
                  ),
                ),
                UiHelper.verticalSpace(height: 36),
                Text('New Password',style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, color: buttonColors),),
                UiHelper.verticalSpace(height: 30),
                const SizedBox(height: 16,),
                dashboardTextField(
                  controller: newPasswordController,
                  hintText: 'New Password',
                  obscureText: !_isPasswordVisible1,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 25,
                  prefixIcon:Image.asset("assets/images/password.png", height: 15, width: 15,),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: _isPasswordVisible1
                          ? Image.asset("assets/images/eye_show.png", height: 15, width: 15,):
                      Image.asset("assets/images/eye_off.png", height: 15, width: 15,),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible1 = !_isPasswordVisible1;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                dashboardTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: !_isPasswordVisible2,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  maxLength: 25,
                  prefixIcon:Image.asset("assets/images/password.png", height: 15, width: 15,),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: _isPasswordVisible2
                          ? Image.asset("assets/images/eye_show.png", height: 15, width: 15,):
                      Image.asset("assets/images/eye_off.png", height: 15, width: 15,),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible2 = !_isPasswordVisible2;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24,),
                const SizedBox(height: 20,),
                commonButton(
                  context: context,
                  labelText: 'Submit',fontSize: 18,fontWeight: FontWeight.w600,height: 45,
                  //   isLoading: state.status == LiveScoreStatus.helpAndSupportLoading,
                  onTap: () {
                  /*  Navigator.of(context).pop();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                      //   BottomSheetContent(contest: contest!),
                      const OTPVerification(fromPage:'signUp'),
                      isScrollControlled: true,
                      useRootNavigator: true,
                    );*/
                    RegExp passwordRegExp = RegExp(passwordPattern.trim());
                    if (newPasswordController.text.isEmpty) {
                      UiHelper.toastMessage(EMPTY_NEW_PASSWORD_VALIDATION ?? '');
                    }else if (newPasswordController.text.length < 8 ||
                        newPasswordController.text.length > 16) {
                      snackBarMessage(context,
                          'Password should be Between 8-16 characters long and it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.');
                    } else if (!passwordRegExp
                        .hasMatch(newPasswordController.text)) {
                      snackBarMessage(context, PASSWORD_LENGTH_VALIDATION);
                    } else if (confirmPasswordController.text.isEmpty) {
                      UiHelper.toastMessage(
                          EMPTY_CONFIRM_PASSWORD_VALIDATION ?? '');
                    } else if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      UiHelper.toastMessage(
                          MATCHING_PASSWORD_VALIDATION ?? '');
                    }else{
                      //BlocProvider.of<LiveScoreCubit>(context).helpAndSupportCall(emailController.text, queryController.text);
                      //    BlocProvider.of<LiveScoreCubit>(context).twoStepVerifyOTPCall(currentText);


                    }

                  },
                ),
                const SizedBox(height: 40,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

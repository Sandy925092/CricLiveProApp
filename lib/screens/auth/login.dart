import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/screens/auth/forgot_password.dart';
import 'package:kisma_livescore/screens/auth/otp_verification.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? selectedCountry;
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height:screenHeight,
        // Setting the image as the background
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'), // Replace with your image
            fit: BoxFit.cover, // Ensures the image covers the container
          ),
        ),
        // Adding text on top of the background
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.26,),
                Image.asset('assets/images/kisma_logo.png',width: 277,height: 57,),
                const SizedBox(height: 100,),
                largeText16(context, 'Login',fontSize: 32,fontWeight: FontWeight.w700,textColor:buttonColors),
                const SizedBox(height: 16,),
                dashboardTextField(controller: emailController,
                  hintText: 'Email Id',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon:Image.asset("assets/images/email.png", height: 16, width: 16,),
                ),
                const SizedBox(height: 12,),
                dashboardTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: !_isPasswordVisible1,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon:Image.asset("assets/images/password.png", height: 15, width: 15,),
                  suffixIcon: IconButton(
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
                const SizedBox(height: 12,),
                MyInkWell(
                  onTap: ()async{
                    showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                      //   BottomSheetContent(contest: contest!),
                      // const OTPVerification(fromPage:'signUp'),
                      const ForgotPassword(),
                      isScrollControlled: true,
                      useRootNavigator: true,
                    );
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password?',style: GoogleFonts.inter(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)),
                ),
                const SizedBox(height: 32,),
                commonButton(
                  context: context,
                  labelText: 'Log In',fontSize: 18,fontWeight: FontWeight.w600,height: 45,
                  //   isLoading: state.status == LiveScoreStatus.helpAndSupportLoading,
                  onTap: () {

                    RegExp emailRegExp = RegExp(emailPattern.trim());
                    RegExp passwordRegExp = RegExp(passwordPattern.trim());
                    if(nameController.text.isEmpty){
                      UiHelper.toastMessage("Please enter Name");
                    } else if(emailController.text.isEmpty){
                      UiHelper.toastMessage("Please enter Email ID");
                    }else if (!emailRegExp.hasMatch(emailController.text)) {
                      UiHelper.toastMessage("Please enter a valid email address");
                    }else if (passwordController.text.length < 8 ||
                        passwordController.text.length > 16) {
                      snackBarMessage(context,
                          'Password should be Between 8-16 characters long and it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.');
                    } else if (!passwordRegExp
                        .hasMatch(passwordController.text)) {
                      snackBarMessage(context, PASSWORD_LENGTH_VALIDATION);
                    } else if (confirmPasswordController.text.isEmpty) {
                      UiHelper.toastMessage(
                          EMPTY_CONFIRM_PASSWORD_VALIDATION ?? '');
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      UiHelper.toastMessage(
                          MATCHING_PASSWORD_VALIDATION ?? '');
                    }else{
                      //BlocProvider.of<LiveScoreCubit>(context).helpAndSupportCall(emailController.text, queryController.text);
                      //    BlocProvider.of<LiveScoreCubit>(context).twoStepVerifyOTPCall(currentText);


                    }
                  },
                ),
                /*   Container(
                   height: 40,
                   width: MediaQuery.of(context).size.width,
                   decoration: const BoxDecoration(
                       color: buttonColors,
                       borderRadius: BorderRadius.all(Radius.circular(10))),
                   child: Center(
                     child: commonText(
                         data: "Bet",
                         fontSize: 18,
                         fontWeight: FontWeight.w700,
                         fontFamily: "Poppins",
                         color: black),
                   ),
                 ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/bottomnavbar.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/responses/login_response.dart';
import 'package:kisma_livescore/responses/sign_up_response.dart';
import 'package:kisma_livescore/screens/auth/forgot_password.dart';
import 'package:kisma_livescore/screens/auth/otp_verification.dart';
import 'package:kisma_livescore/screens/auth/signup.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff001648),
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context, state) {
          print('state.status:${state.status}');
          if (state.status == LiveScoreStatus.loginSuccess) {
            LoginResponse loginResponse = state.responseData?.response as LoginResponse;
            UiHelper.toastMessage(loginResponse.message ?? '');
            if(loginResponse.data?.otpVerified == true){
              print('loginResponse.data?.email.toString():${loginResponse.data?.email.toString()}');
              PreferenceManager.insertValue(key: EMAIL_ID, value: loginResponse.data?.email.toString());
              PreferenceManager.insertValue(key: USER_ID, value: loginResponse.data?.id.toString());
              CustomNavigator.pushAndRemoveUntil(context: context, screen: Dashboard(menuScreenContext: context));
            }else{
             // CustomNavigator.push(context: context, screen:  OtpScreen(token:signInResponse.data?.token.toString(),email:emailPhoneController.text));
              showModalBottomSheet(
                context: context,
                builder: (context) =>
                //   BottomSheetContent(contest: contest!),
                OTPVerification(fromPage:'login',emailId: emailController.text.toString().toLowerCase(),),
                isScrollControlled: true,
                useRootNavigator: true,
              );

            }

          }
          if (state.status == LiveScoreStatus.loginError) {
            print(state.errorData?.message);
            String message = state.errorData?.message ?? state.error ?? "";
            UiHelper.toastMessage(message);
          }
        },
        builder: (context, state) {
          return  Container(
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
                      textInputAction: TextInputAction.done,
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
                      isLoading: state.status == LiveScoreStatus.loginLoading,
                      onTap: () {
                        RegExp emailRegExp = RegExp(emailPattern.trim());
                       if(emailController.text.isEmpty){
                          UiHelper.toastMessage("Please enter email id");
                        }else if (!emailRegExp.hasMatch(emailController.text)) {
                          UiHelper.toastMessage("Please enter a valid email address");
                        }else if(passwordController.text.isEmpty){
                          UiHelper.toastMessage("Please enter your password");
                        }else{
                          BlocProvider.of<LiveScoreCubit>(context).loginCall(emailController.text.toString().toLowerCase(),passwordController.text);
                        }
                      },
                    ),
                    UiHelper.verticalSpace(height: 58),
                    Text("Don't have an account?",style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 16,color: Color(0xffFFFFFF)),), UiHelper.verticalSpace(height: 8),
                    MyInkWell(
                        onTap: ()async{
                          CustomNavigator.push(context: context, screen: const SignUp());
                        },
                        child: largeText16(context, 'Sign Up',fontSize: 18,fontWeight: FontWeight.w600,textColor:buttonColors)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

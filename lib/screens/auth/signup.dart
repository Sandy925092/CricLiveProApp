import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/customwidget/custom_navigator.dart';
import 'package:kisma_livescore/responses/sign_up_response.dart';
import 'package:kisma_livescore/screens/auth/login.dart';
import 'package:kisma_livescore/screens/auth/otp_verification.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
       backgroundColor: Color(0xff001648),
       body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
         listener: (context, state) {
           if (state.status == LiveScoreStatus.signUpSuccess) {
             SignUpResponse signUpResponse = state.responseData?.response as SignUpResponse;
             UiHelper.toastMessage(signUpResponse.message ?? '');
          /*   CustomNavigator.push(
                 context: context,
                 screen: OtpScreen(
                     token: signUpResponse.data?.token.toString(),
                     email: emailController.text));*/
             showModalBottomSheet(
                           context: context,
                           builder: (context) =>
                           //   BottomSheetContent(contest: contest!),
                           OTPVerification(fromPage:'signUp',emailId: emailController.text.toString().toLowerCase(),),
                           isScrollControlled: true,
                           useRootNavigator: true,
                         );
           }
           if (state.status == LiveScoreStatus.signUpError) {
             print(state.errorData?.message);
             String message = state.errorData?.message ?? state.error ?? "";
             UiHelper.toastMessage(message);
           }
         },
         builder: (context, state) {
           return Container(
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
                     SizedBox(height: screenHeight*0.20,),
                     Image.asset('assets/images/kisma_logo.png',width: 277,height: 57,),
                     const SizedBox(height: 100,),
                     largeText16(context, 'Sign Up',fontSize: 32,fontWeight: FontWeight.w700,textColor:buttonColors),
                     const SizedBox(height: 16,),
                     dashboardTextField(controller: nameController,
                       hintText: 'Name',
                       keyboardType: TextInputType.name,
                       textCapitalization:TextCapitalization.words,
                       textInputAction: TextInputAction.next,
                       prefixIcon:Image.asset("assets/images/profile.png", height: 16, width: 16,),
                     ),
                     const SizedBox(height: 12,),
                     dashboardTextField(controller: emailController,
                       hintText: 'Email Id',
                       keyboardType: TextInputType.emailAddress,
                       textInputAction: TextInputAction.next,
                       prefixIcon:Image.asset("assets/images/email.png", height: 16, width: 16,),
                     ),
                     const SizedBox(height: 12,),
                     dashboardTextField(
                       readOnly:true,
                       controller: countryController,
                       hintText: 'Country',
                       keyboardType: TextInputType.name,
                       textInputAction: TextInputAction.next,
                       prefixIcon:Image.asset("assets/images/country.png", height: 16, width: 16,),
                       suffixIcon:Padding(
                         padding: const EdgeInsets.only(right: 16),
                         child: Image.asset("assets/images/down.png", height: 12, width: 14,),
                       ),
                       onTap: () {
                         showCountryPicker(
                           context: context,
                           //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                           //    exclude: <String>['KN', 'MF'],
                           //     favorite: <String>['SE'],
                           //Optional. Shows phone code before the country name.
                           showPhoneCode: false,
                           onSelect: (Country country) {
                             print('Select country: ${country.displayNameNoCountryCode}');
                             countryController.text = country.displayNameNoCountryCode;
                           },
                           // Optional. Sheet moves when keyboard opens.
                           moveAlongWithKeyboard: false,
                           // Optional. Sets the theme for the country list picker.
                           countryListTheme: CountryListThemeData(
                             // Optional. Sets the border radius for the bottomsheet.
                             borderRadius: BorderRadius.only(
                               topLeft: Radius.circular(40.0),
                               topRight: Radius.circular(40.0),
                             ),
                             // Optional. Styles the search field.
                             inputDecoration: InputDecoration(
                               labelText: 'Search',
                               hintText: 'Start typing to search',
                               prefixIcon: const Icon(Icons.search),
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: const Color(0xFF8C98A8).withOpacity(0.2),
                                 ),
                               ),
                             ),
                             // Optional. Styles the text in the search field
                             searchTextStyle: TextStyle(
                               color: Colors.blue,
                               fontSize: 18,
                             ),
                           ),
                         );
                       },
                     ),
                     const SizedBox(height: 12,),
                     dashboardTextField(
                       controller: passwordController,
                       hintText: 'Password',
                       obscureText: !_isPasswordVisible1,
                       textCapitalization:TextCapitalization.sentences,
                       keyboardType: TextInputType.name,
                       textInputAction: TextInputAction.next,
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
                       textCapitalization:TextCapitalization.sentences,
                       keyboardType: TextInputType.name,
                       textInputAction: TextInputAction.next,
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
                     commonButton(
                       context: context,
                       labelText: 'Sign Up',fontSize: 18,fontWeight: FontWeight.w600,height: 45,
                       isLoading: state.status == LiveScoreStatus.signUpLoading,
                       onTap: () {
                         /*showModalBottomSheet(
                           context: context,
                           builder: (context) =>
                           //   BottomSheetContent(contest: contest!),
                           const OTPVerification(fromPage:'signUp'),
                           isScrollControlled: true,
                           useRootNavigator: true,
                         );*/
                         RegExp emailRegExp = RegExp(emailPattern.trim());
                         RegExp passwordRegExp = RegExp(passwordPattern.trim());
                         if(nameController.text.isEmpty){
                           UiHelper.toastMessage("Please enter Name");
                         } else if(emailController.text.isEmpty){
                           UiHelper.toastMessage("Please enter Email ID");
                         }else if (!emailRegExp.hasMatch(emailController.text)) {
                           UiHelper.toastMessage("Please enter a valid email address");
                         }else if (countryController.text.isEmpty) {
                           UiHelper.toastMessage("Please select country");
                         }
                         else if (passwordController.text.isEmpty) {
                           UiHelper.toastMessage(EMPTY_PASSWORD_VALIDATION ?? '');
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
                           Map<String, dynamic> signUpDetails = {
                             "name": nameController.text,
                             "email": emailController.text.toString().toLowerCase(),
                             "country": countryController.text,
                             "password": passwordController.text,
                             "confirmPassword": confirmPasswordController.text,
                           };
                           print('signUpDetails:$signUpDetails');
                          BlocProvider.of<LiveScoreCubit>(context).signUpCall(signUpDetails);

                         }
                       },
                     ),
                     UiHelper.verticalSpace(height: 16),
                     Text('Already have an account?',style: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 16,color: Color(0xffFFFFFF)),), UiHelper.verticalSpace(height: 8),
                     MyInkWell(
                         onTap: ()async{
                           CustomNavigator.push(context: context, screen: const Login());
                         },
                         child: largeText16(context, 'Login',fontSize: 18,fontWeight: FontWeight.w600,textColor:buttonColors)),
                     UiHelper.verticalSpace(height: 16),

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

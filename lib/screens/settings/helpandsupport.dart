import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  TextEditingController emailController = TextEditingController();
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        title: "Help and Support",
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context,state){
          if(state.status == LiveScoreStatus.helpAndSupportSuccess){
            String msg = state.responseData?.response??'';
            UiHelper.toastMessage(msg);
            Navigator.of(context).pop();
          }
          if(state.status == LiveScoreStatus.helpAndSupportError){
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage(message);
          }
        },
        builder: (context,state){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:20,left: 20,right: 20,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: emailController,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: const TextStyle(
                          color: white, fontSize: 14, fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: primaryColors,
                          width: 1.0,
                        ),
                      ),
                      prefixIcon: Image.asset(
                        "assets/images/user.png",
                        scale: 4,
                        color: white,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    // height: 134,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: queryController,
                      maxLines: 4,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Your Query',
                        hintStyle: const TextStyle(
                          color: white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: primaryColors,
                            width: 1.0,
                          ),
                        ),
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      ),

                    ),
                  ),
                  const SizedBox(height: 60,),
                  commonButton(
                    context: context,
                    labelText: 'Submit',fontSize: 16,fontWeight: FontWeight.w700,height: 45,
                    buttonColor: greyColor,
                    isLoading: state.status == LiveScoreStatus.helpAndSupportLoading,
                    onTap: () {
                      RegExp emailRegExp = RegExp(emailPattern.trim());
                      if(emailController.text.isEmpty){
                        UiHelper.toastMessage("Please enter Email ID");
                        return;
                      }else if (!emailRegExp
                          .hasMatch(emailController.text)) {
                        UiHelper.toastMessage("Please enter a valid email address");
                      }else if (queryController.text.isEmpty) {
                        UiHelper.toastMessage("Please enter your query");
                      }else{
                        BlocProvider.of<LiveScoreCubit>(context).helpAndSupportCall(emailController.text, queryController.text);
                    //    BlocProvider.of<LiveScoreCubit>(context).twoStepVerifyOTPCall(currentText);
                      }
                    },
                  ),

                 /* Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: commonText(
                          data: "Submit",
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          color: primaryColors),
                    ),
                  ).pOnly(left: 20, right: 20, top: 20),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

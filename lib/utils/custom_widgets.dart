
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? leadingOnTap;
  final double titleFontSize;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingOnTap,
    this.titleFontSize = 18, // Default font size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColors,
        elevation: 0.0,
        leadingWidth: 30,
        centerTitle: false,
        title:commonText(
            data: title,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: Colors.white).p(10),
        leading: GestureDetector(
          onTap: leadingOnTap ?? () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              "assets/images/backicon.png",
              height: 0,
            ), // Use your desired back icon
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}




void checkConnectivityAndExecute(Function onTap, BuildContext context) async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    FocusScope.of(context).requestFocus(FocusNode());
    onTap();
  }else{
    UiHelper.toastMessage(notConnected);
  }
}

class MyInkWell extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onTap;
  final String notConnectedMessage;

  const MyInkWell({
    Key? key,
    required this.child,
    required this.onTap,
    this.notConnectedMessage = notConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        checkConnectivityAndExecute(() {
          onTap();
          // Your onTap function logic goes here
        }, context);

     /*   final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap();
        } else {
          UiHelper.toastMessage(notConnectedMessage);
        }*/
      },
      child: child,
    );
  }
}


String getInitials(String teamName) {
  String initials = "";

  List<String> words = teamName.split(" ");
  words.forEach((word) {
    if (word.isNotEmpty) {
      initials += word[0];
    }
  });

  return initials;
}


Widget commonButton({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
  double height = 40.0,
  double? width = double.infinity,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.w700, //FontWeight.w400
  Color textColor = primaryColors,
  bool isLoading = false,
}) {
  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(width: 24, height: 24,
          child: CircularProgressIndicator(color:loaderColor,strokeWidth: 3.5,),)
            : largeText16(context, labelText,
            fontSize: fontSize,
            fontWeight: fontWeight,
            maxLines: 1,
            textColor: textColor,

        ),
      ),
    ),
  );
}

Widget commonButton1({
  required BuildContext context,
  required String labelText,
  VoidCallback? onTap,
  double height = 50.0,
  double? width = double.infinity,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal, //FontWeight.w400
  LinearGradient optionGradient = const LinearGradient(
    colors: [Color(0xffFF0134), Color(0xffFF0184)], // Default gradient colors
  ),
  Color textColor = const Color(0xffFFFFFF),
  bool isLoading = false,
}) {
  return MyInkWell(
    onTap: () async {
      if (onTap != null) onTap();
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: optionGradient,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(width: 24, height: 24,
          child: CircularProgressIndicator(color: CupertinoColors.white,strokeWidth:2.5),)
            : smallText12(context, labelText,
            fontSize: fontSize,
            fontWeight: fontWeight,
            maxLines: 1,
            textColor: textColor),
      ),
    ),
  );
}
Future<bool> isConnected() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }else{
    return false; // No internet connection
  }
}

/*Widget customAppbar({
  required BuildContext context,
  required  String title,
  required final VoidCallback onBackTap,
  Widget? rightWidget,

}) {
  return Container(
    height: MediaQuery.of(context).size.height/6.6,
    width: double.infinity,
    color: primaryColors,
    child: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.085,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: onBackTap,
                    child: const Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                  const SizedBox(width: 12,),
                  staticColorText(context, title,fontSize: 18,fontWeight: FontWeight.w600,textColor:Colors.white),
                ],
              ),
              if (rightWidget != null) // Only display if rightWidget is not null
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: rightWidget,
                ),

            ],
          ),

        ],
      ),
    ),
  );
}*/

showToast({required BuildContext context, required String message , ToastGravity? gravity}) {
  FToast().init(context).showToast(
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Color(0xFFFF0134),
        borderRadius: BorderRadius.circular(20),
      ),
      child:staticColorText(context, message,fontSize: 16),
    ),
    toastDuration: const Duration(seconds: 3),
    gravity: gravity ?? ToastGravity.BOTTOM,
  );
}

Widget smallText12(BuildContext context, String msg, {
  double fontSize = 12,
  Color textColor = const Color(0xff000000),
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  double? lineHeight,
  TextOverflow? overflow,
  bool isUnderlined = false,
}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      //  style:GoogleFonts.inter(fontWeight: fontWeight, fontSize: fontSize, color: localIsDarkMode?const Color(0xffFFFFFF):textColor,),
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontFamily: AppConstants.fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        height: lineHeight,
        decoration:isUnderlined ? TextDecoration.underline : TextDecoration.none,
      ),
    );



Widget mediumText14(BuildContext context, String msg, {
  double fontSize = 14,
  Color textColor = const Color(0xff000000),
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  TextOverflow? overflow,}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      // style:GoogleFonts.inter(fontWeight: fontWeight, fontSize: fontSize, color: textColor,),
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: AppConstants.fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color:textColor),
    );

Widget largeText16(BuildContext context, String msg, {
  double fontSize = 16,
  Color textColor = const Color(0xffFFFFFF),
  TextAlign textAlign = TextAlign.center,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  String fontFamily = "Poppins", // Default font family
  int? maxLines,
  double? lineHeight,
  TextOverflow? overflow,}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: lineHeight,
          color:  textColor),
    );

Widget staticColorText(BuildContext context, String msg, {
  double fontSize = 14,
  Color textColor = const Color(0xff000000),
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.normal,//FontWeight.w400
  FontStyle fontStyle = FontStyle.normal,
  int? maxLines,
  TextOverflow? overflow,}) =>
    Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style:GoogleFonts.poppins(fontWeight: fontWeight, fontSize: fontSize, color: textColor,),
      /*   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: AppConstants.fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor),*/
    );

Widget dashboardTextField({
  required String hintText,
  required TextEditingController controller,
  bool obscureText = false, // Add this parameter
  TextCapitalization textCapitalization = TextCapitalization.none,
  Widget? prefixIcon,
  Widget? suffixIcon,
  double? height,
  TextInputType? keyboardType,
  bool readOnly = false,
  double hintFontSize = 12,
  FontWeight hintFontWeight = FontWeight.w400,//FontWeight.normal
  Color hintFontColor = const Color(0xff000000),
  Color boxShadowColor = const Color(0xFFFF0235),
  double textFontSize = 12,
  FontWeight textFontWeight = FontWeight.w400,//FontWeight.normal
  Color textFontColor = const Color(0xff000000),
  EdgeInsets? contentPadding,
  TextAlign textAlign = TextAlign.start, // Add this parameter
  TextInputAction? textInputAction,
  VoidCallback? onTap,
  void Function(String)? onChanged,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
  bool isEnabled = true,
  VoidCallback? onEditingComplete, // Add this parameter
  FocusNode? focusNode, // Add this parameter
}) => Container(
  height: height ?? 60,
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(
        color: Colors.grey.withOpacity(0.3), width: 0.1,
        style: BorderStyle.solid), //Border.all
    borderRadius: const BorderRadius.all(Radius.circular(30)),
    boxShadow: [
      BoxShadow(
        // color: const Color(0xFFFF0235).withOpacity(0.25), // Specify color and opacity
        color:  boxShadowColor.withOpacity(0.25), // Specify color and opacity
        spreadRadius: 0,
        blurRadius: 4,
        offset: const Offset(0, 2.5), // Offset for bottom shadow
      ),
    ],
  ),
  child: TextFormField(
    controller: controller,
    obscureText:obscureText,
    readOnly: readOnly,
    maxLength: maxLength,
    inputFormatters: inputFormatters, // Pass inputFormatters here
    keyboardType: keyboardType,
    textCapitalization: textCapitalization,
    cursorColor: Colors.pink,
    style: GoogleFonts.inter(
      fontWeight: textFontWeight, fontSize: textFontSize,
      color: textFontColor,),
    onTap: onTap,
    onChanged:onChanged,
    enabled: isEnabled,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: contentPadding,
      hintText: hintText,
      hintStyle: GoogleFonts.inter(
        fontWeight: hintFontWeight, fontSize: hintFontSize,
        color: hintFontColor,),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
    textAlign: textAlign, // Set the text alignment
    textInputAction: textInputAction,
    onEditingComplete: onEditingComplete, // Set the onEditingComplete callback
    focusNode: focusNode, // Set the focusNode
  ),
);




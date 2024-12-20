import 'package:kisma_livescore/responses/get_country_code_abd_flag_response.dart' as dfr;

/// URL PATH
const BASEURL = 'http://34.238.14.72:8086';

const TOKEN = 'token';
const EMAIL_ID = 'emailId';
const USER_ID = 'userId';

const String notConnected = 'Please Check Your Internet Connection';

const String emailPattern =
    r'^(([^<>()[\]\\.,;:@\"]+(\.[^<>()[\]\\.,;:@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

const String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

const PASSWORD_LENGTH_VALIDATION =
    'Password should be Between 8-16 characters long.And it should contain Atleast One Number, One Special Character, One Uppercase and One Lowercase.';
const EMPTY_CONFIRM_PASSWORD_VALIDATION = 'Please Enter Confirm Password';
const EMPTY_NEW_PASSWORD_VALIDATION = 'Please Enter New Password';
const EMPTY_PASSWORD_VALIDATION = 'Please Enter Password';
const MATCHING_PASSWORD_VALIDATION = 'Password And Confirm Password Should Match';

class AppConstants {
  static const String fontFamily = "Poppins";


  static const String bowled = "0";
  static const String caught = "1";
  static const String lBW = "2";
  static const String runOut = "3";
  static const String stumped = "4";
  static const String hitWicket = "5";
  static const String handlingTheBall = "6";
  static const String hittingTheBallTwice = "7";
  static const String obstructingTheField = "8";


}


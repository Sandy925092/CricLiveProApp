// country_utils.dart


import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/responses/get_country_code_abd_flag_response.dart' as dfr;


List<dfr.Data> teamShortFormList = [];

String shortFormCountryCode(String teamName) {
  for (var country in teamShortFormList) {
    if (country.country?.toLowerCase() == teamName.toLowerCase()) {
      return country.code?.toUpperCase()??'';
    }
  }
  return getInitials(teamName); // Return null if the country is not found
}

String getCountryFlag(String teamName) {
  for (var country in teamShortFormList) {
    if (country.country?.toLowerCase() == teamName.toLowerCase()) {
      print('country.flag?.toUpperCase():${country.flag}');
      return country.flag??'';
    }
  }
  return  "assets/images/noImage.png"; // Return null if the country is not found
}
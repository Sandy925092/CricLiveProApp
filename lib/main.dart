import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kisma_livescore/bottomnavbar.dart';
import 'package:kisma_livescore/constants.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/repository/livescore_repository.dart';
import 'package:kisma_livescore/screens/auth/signup.dart';
import 'package:kisma_livescore/screens/auth/splashscreens.dart';
import 'package:kisma_livescore/screens/auth/welcome_screens.dart';
import 'package:kisma_livescore/screens/socket/ddd.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//test

bool loginValue = false;
String selectedDate = "";

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await PreferenceManager.init();

  getStoredValue();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}
/*Future<void> main() async {
  getStoredValue();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}*/


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final repository = LiveScoreRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LiveScoreCubit(repository)),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
           SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MaterialApp(
          title: 'Live Score',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff001548)),
            useMaterial3: true,
          ),
        // home: Dashboard(menuScreenContext: context),
        // home: ListViewBuilderExample(),
        // home: SignUp(),
        //  home: loginValue == true ?  Dashboard(menuScreenContext: context):const SignUp(),
        //  home: WelcomeScreens(),
          home: SplashImages(),
        );
      }),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff001548)),
          useMaterial3: true,
        ),
        home: Dashboard(menuScreenContext: context),
      );
    });
  }
}*/
Future<void> getStoredValue() async {
  var emailID = PreferenceManager.getStringValue(key: EMAIL_ID) ?? '';
  var userID = PreferenceManager.getStringValue(key: USER_ID) ?? "";
  print('emailIDMain:$emailID');
  if (emailID != '') {
    loginValue = true;
  }
  print('loginValue:$loginValue');
}
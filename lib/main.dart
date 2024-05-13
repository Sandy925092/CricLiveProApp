import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisma_livescore/bottomnavbar.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/repository/livescore_repository.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}


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
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff001548)),
            useMaterial3: true,
          ),
          home: Dashboard(menuScreenContext: context),
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

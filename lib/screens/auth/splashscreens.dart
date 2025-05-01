import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kisma_livescore/bottomnavbar.dart';
import 'package:kisma_livescore/main.dart';
import 'package:kisma_livescore/screens/auth/login.dart';
import 'package:kisma_livescore/screens/auth/signup.dart';

class SplashImages extends StatefulWidget {
  const SplashImages({super.key});

  @override
  State<SplashImages> createState() => _SplashImagesState();
}

class _SplashImagesState extends State<SplashImages> {
  List splashscreenData = [
  'assets/images/welcome1.png',
  'assets/images/welcome2.png',
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff001648),
      body:CarouselSlider.builder(
        itemCount: splashscreenData.length,
        options: CarouselOptions(
          height: double.infinity, // Make the carousel fill the available height
          // aspectRatio: 16 / 9, // Set the aspect ratio as desired
          aspectRatio: screenWidth / screenHeight, // Set the aspect ratio as desired
          viewportFraction: 1.0,
          autoPlay: true,// Make each image occupy the full width
          enableInfiniteScroll: false,
          autoPlayInterval : const Duration(seconds: 2),
          //    autoPlayCurve: Curves.easeInOutCubic,
          //   autoPlayAnimationDuration: Duration(milliseconds: 800),
          onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
              if (_currentIndex == splashscreenData.length - 1) {
                Timer(const Duration(milliseconds: 1200), () async {
                  /*  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                      (BuildContext context) => const SignUp()));*/
                  if(loginValue==true){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => Dashboard(menuScreenContext: context)), (route) => false);
                  }else{
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => Dashboard(menuScreenContext: context)), (route) => false);

                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const Login()));
                  }

                });
              }
            });
          },
        ),

        itemBuilder: (BuildContext context, int index, _) {
          return Image.asset(
            splashscreenData[index],
            fit: BoxFit.fitWidth,
            width: screenWidth,
          );
        },

      ),
      /*  body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: double.infinity,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
        //      enlargeCenterPage: false,
            //  autoPlay: true,
              autoPlay: false,
              autoPlayInterval : const Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOutCubic,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                  if (_currentIndex == splashscreenData.length - 1) {
                    Timer(const Duration(milliseconds: 1200), () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      bool? alreadyLogin = prefs.getBool("alreadyLogin");

                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                          (BuildContext context) =>  MyApp()));
                      Navigator.of(context).push(MaterialPageRoute(builder:
                          (BuildContext context) =>  HomePageScreen()));
                      if(alreadyLogin==true){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                            (BuildContext context) => const QuestionAnswer()));
                      }else{
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
                            (BuildContext context) => const LoginScreen()));
                      }
                    });
                  }
                });
              },
            ),
            items: splashscreenData.map((item) => Container(
              child: Center(
                child: Image.asset(item, fit: BoxFit.cover, height: height,),),
            )).toList(),

          );
        },
      ),*/
    );
  }
}

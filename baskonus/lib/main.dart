import 'package:baskonus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'onboard/introduction.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(  
    MaterialApp(
      theme: ThemeData(fontFamily: 'AbhayaLibre'),
    debugShowCheckedModeBanner: false,
 
    home: AnimatedSplashScreen(
        backgroundColor: Colors.blueGrey,
        splash: Image.asset('lib/images/logoEApp.png'),
        nextScreen:  const IntroductionPage(),
        splashIconSize: 400,
        splashTransition: SplashTransition.scaleTransition,
      ), 
    
   
  ) );
}



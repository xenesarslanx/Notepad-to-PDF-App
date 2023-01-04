import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {//real id:'ca-app-pub-5722581928261637/6605956742'
    if (Platform.isAndroid) {       //test id:'ca-app-pub-3940256099942544/6300978111'
      return 'ca-app-pub-5722581928261637/6605956742';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isWindows){
      return '';
    } else {
      throw  UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {//real id:"ca-app-pub-5417429060364094/1461888739"
    if (Platform.isAndroid) {             //test id: ca-app-pub-3940256099942544/1033173712  
      return "ca-app-pub-5722581928261637/8721231614";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      throw  UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {//real id:"ca-app-pub-5417429060364094/2609704477"
    if (Platform.isAndroid) {         //test id: ca-app-pub-3940256099942544/5224354917
      return "ca-app-pub-5722581928261637/1964251578";
    }  else {
      throw  UnsupportedError("Unsupported platform");
    }
  }

  /* static String get nativeAdUnitId {//real id:'ca-app-pub-5417429060364094/6082293048',
                                     //test id:'ca-app-pub-3940256099942544/2247696110'
    if (Platform.isAndroid) {         
      return "ca-app-pub-5417429060364094/6082293048";
    } 
     else {
      throw  UnsupportedError("Unsupported platform");
    }
  }*/

   /* static String get appOpenAdUnitId {//reel id: 'ca-app-pub-5417429060364094/3194644947'

                                      //test id: 'ca-app-pub-3940256099942544/3419835294'
    if (Platform.isAndroid) {         
      return "ca-app-pub-5417429060364094/3194644947";

    } 
     else {
      throw  UnsupportedError("Unsupported platform");
    }
  }*/


  
}
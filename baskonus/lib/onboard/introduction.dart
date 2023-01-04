import 'package:baskonus/admobHelper/admobHelper.dart';
import 'package:baskonus/login/signUp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class IntroductionPage extends StatefulWidget {
   const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  late BannerAd ad;
   bool isLoaded = false;

  @override
   void initState() {
    super.initState();
    ad= BannerAd(
      size: AdSize.banner, 
      adUnitId: AdHelper.bannerAdUnitId, 
      listener: BannerAdListener(onAdLoaded: (ad) {
setState(() {
  isLoaded = true;
print("111111111111");
});
}, onAdFailedToLoad: (ad, error) {
print("Ad Failed to Load with Error= $error");
}),
      request: const AdRequest(),
      
      );
      ad.load();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
      
            children:[ 
              // const Spacer(),
              isLoaded?
                SizedBox(
      height: 60,
      child:AdWidget(ad: ad,),
     ):const SizedBox(),
     const SizedBox(height: 20,),
           //   const Padding(padding: EdgeInsets.only(bottom: 65, top: 65),),
              const Text("BAS KONUŞ DÖNÜŞTÜR",style: TextStyle(color: Colors.red, fontSize: 20),),
              const SizedBox(height: 15),
                CarouselSlider(
          options: CarouselOptions( 
             height: 440, 
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
            
          ),
         
          items:  [
          Image.asset('lib/images/11.png'),
          Image.asset('lib/images/2.jpg'),
          
          ],
            ),
            const SizedBox(height: 15),
            const Text("Kayıt olun ve ister konuşun ister yazın. Yazdıklarınızı kaydedip PDF'e dönüştürün",
            style: TextStyle(color: Colors.blue, fontSize: 20, ), textAlign: TextAlign.center,),

             ElevatedButton(onPressed:(){
              setState(() {
                 Navigator.push(context,MaterialPageRoute(builder: (context) =>   const MyApp()));
              });
              }, child: const Text("Geç"), ),
           
            ]
          ),
        ),
      ),
    );
      
      
    
  }
}
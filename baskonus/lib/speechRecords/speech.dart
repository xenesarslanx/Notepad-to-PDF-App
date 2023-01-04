import 'package:baskonus/login/signUp.dart';
import 'package:baskonus/speechRecords/records.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../admobHelper/admobHelper.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  SpeechScreenState createState() => SpeechScreenState();
}

class SpeechScreenState extends State<SpeechScreen> {
  MyAppState myapp = MyAppState();
  TextEditingController textFieldKayit = TextEditingController();

  late stt.SpeechToText _speech;

  bool _isListening = false;
  String bosText = '';
  double _confidence = 1.0;
  String vtText = " ";
  String date="";

   late BannerAd ad;
   bool isLoaded = false;

   late InterstitialAd _interstitialAd;
FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
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

//geçiş reklamı
         InterstitialAd.load(
       adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
         adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad){
           _interstitialAd = ad;
         },
          onAdFailedToLoad:(error){
          print('failed geçiş reklamı');
          }
         ));
  }

  @override
  void dispose(){
 super.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        backgroundColor:  Colors.white,
        appBar: AppBar(
          title:  const Text("BAS KONUŞ ÇEVİR"),
        ),
       
  
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children:<Widget>[
               isLoaded?
                SizedBox(
      height: 60,
      child:AdWidget(ad: ad,),
     ):const SizedBox(),
     const SizedBox(height: 10,),
                Text("Mikrofon Duyarlılığı: ${(_confidence * 100.0).toStringAsFixed(1)}% \n\n Butona bas ve konuşmaya başla "),
                const SizedBox(height: 10,),
                 TextHighlight(
                   text: textFieldKayit.text,
                  // matchCase : true,
                   textStyle:  const TextStyle(
                    
                     fontSize: 20.0,
                     color: Colors.black,
                     fontWeight: FontWeight.w400,
                     
                   ), words:  const {},
                 ),
               
            TextField(  
              minLines: 2,     
              maxLines:100,
              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w300),          
              controller: textFieldKayit,
              onChanged: (text){
                setState(() {//ı ş ğ
             text = text.replaceAll(RegExp(unicode: true, r'ş'), 's');
             text = text.replaceAll(RegExp(unicode: true, r'ı'), 'i');
             text = text.replaceAll(RegExp(unicode: true, r'ğ'), 'g');
             text = text.replaceAll(RegExp(unicode: true, r'Ş'), 'S');
             text = text.replaceAll(RegExp(unicode: true, r'İ'), 'I');
             text = text.replaceAll(RegExp(unicode: true, r'Ğ'), 'G');

             vtText = text.toString();      
               });
   //    vtText = text.toString();
    //        textFieldKayit.text = text.toString();

                
               },
         decoration:  const InputDecoration(
                                              icon: Icon(Icons.mic),//// alana icon/simge verilebilir
                                              hintText: "Konuştuğunuz Alan",//Bir ipucuna stil vermek için, bir hintStyle kullanın. Bir etiketi stillendirmek için, bir labelStyle kullanın.
                                              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
                                              border: OutlineInputBorder()//TextField öğesine bir sınır vermek için “border” kullanın.
                                            ),
              ),
             const SizedBox(height: 15,),
              Column(
            children: [
              //ses ile kayıt alma butonu
              buttonMethod(()=>listen(), Colors.red,const EdgeInsets.symmetric(horizontal: 50,vertical:20) ,Icon(_isListening ? Icons.mic : Icons.mic_none)),
   const SizedBox(height: 15,),

              //yazılanı kaydetme butonu
              buttonMethod(()=>kaydet(),const Color.fromARGB(255, 7, 180, 65),const EdgeInsets.symmetric(horizontal: 50,vertical:20) ,const Text("Kaydet")),
   const SizedBox(height: 15,),
              
              //Textfield ve TextHighlight silme methodu
              buttonMethod((){setState(() {sil(bosText);
              });},Colors.red,const EdgeInsets.symmetric(horizontal: 50,vertical:20) ,const Text("Sil")),
   const SizedBox(height: 15,),
              //kaydedilenlere giden buton
              ElevatedButton(
                onPressed:(){
                  setState(() {
                              _interstitialAd.show();
                  });
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  Records()));
                
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 7, 180, 65),
                padding:   const EdgeInsets.symmetric(horizontal: 50,vertical:20)
                  ),
                 child: const Text("Kaydedilenler")),

   const SizedBox(height: 15,),
            ],          
              ),     
            ]
          ),
          
        ),
      ),
    );
  }

 
kaydet(){
 
   date = (
    "${DateTime.now().day}:${DateTime.now().month}:${DateTime.now().year}\n"//gün:ay:yıl
    "${DateTime.now().hour}:${DateTime.now().minute}");//saat:dakika
  print(date);
  
 FirebaseFirestore.instance
 .collection(auth.currentUser!.email.toString())
 .doc(vtText.toString())
 .set(
  {
  if(vtText.isNotEmpty)
  'kayıt': vtText,
  'zaman': date,

  },);
 
 print(auth.currentUser!.email.toString());
  
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("kaydedildi->kaydedilenler"),
    ));
}

 sil(String bosText){
vtText = bosText;
textFieldKayit.text = bosText;
}

  void listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
       
      );
      if (available) {
      
        setState(() => _isListening = true);
       
        _speech.listen(
       
          onResult: (val)=>       
            setState(()  {
              
           textFieldKayit.text = val.recognizedWords; 
            vtText= val.recognizedWords;

            Clipboard.setData((ClipboardData(text: textFieldKayit.text)));

            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Panoya kopyalandı"),
    ));
            }
          }
          ),
      
      );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
        
    }
   
  }
  
  //buton metotu
   ElevatedButton buttonMethod(
    onpressed, 
    Color color,
    EdgeInsetsGeometry hor,
    Widget widget)
    {
      return ElevatedButton(
            onPressed: onpressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: hor,
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)),
            ),
            child: widget,
             );
  }
 
}

 
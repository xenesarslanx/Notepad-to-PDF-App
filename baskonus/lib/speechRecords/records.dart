
import 'package:baskonus/createPdf/pdfCreate.dart';
import 'package:baskonus/speechRecords/speech.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../admobHelper/admobHelper.dart';


class Records extends StatefulWidget {
  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  FirebaseAuth auth = FirebaseAuth.instance;
 
CollectionReference collectionReference = 
FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString());

 late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

@override
  void initState(){
super.initState();
  RewardedAd.load(
       adUnitId: AdHelper.rewardedAdUnitId,
        request: const AdRequest(),
         rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad){
           _rewardedAd = ad;
           _isRewardedAdReady = true;
         },
          onAdFailedToLoad:(error){
          }
         ));
}
@override
  void dispose() {
    super.dispose();
    _rewardedAd.dispose();
  }


  metinKopyala(String id){
    print(id);
   Clipboard.setData((ClipboardData(text: id)));
   return        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Metin panoya kopyalandı!"),
    ));
}

    vtSil(String id) {
   var ref =  FirebaseFirestore
   .instance
   .collection(auth.currentUser!.email.toString())
   .doc(id).delete();
   Navigator.pop(context);
   print(auth.currentUser!.email.toString());
   print("silindi");
   return ref;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Kayıtlarım"),
        leading:  IconButton(
          onPressed: (){
            setState(() {
           Navigator.push(context,MaterialPageRoute(builder: (context) =>  const SpeechScreen()));

              _rewardedAd.show(onUserEarnedReward: (ad, reward) {
                 print("ödül");
               },);
                 RewardedAd.load(
          adUnitId: AdHelper.rewardedAdUnitId,
           request: const AdRequest(),
            rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
               _rewardedAd= ad;
               _isRewardedAdReady = true;
               
            },
           onAdFailedToLoad:(error){
          print('failed ödüllü reklam');
          } ),);

            });
         
          },
         icon: const Icon(Icons.arrow_back),color: Colors.white),
     
      ),
    body: SingleChildScrollView(
      child: Column(
        children: [
        StreamBuilder <QuerySnapshot>(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                 {  
        final veriler = snapshot.data!.docs;
                  if(snapshot.hasError ) {
                    print("errorrrrr");
                    return const CircularProgressIndicator();//Text('error: ${snapshot.error.toString()}');    
                  }
             
             if(snapshot.connectionState == ConnectionState.waiting) {
                    print("errorrrrr222222");

               return const CircularProgressIndicator();//Text('loading...');
             }
             if(snapshot.hasData){
                        print("aaaaaaaaaaaa");
                        }
     return ListView.builder(
            physics:  const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          
                   itemCount: veriler.length, 
                   itemBuilder: ( context,  index) { 
          DocumentSnapshot satirVerisi = snapshot.data!.docs[index];
           satirVerisi['kayıt'].toString();
          
           return Slidable(
            startActionPane:     ActionPane(
              motion:  const DrawerMotion(),
               children: [
                                        
                       
                        SlidableAction(
                          onPressed: (context){
                            pdfpageState().createpdf(satirVerisi.id.toString()); 
                            },
                          backgroundColor: const Color(0xFF21B7CA),
                          //foregroundColor: Colors.white,
                          icon: Icons.picture_as_pdf,
                          label: 'Görüntüle ve Dönüştür',
                        ),   
               ],
            ),
            endActionPane:   ActionPane(
    motion:  const DrawerMotion(), 
    children: [
          SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                               builder: (context)=>AlertDialog(
                                title:const Text("Sil ?"),
                                content: const Text("Yazınız silinir ve geri getirilemez, emin misiniz?"),
                                actions: [
                                  TextButton(
                                    child: const Text("İptal"),
                                    onPressed: ()=> Navigator.pop(context),
                                     ),
                                  // vtSil(satirVerisi.id),
                                  TextButton(
                                    child: const Text("Sil"),
                                    onPressed: ()=> vtSil(satirVerisi.id),
                                    
                                     ),
                                ],
                               ));
                          
                          },          
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Sil',
                        ),
    ],
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 3, top: 20) ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(184, 15, 233, 135),
              ),
              
              child:  ListTile(
                 title:Text(satirVerisi['kayıt']),//fieldAdı
               //subtitle:  ElevatedButton(onPressed: ()=> vtSil(satirVerisi.id), child: const Text("sil")),
               trailing:  Text(satirVerisi['zaman'].toString()),
               onLongPress: (() {
                 metinKopyala(satirVerisi.id);
               }),
               ),
              
            ), 
           );  
          },  
          );
                 }
          
         

          ),
       
        ],
      ),
    ),     
    );
  }

}  




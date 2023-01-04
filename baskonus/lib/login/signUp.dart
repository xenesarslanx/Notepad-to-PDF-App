import 'package:baskonus/speechRecords/speech.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);

  @override
  
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {
String firebaseUyari  = "";
bool sifre = true;

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

 Future<void>kayitOl()async{  //kayıt ol
 try{
   await FirebaseAuth.instance
  .createUserWithEmailAndPassword(email: t1.text, password: t2.text); //kullanıcı kayıtı
 }catch(e){
  firebaseUyari = e.toString().substring(30);
 }
 
  /*whenComplete(() => ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
      content: Text("Kayıt oldunuz şimdi giriş yapınız.",
      style: TextStyle(
        backgroundColor: Colors.green,
        color: Colors.red,
        fontSize: 16,        
        ),
        textAlign: TextAlign.center,
        ),
    )),);*/
  //sonra
  /*.then((kullanicilar) {
    FirebaseFirestore.instance
    .collection("Kullanicilar")
    .doc(t1.text)//kullanıcının maili ile belge oluşturdu
    .set({"kullaniciEposta": t1.text, "kullaniciSifre": t2.text})//olusturulan belgeye eposta ve şifreleri yazdı
  .whenComplete(() => girisUyari = ("Kayıt oldunuz şimdi giriş yapınız."));
  });*/
 }

  girisYap(){

  FirebaseAuth.instance
  .signInWithEmailAndPassword(email: t1.text, password: t2.text)
  .then((kullanicilar) {
   Navigator.pushAndRemoveUntil(
  context,
   MaterialPageRoute(
    builder: (_) =>    const SpeechScreen(),
    ),
    ((Route<dynamic> route)=>false));
    }
    );
}

@override
  void initState (){//uygulamaya giriş yaptıysan bir daha login ekranı açılmasın
   
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
       Navigator.pushAndRemoveUntil(
  context,
   MaterialPageRoute(
    builder: (_) =>    const SpeechScreen(),
    ),
    ((Route<dynamic> route)=>false));
      print('User is signed in!');
      
    }
  });
   super.initState();
}

  @override
 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.redAccent,
      title:   const Center(child: Text('Kayıt Ol Ve Giriş Yap')) ,
      ),
      body:SingleChildScrollView(
        child: Container(
          color:Colors.red[100],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      
         child: Column(
          children: [
              const SizedBox(height: 30,),
      
             TextFormField(
              controller: t1,
          decoration: const InputDecoration(
            icon: Icon(Icons.email),
              border:OutlineInputBorder(),
              hintText: 'Email ',
              hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
      
          ),
        ),
        const SizedBox(height: 30,),
      
         TextFormField(
              controller: t2,
              obscureText: sifre,
      
          decoration:  InputDecoration(
            icon:  const Icon(Icons.password_sharp),
              border: const OutlineInputBorder(),
              hintText: 'şifre ',
              hintStyle:  const TextStyle(fontWeight: FontWeight.w300, color: Colors.red),
              suffixIcon: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding:  const EdgeInsets.symmetric(horizontal: 5,vertical:5)
                ),
                onPressed:()=> setState(() {
                  sifre=!sifre;
                }), child:  const Icon(Icons.remove_red_eye_sharp,color: Colors.black,))
                
          ),
        ),
        const SizedBox(height: 20,),
      
           ElevatedButton(onPressed: ()=> setState(() {
             kayitOl();
           }), 
           style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[300],
                  padding:  const EdgeInsets.all(30)
                ), child: const Text("Kayıt Ol"),
           ),
           
        const SizedBox(height: 15,),
      
          ElevatedButton(onPressed: girisYap,
          style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:  const EdgeInsets.all(25)
                ), child:  const Text("Giriş Yap"),
          ),
      
          Text(firebaseUyari),
           
      
          
      
          ]
         ),  
        ),
      ),
      ),
    );

  }
}
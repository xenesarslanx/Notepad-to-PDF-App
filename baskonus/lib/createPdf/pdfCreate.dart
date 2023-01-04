
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:convert';
class pdfpage extends StatefulWidget {
  const pdfpage({super.key});

  @override
  State<pdfpage> createState() => pdfpageState();
}

class pdfpageState extends State<pdfpage> {
  String pdfText = " ";


  void createpdf(String pdfText) async{
  final doc = pw.Document();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build:(pw.Context context){
        var a = utf8.encode(pdfText);
        print("aaaaaaaaaaaaaaaaa:::$a");
        var b = utf8.decode(a) ;
        print("bbbbbbbbbbbbb::$b");

        return pw.Column(
          children: [
            pw.Text(b,
          //pdfText,
          
           style:   const pw.TextStyle(
            
            fontSize: 30,
           ),
           textAlign: pw.TextAlign.left,
           softWrap: true,
           overflow: pw.TextOverflow.clip
           ),

   
          ],     
          
           );
      }
    ),
  );
  await Printing.layoutPdf(
    dynamicLayout: true,
    format: PdfPageFormat.a4,
    usePrinterSettings: true,
    onLayout: (PdfPageFormat format)async =>doc.save());
 }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Colors.white54,
        body: Column(
          children: [
            ElevatedButton(onPressed: (){
              createpdf(pdfText);
            }, child: null),
          
          ],
        ),
      ),
    );
  }
  
}

/*Widget textWidget(){
  return  const Text(
    "s",
    style: TextStyle(
      fontSize: 24,
      //fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.start,
    softWrap: false,
    overflow:TextOverflow.clip
  );
}*/
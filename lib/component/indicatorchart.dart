import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smartvac/services/socket.dart';

Widget chart (Stream stream1){
  return   StreamBuilder(
      stream: stream1,
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return CircularPercentIndicator(
            radius: 190.0,
            lineWidth: 28.0,
            animation: true,
            animationDuration: 1200,
            percent:0,
            progressColor:Color.fromRGBO(53,75, 133, 1),
            //p: Color.fromRGBO(53,75, 133, 1),
            center: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

              ],
            ),
          );
        }
        var s = jsonDecode(snapshot.data);
        print(snapshot.data);
        socket soc = socket.fromJson(s);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 230.0,
              lineWidth: 28.0,
              animation: true,
              animationDuration: 1200,
              percent:per(soc),
              progressColor:Color.fromRGBO(53,75, 133, 1),
              //p: Color.fromRGBO(53,75, 133, 1),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(percent(soc.units).toString() + 'KW',style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 23),),
                      Text('out of',style: GoogleFonts.poppins(fontSize: 12)),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Text(soc.units.totalUnit.toString() + 'KW',style: GoogleFonts.poppins(fontSize: 15)),
                ],
              ),
            ),
          ],
        );
      }
  );
}
String percent(Units u) {
  double i = u.usedUnit;
  return i.toStringAsFixed(4);
}
double per(socket soc) {
  var p = soc.units.usedUnit/soc.units.totalUnit ;
  print(p);
  return p;

}

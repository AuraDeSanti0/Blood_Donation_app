import 'package:flutter/material.dart';
class RestorationTime extends StatelessWidget {

  DateTime lastDonDate;
  String sex;
  RestorationTime(this.lastDonDate, this.sex);

   _calcRestorTime(DateTime lDD, String sex){
     int num;//print(lDD);
     if(lDD.compareTo(DateTime.utc(1900,01,01)) == 0 ) {
       return null;
     }
   else {
       DateTime currentDate = DateTime.now();
       final difference = currentDate
           .difference(lDD)
           .inDays;
       //print(difference);
       if (sex == '女') {
         num = 84 - difference;
         return num;
       }
       if (sex == '男') {
         num = 98 - difference;
         return num;
       }
     }
  }
  String smth(){
    var days = _calcRestorTime(lastDonDate, sex);
    if(days!=null){
      if(days < 0){
        return '还有0天';
      }
      else{
        return '还有$days天';
      }
    }else{
      return '还没献过血 ';
    }

  }

  @override
  Widget build(BuildContext context) {
    var days = _calcRestorTime(lastDonDate, sex);
    return Column(
      children: <Widget>[
        Text('恢复时间'),
        Container(
          height: 50,
          width: days != null ? 100 : 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.yellowAccent, Colors.deepOrange])),
          padding: EdgeInsets.all(8),
          child:Text(
            smth(),
            style: days!=null
           ? TextStyle(
                fontSize: 20,
                color: Colors.black87,
            )
            :TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
          ),
        ),
      ],
    );
  }
}

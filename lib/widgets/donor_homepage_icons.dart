import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
class DonorHomepageIcons extends StatelessWidget {
  String dName, sex,city, donNum;
  int age;
  DonorHomepageIcons(this.dName,this.sex, this.city,this.age, this.donNum);

  @override
  Widget build(BuildContext context) {
    var d = Provider.of<Donations>(context,listen: false).getDInfo();
    return Container(
      width: double.infinity,
      height: 80,
      //color: Colors.lime,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Container(
              child: Text(
                '$age 岁， ',
                style: TextStyle(fontSize: 20),),
            ),
          Container(
            child: Text(
                '$sex ， $city',
                style: TextStyle(fontSize: 20),
            ),
          ),

          /*
          Column(children: <Widget>[
            Icon(
              Icons.add_circle_outline,
              color: Colors.red,
              size: 50,
              //color: Colors.red,
            ),
            Text(
              donNum,
              style: TextStyle(fontSize: 20),)
          ],),
    */
        ],),
    );
  }
}

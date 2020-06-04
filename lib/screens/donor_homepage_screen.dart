import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';
import '../providers/donations.dart';
import '../widgets/donor_homepage_icons.dart';
import '../widgets/donation_item.dart';
import '../widgets/donor_homepage_image.dart';
import '../widgets/main_drawer.dart';
import '../widgets/restoration_time.dart';
class DonorHomepageScreen extends StatefulWidget {
  static const routeName = '/donor-homepage';
  @override
  _DonorHomepageScreenState createState() => _DonorHomepageScreenState();
}

class _DonorHomepageScreenState extends State<DonorHomepageScreen> {

  /*
  int calculateAge(DateTime dob){
    final date2 = DateTime.now();
    final difference = date2.difference(dob).inDays;
    print(difference);
    return difference;
  }
*/
  _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    print(age);
    return age;
  }

  String age;
  var donNumber;
  @override
  Widget build(BuildContext context) {
    var d = Provider.of<Donations>(context,listen: false).getDInfo();
    var l = Provider.of<Donations>(context,listen: false).lastDate();
    var i = Provider.of<Donations>(context,listen: false).items.length;
   // print(l);
    return Scaffold(
      appBar: AppBar(
            iconTheme: IconThemeData(
      //color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
            ),
            title: Text(
            '首页',
            style: TextStyle(
            fontSize: 20,
            //fontWeight: FontWeight.bold,
            color: Colors.black87//Colors.black87//
            ),),
            backgroundColor: Theme.of(context).accentColor,
            ),
      drawer: MainDrawer(d['dName'], d['sfz']),
      body:  Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0,bottom: 0.0),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DonorHomepageImage(Image.asset(
                    d['sex']=='女'
                    ? "assets/images/girl.png"
                    : "assets/images/bb.png"
                )),
                SizedBox(width: 30),
               RestorationTime(l, d['sex']),
              ],
            ),
          ),
          DonorHomepageIcons(d['dName'],d['sex'],d['city'],_calculateAge(DateTime.parse(d['birthday'])),getNumberDonations()),
          Container(
            padding: EdgeInsets.only(top: 10.0, bottom: 12.0),
            child: Text( i==0
               ? "献血记录为空" : " 我的献血历史",
                style: TextStyle(
                  fontSize: 20,
                ),
            ),
          ),
        //  Expanded(child: HomepageListOfDonations()),

          FutureBuilder(
            future: Provider.of<Donations>(context,listen: false).fetchAndSetDonations(),
            builder: (ctx,dataSnapshot){
              if(dataSnapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              } else {
                if(dataSnapshot.error != null){
                  print(dataSnapshot.error);
                  //..do error handling stuff here
                  return Center(child: Text('链接错误，无法下载献血历史'),);
                }else{
                  return Expanded(
                    child: Consumer<Donations>(
                        builder: (ctx, orderData,child){
                          return orderData.items.length ==0
                          ? Container(
                            child: Image.asset("assets/images/512.png", height: 140, width: 100,),
                          )
                          : ListView.builder(
                              itemCount: orderData.items.length,
                              itemBuilder: ((ctx,i){
                                donNumber= orderData.items.length;
                                return  DonationItem(orderData.items[i]);
                              })
                          );

                        }
                    ),
                  );
                }
              }
            },
          )
        ],
        ),
         );
  }

  String getNumberDonations(){
    return donNumber.toString();
  }

}
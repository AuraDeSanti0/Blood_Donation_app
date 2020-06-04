import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
import '../providers/auth.dart';
import '../widgets/hospital_don_item.dart';
import '../widgets/homepage_image.dart';
import '../widgets/add_donation.dart';
import '../widgets/hospital_drawer.dart';
class HospitalHomepageScreen extends StatefulWidget {

  static const routeName = '/hospital-homepage';

  @override
  _HospitalHomepageScreenState createState() => _HospitalHomepageScreenState();
}

class _HospitalHomepageScreenState extends State<HospitalHomepageScreen> {

  void _startAddNewDonation(BuildContext ctx){
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddDonation(),
            behavior: HitTestBehavior.opaque,
          );
        },
      );

  }

  Future<void> _refreshDonations(BuildContext context) async{
    await Provider.of<Donations>(context, listen: false).hospitalFetchAndSetDonations();
  }

  var donNumber;
  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Auth>(context, listen: true).getHInfo();
    var i = Provider.of<Donations>(context,listen: false).items.length;
    //print(h);
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
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewDonation(context),
          ),
      ]),
      drawer: HospitalDrawer(h['hName'], h['license']),
      body:FutureBuilder(
         future: _refreshDonations(context),
        //need to change listen to true to update the homepageIcon
          //future: Provider.of<Donations>(context,listen: false).hospitalFetchAndSetDonations(),
          builder: (ctx,snapshot) => RefreshIndicator(//refreshindicator's on refresh f() has to return future
            //so that refreshindicator knows when you're done fetching data
            onRefresh: () => snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                :  _refreshDonations(context),
            child: Center(
              child: Column(children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(top: 25.0,bottom: 0.0),
                   child: HomepageImage(Image.asset("assets/images/hospital-icon.png")),
                   ),
                  //HomepageIcons(h['hName'],getNumberDonations()),
                  Container(
                   padding: EdgeInsets.only(top: 20.0, bottom: 12.0),
                    child: Text(i!=0
                        ? "献血记录为空"
                        : "我的献血记录",
                       style: TextStyle(
                        fontSize: 20,
                        ),
                     ),
                 ),
              Expanded(
                child: Consumer<Donations>(
                    builder: (ctx, orderData,_){
                      return orderData.items.length ==0
                          ? Container(
                               child: Image.asset("assets/images/512.png", height: 140, width: 100,),
                             )
                          : Padding(
                            padding: EdgeInsets.all(8),
                            child: ListView.builder(
                              itemCount: orderData.items.length,
                              itemBuilder: (_,i){
                                donNumber = orderData.items.length;
                                return Column(
                                  children: <Widget>[
                                    HospitalDonItem(
                                      orderData.items[i].d_id,
                                      orderData.items[i].dName,
                                      orderData.items[i].sfz,
                                      orderData.items[i].date,
                                      orderData.items[i].bloodtype,
                                    ),
                                  ],
                                );
                              }
                          )
                      );
                    }

                ),
              ),

          ]),
            )
      ),




      /*
      Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0,bottom: 0.0),
          child: HomepageImage(),
        ),
        HomepageIcons(getNumberDonations()),
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 12.0),
          child: Text(
            "我的献血历史",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        //  Expanded(child: HomepageListOfDonations()),

*/


    ));
  }
  /*
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
                      builder: (ctx, orderData,child)=> ListView.builder(
                          itemCount: orderData.items.length,
                          itemBuilder: ((ctx,i){
                            donNumber= orderData.items.length;
                            return  HospitalDonItem(orderData.items[i]);
                          })
                      )
                  ),
                );
              }
            }
          },
    */
  String getNumberDonations(){
    return donNumber.toString();
  }

}
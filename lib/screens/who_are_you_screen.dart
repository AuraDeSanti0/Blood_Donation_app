import 'package:flutter/material.dart';
import './hospital_signup_screen.dart';
import './donor_signup_screen.dart';

class WhoAreYouScreen extends StatelessWidget {
  static const routeName = '/who-are-you';

  void HospitalBtnPressed(ctx){
    Navigator.of(ctx).pushNamed(HospitalSignUpScreen.routeName);
  }
  void DonorBtnPressed(ctx){
    Navigator.of(ctx).pushNamed(DonorSignUpScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
      ),
      backgroundColor: Theme.of(context).accentColor,
      title: Text(
          '请选择您的身份',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color:Color.fromRGBO(0, 82, 180, 1.0),
      ),
    ),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: (mediaQuery.size.height
                      - appBar.preferredSize.height   //minus space appbar takes
                      - mediaQuery.padding.top) * 0.08,
                  bottom: (mediaQuery.size.height
                      - appBar.preferredSize.height   //minus space appbar takes
                      - mediaQuery.padding.top) * 0.12,
              ),
              child: Text(
                  '',//请选择您的用户类型
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    color:Color.fromRGBO(0, 82, 180, 1.0),
                  ),
              ),
            ),
            /*
            Container(
              height: (mediaQuery.size.height
                  - appBar.preferredSize.height   //minus space appbar takes
                  - mediaQuery.padding.top) * 0.4,
              width: mediaQuery.size.width * 0.3,
              child: Image.asset(
                'assets/images/cardiogram.png',
              ),
            ),
             SizedBox(
               height: (mediaQuery.size.height
                   - appBar.preferredSize.height   //minus space appbar takes
                   - mediaQuery.padding.top) * 0.05,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(child:
                  IconButton(
                    icon: Icon(
                      Icons.business,
                      size: (mediaQuery.size.height
                          - appBar.preferredSize.height   //minus space appbar takes
                          - mediaQuery.padding.top) * 0.2,
                    ),
                    color: Theme.of(context).primaryColor,
                    tooltip: 'bl bla',
                    onPressed: ()=> HospitalBtnPressed(context),
              ),
            ),
                  SizedBox(
                    width: 100,
                  ),
                  Container(child:
                  IconButton(
                    icon: Icon(
                      Icons.perm_identity,
                      size: (mediaQuery.size.height
                          - appBar.preferredSize.height   //minus space appbar takes
                          - mediaQuery.padding.top) * 0.2,
                    ),
                    color: Theme.of(context).primaryColor,
                    tooltip: 'bl bla',
                    onPressed: ()=> DonorBtnPressed(context),
                  ),
                  ),
              ],
            ), */

            Container(
              padding: EdgeInsets.only(right: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  //padding: EdgeInsets.only(left: 10),
                  height: 44,
                  width: 44,
                  child: Icon(
                      Icons.business,
                      color: Theme.of(context).buttonColor,
                      ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 66,
                  width: 200,
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 46),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: ()=> HospitalBtnPressed(context),
                    child: Text(
                      '医院',
                      style: TextStyle(
                        fontSize: 24,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              padding: EdgeInsets.only(right: 30),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                  height: 44,
                  width: 44,
                  child: Icon(
                      Icons.perm_identity,
                      color: Theme.of(context).buttonColor,
                  ),
                ),

                SizedBox(
                  width: 10,
                ),

                Container(
                  height: 66,
                  width: 200,
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 46),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: ()=> DonorBtnPressed(context),
                    child: Text(
                      '献血者',
                      style: TextStyle(
                        fontSize: 24,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]
              ),
            ),
                ],
        ),
      ),
    );
  }
}

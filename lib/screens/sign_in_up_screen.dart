import 'package:flutter/material.dart';
import './sign_in_screen.dart';
import './about_us_screen.dart';
import './who_are_you_screen.dart';
class SignInUpScreen extends StatelessWidget {
  static const routeName = '/sign-in-up';

  void signInBtnPressed(BuildContext ctx){
      Navigator.of(ctx).pushNamed(SignInScreen.routeName);
  }
  void signUpBtnPressed(ctx){
    Navigator.of(ctx).pushNamed(WhoAreYouScreen.routeName);
  }
  void aboutUsBtnPressed(ctx){
    Navigator.of(ctx).pushNamed(AboutUsScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text('Welcome'),
      centerTitle: true,
    );
    return Scaffold(
      //appBar: appBar,
      body:  Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
          Container(
            height: (mediaQuery.size.height
                - appBar.preferredSize.height   //minus space appbar takes
                - mediaQuery.padding.top) * 0.5,
            width: mediaQuery.size.width * 0.4,
            child: Image.asset('assets/images/loyalty.png'),
          ),

            SizedBox(
              height: (mediaQuery.size.height
                  - appBar.preferredSize.height   //minus space appbar takes
                  - mediaQuery.padding.top) * 0.035,
            ),

            RaisedButton(
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 46),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              onPressed: ()=> signUpBtnPressed(context),
              child: Text(
                '注册',
                style: TextStyle(
                  fontSize: 24,
                 // fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            RaisedButton(
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 46),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              onPressed: ()=> signInBtnPressed(context),
              child: Text(
                '登录',
                style: TextStyle(
                    fontSize: 24,
                    //fontWeight: FontWeight.bold,
                ),
              ),
            ),

          SizedBox(
            height: (mediaQuery.size.height
                - appBar.preferredSize.height   //minus space appbar takes
                - mediaQuery.padding.top) * 0.02,
          ),


          FlatButton(
            //padding: EdgeInsets.only(top: 15),
            splashColor: Colors.white,
            //color: ,
            child: Text(
                '关于我们',
                style: TextStyle(
                  color: Color.fromRGBO(0, 82, 180, 1.0),
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
            ),
            onPressed: ()=> aboutUsBtnPressed(context)
          ),

          SizedBox(
            height: (mediaQuery.size.height
                - appBar.preferredSize.height   //minus space appbar takes
                - mediaQuery.padding.top) * 0.09,
          ),
          ],
          ),
      ),

    );
  }
}

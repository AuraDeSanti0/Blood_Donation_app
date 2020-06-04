import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/donations.dart';
import './providers/news.dart';
import 'screens/sign_in_up_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/about_us_screen.dart';
import 'screens/who_are_you_screen.dart';
import 'screens/hospital_signup_screen.dart';
import 'screens/donor_signup_screen.dart';
import 'screens/donor_homepage_screen.dart';
import 'screens/hospital_homepage_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/hospital_tabs_screen.dart';
import 'screens/account_info_screen.dart';
import 'screens/HAccountInfoScreen.dart';
import 'screens/add_news_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
      ChangeNotifierProvider.value(
        value: Auth(),
      ),
      ChangeNotifierProxyProvider<Auth,Donations>(
        builder: (ctx, auth, previousDonations)=> Donations(
            auth.h,
            auth.d,
            previousDonations ==null ?[]: previousDonations.items
        ),
      ),
      ChangeNotifierProvider.value(
        value: News(),
      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(254, 80, 33, 1),//Colors.grey[200],
          buttonColor: Color.fromRGBO(254, 80, 33, 1),
          accentColor: Color.fromRGBO(241,240,239, 1),
          //fontFamily: 'Newzald',
         // hintColor: Colors.grey,
        ),
        home: SignInUpScreen(),
        routes: {
          // '/': (ctx) => SignInUpScreen(),
          SignInScreen.routeName: (ctx) => SignInScreen(),
          AboutUsScreen.routeName: (ctx) => AboutUsScreen(),
          WhoAreYouScreen.routeName: (ctx) => WhoAreYouScreen(),
          HospitalSignUpScreen.routeName: (ctx) => HospitalSignUpScreen(),
          DonorSignUpScreen.routeName: (ctx) => DonorSignUpScreen(),
          DonorHomepageScreen.routeName: (ctx) => DonorHomepageScreen(),
          HospitalHomepageScreen.routeName: (ctx) => HospitalHomepageScreen(),
          TabsScreen.routeName: (ctx) => TabsScreen(),
          HospitalTabsScreen.routeName: (ctx) => HospitalTabsScreen(),
          AccountInfoScreen.routeName: (ctx) => AccountInfoScreen(),
          HAccountnfoScreen.routeName:(ctx) => HAccountnfoScreen(),
          AddNewsScard.routeName:(ctx) => AddNewsScard(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
            ),
          ],
        ),
      ),

    );
  }
}

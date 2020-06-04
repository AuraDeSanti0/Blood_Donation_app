import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import './hospital_tabs_screen.dart';
import './tabs_screen.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  static bool _donorSignIn = false;
  static bool _hospitalSignIn = false;
  final _signInForm = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  TextEditingController pwd = TextEditingController();
  String msg="";

  void _showErrorDialog(String message){
    showDialog(context:context, builder:(ctx)=> AlertDialog(
      title: Text('An error occured!'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Okay'),
          onPressed: (){
            Navigator.of(ctx).pop();
          },
        )
      ],
    ));
  }
  /*
  Future<List> _login() async {
     if (_hospitalSignIn) {
       final response = await http.post("http://192.168.1.102:8080/blood/login_hospital.php",
           body: {
             "phone": phone.text,
             "pwd": pwd.text
           });
       print(response.body);
       // Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
       // print(map);
       var datauser = json.decode(response.body);
       if(datauser.length == null){
         setState((){
           msg = "Hospital Login failed";
         });
       }
       else{

         setState((){
           username = datauser['name'];
           city = datauser['city'];
         });

         Navigator.pushNamed(
             context,
             HospitalHomepageScreen.routeName,
             arguments: HospitalInfo(username, city)
         );
       }
       return datauser;
     }

     //code with http
     if(_donorSignIn){
      final response = await http.post("http://192.168.1.102:8080/blood/login_donor.php",
          body: {
            "phone": phone.text,
            "pwd": pwd.text
          });
      print(response.body);
     // Map<String, dynamic> map = jsonDecode(response.body) as Map<String, dynamic>;
     // print(map);
      var datauser = json.decode(response.body);
        if(datauser.length == null){
          setState((){
            msg = "Donor Login failed";
          });
        }
        else{

          setState((){
            username = datauser['name'];
            city = datauser['city'];
          });
          Navigator.pushNamed(
              context,
              TabsScreen.routeName,
              arguments: DonorInfo(username, city)
          );
        }
      return datauser;
    }

   }*/


  Future<void> _submit() async {
    if (!_signInForm.currentState.validate()) {
      // Invalid!
      return;
    }
    _signInForm.currentState.save();

    if(_submittable()){
      if(_hospitalSignIn){
        final response =  await Provider.of<Auth>(context,listen: false).hlogin(
          phone.text,
          pwd.text,
        );
        if(response =='1'){
          Navigator.pushNamedAndRemoveUntil(context, HospitalTabsScreen.routeName, (_) => false);
          //Navigator.pushReplacementNamed(context, TabsScreen.routeName);
        }
        if(response =='2'){
          setState((){
            msg = "密码错误";
          });
        }
        if(response =='3'){
          setState((){
            msg = "用户不存在";
          });
        }
        if(response =='4'){
          setState((){
            msg = "登录失败：网络错误";
          });
        }
      }
      else if(_donorSignIn){
         final response =  await Provider.of<Auth>(context,listen: false).dlogin(
            phone.text,
            pwd.text,
          );
         if(response =='1'){
           Navigator.pushNamedAndRemoveUntil(context, TabsScreen.routeName, (_) => false);
           //Navigator.pushReplacementNamed(context, TabsScreen.routeName);
         }
         if(response =='2'){
           setState((){
             msg = "密码错误";
           });
         }
         if(response =='3'){
           setState((){
             msg = "用户不存在";
           });
         }
         if(response =='4'){
            setState((){
              msg = "登录失败：网络错误";
            });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
      ),
      title: Text(
        '登录',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black87//
        ),),
      centerTitle: true,
      backgroundColor: Theme.of(context).accentColor,
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
      child: SingleChildScrollView(
      child: Padding(
      padding: EdgeInsets.only(left: 34, right: 34),
      //child: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                width:
                (mediaQuery.size.height
                   - appBar.preferredSize.height   //minus space appbar takes
                   - mediaQuery.padding.top) * 0.2,
                height:
                (mediaQuery.size.height
                    - appBar.preferredSize.height   //minus space appbar takes
                    - mediaQuery.padding.top) * 0.2,
               child: Image.asset('assets/images/loyalty.png'),
              ),
            ),
            SizedBox(
              height: (mediaQuery.size.height
                  - appBar.preferredSize.height   //minus space appbar takes
                  - mediaQuery.padding.top) * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Color.fromRGBO(0, 82, 180, 1.0),
                        value: _hospitalSignIn,
                        onChanged: _setHospitalSignIn,
                      ),
                      GestureDetector(
                        onTap: () => _setHospitalSignIn(!_hospitalSignIn),
                        child: const Text(
                          '医院',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Color.fromRGBO(0, 82, 180, 1.0),
                        value: _donorSignIn,
                        onChanged: _setDonorSignIn,
                      ),
                      GestureDetector(
                        onTap: () => _setDonorSignIn(!_donorSignIn),
                        child: const Text(
                          '献血者',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: _signInForm,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    //autofocus: false,
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入手机号码.';
                      }
                      return null;
                    },
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    decoration: InputDecoration(
                        labelText: "手机号码",
                        hintText: "手机号码",
                        labelStyle: TextStyle(
                          //color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                //color: Colors.orange,
                                style: BorderStyle.solid))),

                  ),
                  SizedBox(
                    height: (mediaQuery.size.height
                        - appBar.preferredSize.height   //minus space appbar takes
                        - mediaQuery.padding.top) * 0.05,
                  ),
                  TextFormField(
                    //autofocus: false,
                    obscureText: true,
                    controller:pwd,
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return '请输入密码';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "密码",
                        hintText: "密码",
                        labelStyle: TextStyle(
                          //color: Colors.black,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                width: 1,
                                // color: Colors.orange,
                                style: BorderStyle.solid))),
                  ),
                ]
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                  _submittable() ? msg : "请选择一个身份",
                  style: TextStyle(fontSize:18, color: Colors.orange )),
            ),
            SizedBox(
              height: 30,
            ),
            ButtonTheme(
                  minWidth: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: _submit ,
                    child: Text(
                      '登录',
                      style: TextStyle(
                        fontSize: 24,
                        //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    //),
      ),
    ),
    );
  }

  bool _submittable() {
    if((_hospitalSignIn && _donorSignIn)|| (!_hospitalSignIn && !_donorSignIn))
    {

      return false;
    }
    else return true;
  }

  void _setHospitalSignIn(bool newValue) {
    setState(() {
      _hospitalSignIn = newValue;
    });
  }

  void _setDonorSignIn(bool newValue) {
    setState(() {
      _donorSignIn = newValue;
    });

  }

}

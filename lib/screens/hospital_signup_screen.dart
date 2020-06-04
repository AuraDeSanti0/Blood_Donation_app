import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../models/db_url.dart';
class HospitalSignUpScreen extends StatefulWidget {
  static const routeName = '/hospital-signup';
  @override
  _HospitalSignUpScreenState createState() => _HospitalSignUpScreenState();
}

class _HospitalSignUpScreenState extends State<HospitalSignUpScreen> {
  String urlL = url;

  bool _isLoading;
  String signupResult = "";
  final GlobalKey<FormState> _hSignUpForm = GlobalKey<FormState>();
  bool _agreedToTOS = false;
  final _licenseFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordFocusNode2 = FocusNode();

  TextEditingController name = TextEditingController();
  TextEditingController license = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pwd1 = TextEditingController();
  TextEditingController pwd2 = TextEditingController();

  Future<void> dialogText(String msg) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //user must tap the btn
        builder: (ctx) => AlertDialog(
          title: Text('信息'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: (){
                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacementNamed(Navigator.defaultRouteName);
              },
            )
          ],
        )
    );
  }


  _register() async{
    setState(() {
      _isLoading = true;
    });
      Dio dio = new Dio();
      //print(urlL);
      FormData formData = new FormData.fromMap({
        "name": name.text,
        "license": license.text,
        "phone": phone.text,
        "city": city.text,
        "pwd": pwd1.text
      });
      dio
          .post("http://$urlL/blood/register_hospital.php",
          data: formData,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json // or ResponseType.JSON
          ))
          .timeout(Duration(seconds: 15))
          .then((response) {
        //print(response);
        Map<String, dynamic> data = json.decode(response.data);

        if (data['code'] == '1') {
          signupResult ="注册成功！"
              "请登录自己的账户";
        } else if (data['code'] == '2'){
          signupResult ="注册失败！";
        }else if (data['code'] == '3'){
          signupResult ="用户存在！";
        }
        dialogText(signupResult);
      });

     // Navigator.of(context).pushReplacementNamed(Navigator.defaultRouteName);
 }


  void _saveForm(){
    final isValid = _hSignUpForm.currentState.validate(); //to initialize validation
    if(!isValid){
      return ;
    }
    _hSignUpForm.currentState.save();
    if(_submittable()){
      _register();
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
        '医院注册',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black87//
        ),),
      backgroundColor: Theme.of(context).accentColor,
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
              padding: const EdgeInsets.only(left: 34.0,right: 34.0, top: 25.0),
              child: Form(
                key: _hSignUpForm,
                child: ListView(children: <Widget>[
                  TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                         // labelStyle: TextStyle(color: Colors.red),
                          labelText: '医院名称'),
                      textInputAction:  TextInputAction.next, //use focusNode to move to next input form
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_licenseFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                      },
                      validator:(value){
                        if(value.isEmpty){
                          return '请输入医院的名称.';
                        }
                        return null;
                      },
                      onSaved: (value){}
                  ),
                  TextFormField(
                    controller: license,
                    decoration: InputDecoration(labelText: '登记号'),
                    textInputAction:  TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _licenseFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_phoneFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                    },
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入登记号';
                      }
                      return null;
                    },
                    onSaved: (value){},
                  ),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(labelText: '医院代表的手机号'),
                    textInputAction:  TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    focusNode: _phoneFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_cityFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                    },
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入医院代表的手机号.';
                      }
                      return null;
                    },
                    onSaved: (value){},
                  ),
                  TextFormField(
                    controller: city,
                    decoration: InputDecoration(labelText: '城市'),
                    textInputAction:  TextInputAction.next,
                    focusNode: _cityFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_passwordFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                    },
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入城市.';
                      }
                      return null;
                    },
                    onSaved: (value){},
                  ),
                  TextFormField(
                    controller: pwd1,
                    decoration: InputDecoration(labelText: '密码:不能小于6位'),
                    textInputAction:  TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_passwordFocusNode2); //when sumbitted will focus on priceFocusNode, which is next here
                    },
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入密码.';
                      }
                      if(value.length < 6){
                        return '密码不能小于6位';
                      }
                      return null;
                    },
                    onSaved: (value){},
                  ),
                  TextFormField(
                    controller: pwd2,
                    decoration: InputDecoration(labelText: '确认密码'),
                    textInputAction:  TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode2,
                    onFieldSubmitted: (_){},
                    validator:(value){
                      if(value.trim().isEmpty){
                        return '请确认密码';
                      }
                      if(value != pwd1.text){
                        return '密码不配';
                      }
                      return null;
                    },
                    onSaved: (value){},
                  ),
        Row(
            children: <Widget>[
              Checkbox(
                activeColor: Color.fromRGBO(0, 82, 180, 1.0),
                value: _agreedToTOS,
                onChanged: _setAgreedToTOS,
              ),
              GestureDetector(
                onTap: () => _setAgreedToTOS(!_agreedToTOS),
                child: const Text(
                  '我接受协议',
                ),
              ),
            ],
          ),
                  Container(
                    padding: EdgeInsets.only(top:40),
                    child: RaisedButton(
                      //splashColor: Colors.yellow,
                      color: Theme.of(context).buttonColor,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: _saveForm,
                      child: Text(
                        '注册',
                        style: TextStyle(
                          fontSize: 24,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                ),
              ),
          ),
    );
  }

  bool _submittable() {
    return _agreedToTOS;
  }

  void _setAgreedToTOS(bool newValue) {
    setState(() {
      _agreedToTOS = newValue;
    });
  }

  }

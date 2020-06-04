import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/db_url.dart';
class DonorSignUpScreen extends StatefulWidget {
  static const routeName = '/donor-signup';

  @override
  _DonorSignUpScreenState createState() => _DonorSignUpScreenState();
}

class _DonorSignUpScreenState extends State<DonorSignUpScreen> {
  String urlL = url;
  int _radioValue;
  String _userSex ='';
  bool _isLoading;
  String signupResult = "";
  final GlobalKey<FormState> _dSignUpForm = GlobalKey<FormState>();
  final _bloodTypeFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _sfzFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordFocusNode2 = FocusNode();
  bool _agreedToTOS = false;

  TextEditingController name = TextEditingController();
  TextEditingController sfz = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController bloodtype = TextEditingController();
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

    if(pwd1.text==pwd2.text){
      Dio dio = new Dio();
      FormData formData = new FormData.fromMap({
        "name": name.text,
        "sfz": sfz.text,
        "birthday": (DateFormat('yyyy-MM-dd').format(selectedDate)),
        'sex':_userSex,
        "phone": phone.text,
        "bloodtype": bloodtype.text,
        "city": city.text,
        "pwd": pwd1.text
      });
      dio
          .post("http://$urlL/blood/register_donor.php",
          data: formData,
          options: Options(
              method: 'POST',
              responseType: ResponseType.json // or ResponseType.JSON
          ))
          .timeout(Duration(seconds: 15))
          .then((response) {
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
    }
  }

  void _saveForm(){
    final isValid = _dSignUpForm.currentState.validate(); //to initialize validation
    if(!isValid){
      return ;
    }
    _dSignUpForm.currentState.save();
    if(_submittable()){
     _register();
    }
  }

  DateTime selectedDate = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950,1),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          _userSex = '女';
          break;
        case 1:
          _userSex = '男';
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      iconTheme: IconThemeData(
        color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
      ),
      title: Text(
        '献血者注册',
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
      body: Padding(
        padding: const EdgeInsets.only(left: 34.0,right: 34.0, top: 10.0),
        child: Form(
          key: _dSignUpForm,
          child: ListView(children: <Widget>[
           TextFormField(
             controller: name,
            decoration: InputDecoration(labelText: '名字'),
            textInputAction:  TextInputAction.next, //use focusNode to move to next input form
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(_sfzFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
            },
            validator:(value){
              if(value.isEmpty){
                return '请输入您的名字.';
              }
              return null;
              },
            onSaved: (value){}
            ),
           TextFormField(
               controller: sfz,
               decoration: InputDecoration(labelText: '身份证'),
               textInputAction:  TextInputAction.next,
               keyboardType: TextInputType.number,
               focusNode: _sfzFocusNode,//use focusNode to move to next input form
               onFieldSubmitted: (_){
                 FocusScope.of(context).requestFocus(_phoneFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
               },
               validator:(value){
                 if(value.isEmpty){
                   return '请输入您的身份证号码.';
                 }
                 if(value.length !=18){
                   return '请输入由18位数字组成的身份证';
                 }
                 return null;
               },
               onSaved: (value){}
           ),
           TextFormField(
             controller: phone,
             decoration: InputDecoration(labelText: '手机号码'),
             textInputAction:  TextInputAction.next,
             keyboardType: TextInputType.phone,
             focusNode: _phoneFocusNode,
             onFieldSubmitted: (_){
               FocusScope.of(context).requestFocus(_bloodTypeFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
             },
             validator:(value){
               if(value.isEmpty){
                 return '请输入手机号码.';
               }
               return null;
             },
             onSaved: (value){},
           ),
           TextFormField(
             controller: bloodtype,
             decoration: InputDecoration(labelText: '血型, 例如: A+, B-, AB+'),
             textInputAction:  TextInputAction.next,
             focusNode: _bloodTypeFocusNode,
             onFieldSubmitted: (_){
               FocusScope.of(context).requestFocus(_cityFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
             },
             validator:(value){
               if(value.isEmpty){
                 return '请输入您的血型.';
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
           Padding(
             padding: const EdgeInsets.only(top: 5.0,),
             child: Column(
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                       Text(
                         selectedDate ==null
                             ? '输入生日'
                             : '生日： ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                         style: selectedDate == null ? TextStyle(color:Colors.red) : TextStyle(color:Colors.black),
                       ),
                   //SizedBox(width: 50.0,),
                   RaisedButton(
                     color: Theme.of(context).buttonColor,
                     onPressed: () => _selectDate(context),
                     child: Text('选择日期', style: TextStyle(fontWeight: FontWeight.bold),),
                   )
                  ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                      Radio(
                       value: 0,
                       activeColor: Theme.of(context).primaryColor,
                       groupValue: _radioValue,
                       onChanged: _handleRadioValueChange,
                     ),
                      Text('女'),
                      SizedBox(width: 30),
                      Radio(
                       value: 1,
                       activeColor: Theme.of(context).primaryColor,
                       groupValue: _radioValue,
                       onChanged: _handleRadioValueChange,
                     ),
                      Text('男'),
                 ],)
               ],
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 0),
             child: TextFormField(
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
           ),
           TextFormField(
             controller: pwd2,
             decoration: InputDecoration(labelText: '确认密码'),
             textInputAction:  TextInputAction.done,
             keyboardType: TextInputType.visiblePassword,
             focusNode: _passwordFocusNode2,
             onFieldSubmitted: (_){},
             validator:(value){
               if(value.isEmpty){
                 return '情输入密码.';
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
             height: 64,

            // padding: EdgeInsets.only(top:40),
             child: RaisedButton(
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

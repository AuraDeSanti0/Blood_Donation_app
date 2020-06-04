
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
import 'package:intl/intl.dart';
import '../providers/auth.dart';

class HospitalInfo{
  final String id;
  final String name;
  final String license;
  final String phone;
  final String city;
  final String pwd;

  const HospitalInfo({
    @required this.id,
    @required this.name,
    @required this.license,
    @required this.phone,
    @required this.city,
    @required this.pwd,

  });
}class HAccountnfoScreen extends StatefulWidget {
  static const routeName = '/h-account-info';
  @override
  _HAccountnfoScreenState createState() => _HAccountnfoScreenState();
}

class _HAccountnfoScreenState extends State<HAccountnfoScreen> {
  final GlobalKey<FormState> _hAccountInfoForm = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _licenseFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Donations>(context,listen: false).getHInfo();
    String msg='';
    var _editedInfo = HospitalInfo(
      id: '',
      name:'',
      license: '',
      phone: '',
      city: '',
      pwd: '',
    );

    Future<void> dialogText(String msg) async{
      return showDialog<void>(
          context: context,
          barrierDismissible: false, //user must tap the btn
          builder: (ctx) => AlertDialog(
            title: Text('信息'),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: (){
                  Navigator.of(ctx).pop();
                },
              )
            ],
          )
      );
    }

    Future<void> _saveForm() async {
      final isValid = _hAccountInfoForm.currentState.validate(); //to initialize validation
      if(!isValid){ return ; }

      _hAccountInfoForm.currentState.save();
      print(_editedInfo.id);
      if(_editedInfo.id != null) {
      var result =  await  Provider.of<Auth>(context, listen: false)
            .updateHospitalInfo(
          _editedInfo.id,
          _editedInfo.name,
         // _editedInfo.license,
          _editedInfo.phone,
          _editedInfo.city,
          _editedInfo.pwd,
        );
        if (result == '1') {
          msg ="修改成功";
        } else if (result == '2'){
          msg ="修改失败";
        }
        Navigator.of(context).pop();
        dialogText(msg);
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
        ),
        title: Text('修改医院的信息', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 82, 180, 1.0),
        ),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:
              Form(
                key: _hAccountInfoForm,
                child: ListView(children: <Widget>[
                  TextFormField(
                    //controller: name,
                      initialValue: h['hName'],
                      decoration: InputDecoration(labelText: '名字'),
                      textInputAction:  TextInputAction.next, //use focusNode to move to next input form
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_licenseFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                      },
                      validator:(value){
                        if(value.isEmpty){
                          return '请输入您的名字.';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _editedInfo = HospitalInfo(
                          id: h['id'],
                          name: value,
                          license: _editedInfo.license,
                          phone: _editedInfo.phone,
                          city: _editedInfo.city,
                          pwd: _editedInfo.pwd,
                        );
                      }
                  ),
                  /*
                  TextFormField(
                      initialValue: h['license'],
                      decoration: InputDecoration(labelText: '登记号'),
                      textInputAction:  TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _licenseFocusNode,//use focusNode to move to next input form
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_phoneFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                      },
                      validator:(value){
                        if(value.isEmpty){
                          return '请输入您的登记号';
                        }
                        if(value.length !=10){
                          return '登记号的长度不能小于10';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _editedInfo = HospitalInfo(
                          id: h['id'],
                          name: _editedInfo.name,
                          license: value,
                          phone: _editedInfo.phone,
                          city: _editedInfo.city,
                          pwd: _editedInfo.pwd,
                        );
                      }
                  ),
                 */
                  TextFormField(
                      initialValue: h['phone'],
                      decoration: InputDecoration(labelText: '手机号码'),
                      textInputAction:  TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      focusNode: _phoneFocusNode,
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_cityFocusNode); //when sumbitted will focus on priceFocusNode, which is next here
                      },
                      validator:(value){
                        if(value.isEmpty){
                          return '请输入手机号码.';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _editedInfo = HospitalInfo(
                          id: h['id'],
                          name: _editedInfo.name,
                          license: _editedInfo.license,
                          phone: value,
                          city: _editedInfo.city,
                          pwd: _editedInfo.pwd,
                        );
                      }
                  ),
                  TextFormField(
                      initialValue: h['city'],
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
                      onSaved: (value){
                        _editedInfo = HospitalInfo(
                          id: h['id'],
                          name: _editedInfo.name,
                          license: _editedInfo.license,
                          phone: _editedInfo.phone,
                          city: value,
                          pwd: _editedInfo.pwd,
                        );
                      }
                  ),
                  TextFormField(
                    initialValue: h['pwd'],
                    decoration: InputDecoration(labelText: '密码'),
                    textInputAction:  TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入密码.';
                      }
                      if(value.length <6){
                        return '输入的新密码不能小6位';
                      }
                      return null;
                    },
                      onSaved: (value){
                        _editedInfo = HospitalInfo(
                          id: h['id'],
                          name: _editedInfo.name,
                          license: _editedInfo.license,
                          phone: _editedInfo.phone,
                          city: _editedInfo.city,
                          pwd: value,
                        );
                      }
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

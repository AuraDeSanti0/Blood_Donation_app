import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
import 'package:intl/intl.dart';
import '../providers/auth.dart';

class DonorInfo{
  final String id;
  final String name;
  final String sfz;
  final String birthday;
  final String sex;
  final String phone;
  final String bloodtype;
  final String city;
  final String pwd;

  const DonorInfo({
    @required this.id,
    @required this.name,
    @required this.sfz,
    @required this.birthday,
    @required this.sex,
    @required this.phone,
    @required this.bloodtype,
    @required this.city,
    @required this.pwd,

  });
}
class AccountInfoScreen extends StatefulWidget {
  static const routeName = '/account-info';
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool newDateSelected = false;
  final GlobalKey<FormState> _accountInfoForm = GlobalKey<FormState>();
  final _bloodTypeFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _sfzFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  TextEditingController pwd = TextEditingController();
  static  var _editedInfo = DonorInfo(
    id: '',
    name:'',
    sfz: '',
    birthday: '',
    sex: '',
    phone: '',
    bloodtype: '',
    city: '',
    pwd: '',
  );

  DateTime selectedDate;
  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950,1),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate ==null){
        return;
      }
      setState((){
        selectedDate = pickedDate;
        newDateSelected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var d = Provider.of<Donations>(context,listen: false).getDInfo();
    String msg='';
    _editedInfo = DonorInfo(
      id: d['d_id'],
      name: d['dName'],
      sfz: d['sfz'],
      birthday: d['birthday'],
      sex: d['sex'],
      phone: d['phone'],
      bloodtype: d['bloodtype'],
      city: d['city'],
      pwd: d['pwd'],
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
      final isValid = _accountInfoForm.currentState.validate(); //to initialize validation
      if(!isValid){ return ; }

      _accountInfoForm.currentState.save();
      print(_editedInfo.id);
      if(_editedInfo.id != null) {
          var result =  await  Provider.of<Auth>(context, listen: false)
             .updateUserInfo(
                  _editedInfo.id,
                  _editedInfo.name,
                  _editedInfo.sfz,
                  _editedInfo.birthday,
                  _editedInfo.sex,
                  _editedInfo.phone,
                  _editedInfo.bloodtype,
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child:
              Form(
              key: _accountInfoForm,
              child: ListView(children: <Widget>[
                TextFormField(
                    //controller: name,
                    initialValue: d['dName'],
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
                    onSaved: (value){
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: value,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: _editedInfo.phone,
                        bloodtype: _editedInfo.bloodtype,
                        city: _editedInfo.city,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),
                /*
                TextFormField(
                    initialValue: d['sfz'],
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
                    onSaved: (value){
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: value,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: _editedInfo.phone,
                        bloodtype: _editedInfo.bloodtype,
                        city: _editedInfo.city,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),
                 */
                TextFormField(
                  initialValue: d['phone'],
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
                    onSaved: (value){

                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: value,
                        bloodtype: _editedInfo.bloodtype,
                        city: _editedInfo.city,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),
                TextFormField(
                  initialValue: d['bloodtype'],
                  decoration: InputDecoration(labelText: '血型'),
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
                    onSaved: (value){
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: _editedInfo.phone,
                        bloodtype: value,
                        city: _editedInfo.city,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),
                TextFormField(
                  initialValue: d['city'],
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
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: _editedInfo.phone,
                        bloodtype: _editedInfo.bloodtype,
                        city: value,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),
                TextFormField(
                  initialValue: d['sex'],
                  decoration: InputDecoration(labelText: '性别'),
                  textInputAction:  TextInputAction.next,
                  validator:(value){
                    if(value.isEmpty){
                      return '请输入性别';
                    }
                    return null;
                  },
                    onSaved: (value){
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: value,
                        phone: _editedInfo.phone,
                        bloodtype: _editedInfo.bloodtype,
                        city: _editedInfo.city,
                        pwd: _editedInfo.pwd,
                      );
                    }
                ),

                Container(
                  height:70,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          fit: FlexFit.tight,
                          child: setDate()
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('选择日期', style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed:(){
                          _presentDatePicker();
                        }
                      )
                    ],
                  ),
                ),

                TextFormField(
                    initialValue: d['pwd'],
                    decoration: InputDecoration(labelText: '密码'),
                    textInputAction:  TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    validator:(value){
                      if(value.isEmpty){
                        return '请输入密码.';
                      }
                      if(value.length < 6){
                        return '输入的新密码不能小6位';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _editedInfo = DonorInfo(
                        id: d['id'],
                        name: _editedInfo.name,
                        sfz: _editedInfo.sfz,
                        birthday: _editedInfo.birthday,
                        sex: _editedInfo.sex,
                        phone: _editedInfo.phone,
                        bloodtype: _editedInfo.bloodtype,
                        city: _editedInfo.city,
                        pwd: value,
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setDate(){
    if(newDateSelected == false){
      String date = _editedInfo.birthday;
      return Text( '日期： $date');
    }
    else{
      _editedInfo = DonorInfo(
        id: _editedInfo.id,
        name: _editedInfo.name,
        sfz: _editedInfo.sfz,
        birthday: DateFormat('yyyy-MM-dd').format(selectedDate),
        sex: _editedInfo.sex,
        phone: _editedInfo.phone,
        bloodtype: _editedInfo.bloodtype,
        city: _editedInfo.city,
        pwd: _editedInfo.pwd,
      );
      return Text( '日期： ${DateFormat('yyyy-MM-dd').format(selectedDate)}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
class AddDonation extends StatefulWidget {

  @override
  _AddDonationState createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  String _dateNotChosen = " ";
  final _addForm = GlobalKey<FormState>();
  final _sfzController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate ==null){
        return;
      }
      setState((){
        _selectedDate = pickedDate;
      });
    });
  }

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
              },
            )
          ],
        )
    );
  }
  Future<void> _submitData() async {
    String result;
    final isValid = _addForm.currentState.validate();
    if(!isValid){
      return;
    }
    _addForm.currentState.save();
    final enteredSfz = _sfzController.text;
    String msg = "";
    if(_selectedDate!=null){
      String date = DateFormat('yyyy-MM-dd').format(_selectedDate);
      result =  await Provider.of<Donations>(context,listen: false).addDonation(enteredSfz,date);
      if (result == '1') {
        msg ="加入成功";
      } else if (result == '2'){
        msg ="加入失败";
      } else {
        msg ="用户不存在";
      }
      Navigator.of(context).pop();
      dialogText(msg);
      //print(msg);
    }
  }

  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
      child: Card(
          elevation:5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Form(
                    key: _addForm,
                  child:  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '身份证'),
                    controller: _sfzController,
                    validator: (value){
                      if(value.isEmpty){
                        return '请输入身份证';
                      }
                      if(value.length !=18){
                        return '请输入由18位数字组成的身份证';
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  height:70,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                            _selectedDate ==null
                                ? '没选择日期'
                                : '日期： ${DateFormat.yMd().format(_selectedDate)}',
                          style: _selectedDate ==null ? TextStyle(color:Colors.red) : TextStyle(color:Colors.black),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('选择日期', style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: _presentDatePicker,
                      )
                    ],
                  ),
                ),
                Text(_dateNotChosen, style: TextStyle(color: Colors.red,),),
                RaisedButton(
                  child: Text('提交'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData,
                )
              ],
            ),
          )
      ),
    );
      /*SingleChildScrollView(
      child: Card(
          elevation:5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            /*
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
               Form(
                    key: _addForm,
                    child:
                      TextFormField(
                        decoration: InputDecoration(labelText: 'sfz'),
                        validator: (value){
                          if(value.isEmpty){
                            return 'Please enter sfz';
                          }
                          return null;
                        },
                        //onSaved: (){},
                      ),
                ),
               Container(
                 height:70,
                 child: Row(
                   children: <Widget>[
                     Flexible(
                       fit: FlexFit.tight,
                       child: Text(
                           _selectedDate ==null
                               ? 'No Date chosen'
                               : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                     ),
                     FlatButton(
                       textColor: Theme.of(context).primaryColor,
                       child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
                       onPressed: _presentDatePicker,
                     )
                   ],
                 ),
               ),
                RaisedButton(
                  child: Text('Submit'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitData,
                )
              ],
            ),*/
          )
      ),
    ); */
  }
}
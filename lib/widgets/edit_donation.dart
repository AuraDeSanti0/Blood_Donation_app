import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
class EditDonation extends StatefulWidget {
  final String d_id;
  EditDonation(this.d_id);

  @override
  _EditDonationState createState() {
    return _EditDonationState();}
}

class _EditDonationState extends State<EditDonation> {

  bool newDateSelected = false;
  String _dateNotChosen = " ";
  final _editForm = GlobalKey<FormState>();
  DateTime _selectedDate;
  static  var _editedDonation = Donation(
      d_id:null,
      hName:'',
      license: '',
      dName: '',
      sfz: '',
      bloodtype: '',
      date: '',
  );
  var _initValues ={
    'sfz': '',
  };
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
        newDateSelected = true;
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
              child: Text('OK', style: TextStyle(color:Colors.black)),
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
    final isValid = _editForm.currentState.validate();
    if(!isValid){
      return;
    }
    _editForm.currentState.save();
    final enteredSfz = _editedDonation.sfz;
    final enteredDate = _editedDonation.date;
    String msg = "";
    if(_selectedDate!=null){
      result =  await Provider.of<Donations>(context,listen: false).updateDonation(widget.d_id, enteredSfz, enteredDate);
      if (result == '1') {
        msg ="修改成功";
      } else if (result == '2'){
        msg ="修改失败";
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
    final donId = widget.d_id;
    _editedDonation = Provider.of<Donations>(context,listen:false).findById(donId);
    _initValues = {
      'sfz': _editedDonation.sfz,
    };

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
                  key: _editForm,
                  child:  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '身份证'),
                    initialValue: _initValues['sfz'],
                    validator: (value){
                      if(value.isEmpty){
                        return '请输入身份证';
                      }
                     if(value.length !=18){
                        return '请输入由18位数字组成的身份证';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _editedDonation = Donation( //cause values in Product are immutable i.e. final, have to create new Product each time
                        //and add value inputed to the formField
                        d_id: _editedDonation.d_id,
                        hName: _editedDonation.hName,
                        license: _editedDonation.license,
                        dName: _editedDonation.dName,
                        sfz: value,
                        bloodtype: _editedDonation.bloodtype,
                        date: _editedDonation.date,
                      );
                    },
                  ),
                ),

                Container(
                  height:70,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: setDate()
                        /*
                        Text(

                          _selectedDate ==null
                              ? '没选择日期'
                              : '日期： ${DateFormat.yMd().format(_selectedDate)}',
                          style: _selectedDate ==null ? TextStyle(color:Colors.red) : TextStyle(color:Colors.black),
                        ),
                        */
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
  }
  Widget setDate(){
    if(newDateSelected == false){
      String date = _editedDonation.date;
      return Text( '日期： $date');
    }
    else{
      _editedDonation = Donation(
        d_id: _editedDonation.d_id,
        hName: _editedDonation.hName,
        license: _editedDonation.license,
        dName: _editedDonation.dName,
        sfz: _editedDonation.sfz,
        bloodtype: _editedDonation.bloodtype,
        date:DateFormat('yyyy-MM-dd').format(_selectedDate),
      );
      return Text( '日期： ${DateFormat('yyyy-MM-dd').format(_selectedDate)}');
    }
  }
}
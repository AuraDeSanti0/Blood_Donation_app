import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';

class DeleteDonation extends StatefulWidget {
  final String d_id;
  DeleteDonation(this.d_id);

  @override
  _DeleteDonationState createState() => _DeleteDonationState();
}

class _DeleteDonationState extends State<DeleteDonation> {
  bool deleteDon = false;
  String msg="";
  Future<void> dialogText(String msg) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //user must tap the btn
        builder: (ctx) => AlertDialog(
          title: Text('信息',
            style: TextStyle(
                //fontSize: 20,
                //fontWeight: FontWeight.bold,
                color: Colors.black87//Colors.black87//
            ),),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('OK',
                style: TextStyle(
                  //fontSize: 20,
                  //fontWeight: FontWeight.bold,
                    color: Colors.black87//Colors.black87//
                ),),
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
    result =  await Provider.of<Donations>(context,listen: false).deleteDonation(widget.d_id);
    if (result == '1') {
      msg ="修改成功";
    } else {
      msg ="用户不存在";
    }
    Navigator.of(context).pop();
    dialogText(msg);
    //print(msg);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AlertDialog(
        title: Text('信息'),
        content: Text('您确定想删除吗？'),
        actions: <Widget>[
          FlatButton(
             child: Text(
               '取消',
               style: TextStyle(
                color: Colors.black87//Colors.black87//
    ),),
             onPressed: (){
             Navigator.of(context).pop();
               },
           ),
          FlatButton(
             child: Text(
               '确定',
               style: TextStyle(
                 color: Colors.black87//Colors.black87//
             ),),
             onPressed: (){
               deleteDon = true;
               _submitData();
               Navigator.of(context).pop();
             },
          )
    ],
    ),
    ]);
  }
}









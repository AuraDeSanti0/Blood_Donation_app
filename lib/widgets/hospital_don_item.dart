import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart'as don;
import '../providers/donations.dart';
import './edit_donation.dart';
import './delete_donation.dart';
class HospitalDonItem extends StatefulWidget {
  final String d_id, dName, sfz, date, bloodtype;
  HospitalDonItem(this.d_id, this.dName, this.sfz, this.date, this.bloodtype);
 // final don.Donation order;
  //HospitalDonItem(this.order);

  @override
  _HospitalDonItemState createState() => _HospitalDonItemState();
}
enum WhyFarther {edit, delete}

class _HospitalDonItemState extends State<HospitalDonItem> {
  String msg ="";
  void _startEditDonation(BuildContext ctx, String d_id) {
    showModalBottomSheet(
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: EditDonation(d_id),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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
              child: Text('OK', style: TextStyle(color: Colors.black)),
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
      msg ="删除成功";
    } else {
      msg ="删除失败";
    }
    Navigator.of(context).pop();
    dialogText(msg);
    //print(msg);
  }

  void _deleteDialog(String d_id){
    showDialog(
      context: context,
        builder: (ctx) => AlertDialog(
          title: Text('信息'),
          content: Text('您确定想删这些献血信息吗?'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消', style: TextStyle(color: Colors.black)),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('确定', style: TextStyle(color: Colors.black)),
              onPressed: (){
                _submitData();
              },
            )
          ],
        )
     );
    }

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Card(
        margin: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
        elevation: 5,
        child:ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 4.0,top: 4.0),
            child: CircleAvatar(
             // backgroundColor: Colors.deepOrange,
              //radius: 30,
              child:Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.purple, Colors.red])),
                  padding: EdgeInsets.all(4),
                  child:FittedBox(child:Text(
                    widget.bloodtype,
                    style: TextStyle(fontSize: 22,color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          title:Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              widget.dName,
              style: Theme.of(context).textTheme.title,),
          ),
          //Text(bloodDonations[index].bloodType),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
                widget.date
              //DateFormat.yMMMd().format(order.date),
            ),
          ),
          trailing:PopupMenuButton<WhyFarther>(
            onSelected: (WhyFarther result) { setState(() {
              //_selection = result;
            }); },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
               PopupMenuItem<WhyFarther>(
                value: WhyFarther.edit,
                child: IconButton(
                  icon:Icon(Icons.edit),
                  onPressed: () => _startEditDonation(context, widget.d_id),
                  color: Colors.amber,
                ),
              ),
               PopupMenuItem<WhyFarther>(
                value: WhyFarther.delete,
                child: IconButton(
                  icon:Icon(Icons.delete),
                  onPressed: () {
                   _deleteDialog(widget.d_id);
                  },
                  color: Theme.of(context).errorColor,
                ),
              ),
            ],
          )

        )
    );
  }
}

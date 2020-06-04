import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' ;

class UserSearchItem extends StatelessWidget {

  String bt, id, name, phone, date;
  UserSearchItem(this.bt, this.id, this.name, this.phone, this.date);

   _sendSms(String number) async {
      const url = 'https://flutter.dev';
      if (await canLaunch("tel://$number")) {
        await launch("sms:$number");
      } else {
        throw 'Could not launch $url';
      }
    }


  _call(String number) async {
    const url = 'https://flutter.dev';
    if (await canLaunch("tel://$number")) {
      await launch("tel://$number");
    } else {
      throw 'Could not launch $url';
    }
  }


    @override
    Widget build(BuildContext context) {
      return Card(
          margin: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
          elevation: 5,
          child:ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 1.0, bottom: 4.0,top: 4.0),
              child: CircleAvatar(
                // backgroundColor: Colors.deepOrange,
                radius: 30,
                child:
                FittedBox(
                  child: Text(bt, style: TextStyle(fontSize: 22),)
                ),
              ),
            ),
            title:Padding(
              padding: const EdgeInsets.only(left: 6.0, bottom: 8.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.title,),
            ),
            //Text(bloodDonations[index].bloodType),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                  date != null
                      ? date
                      : "还没献过血"
                //DateFormat.yMMMd().format(order.date),
              ),
            ),
            trailing:
            Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon:Icon(Icons.phone),
                    onPressed: (){_call(phone);},
                    color: Theme.of(context).primaryColor,
                  ),
                  IconButton(
                    icon:Icon(Icons.message),
                    onPressed: () => _sendSms(phone),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          )
      );
    }
  }


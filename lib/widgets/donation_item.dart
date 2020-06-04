import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart' as don;

class DonationItem extends StatelessWidget {
  final don.Donation order;
  DonationItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
        elevation: 5,
        child:ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 4.0,top: 10.0),
            child: CircleAvatar(
             // backgroundColor: Color.fromRGBO(0, 83, 181, 1),
             // radius: 30,
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
                   order.bloodtype,
                  style: TextStyle(fontSize: 22,color: Colors.white),
                ),
                ),
              ),
            ),
          ),
          title:Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
             order.hName,
              style: Theme.of(context).textTheme.title,),
          ),
          //Text(bloodDonations[index].bloodType),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
                order.date
                //DateFormat.yMMMd().format(order.date),
            ),
          ),
        )
    );
  }
}

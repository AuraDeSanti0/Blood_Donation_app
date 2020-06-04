import 'package:flutter/material.dart';

class HomepageIcons extends StatelessWidget {
  String name, dNum;
  HomepageIcons(this.name, this.dNum);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      //color: Colors.lime,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: <Widget>[
            Icon(
              Icons.favorite_border,
              color: Colors.red,
              size: 50,
            ),
            Text(
              name,
              style: TextStyle(fontSize: 20),)
          ],),
          SizedBox(
            width: 120,
          ),
          Column(children: <Widget>[
            Icon(
              Icons.add_circle_outline,
              color: Colors.red,
              size: 50,
              //color: Colors.red,
            ),
            Text(
              dNum,
              style: TextStyle(fontSize: 20),)
          ],),
        ],),
    );
  }
}

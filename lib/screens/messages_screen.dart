import 'package:flutter/material.dart';
import '../models/userInfo.dart';
import '../widgets/user_search.dart';
/*
class MessagesScreen extends StatefulWidget {

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {

  var dummy = const [
    UserInfo(
      id: 'test',
      name: 'Donor 1',
      phone: '1234567889',
      bloodtype: 'B-',
      imageUrl: 'http://tcf.admeen.org/category/500/291/400x400.jpg',
      date: '2019-11-1',
    ),
    UserInfo(
      id: 'test2',
      name: 'Donor 2',
      phone: '1359876541',
      bloodtype: 'B+',
      imageUrl: 'https://vignette.wikia.nocookie.net/parody/images/1/10/Garu.png/revision/latest/scale-to-width-down/180?cb=20181210144950',
      date: '2019-10-1',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(children: <Widget>[
        Text("Search results:"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                      itemCount: dummy.length,
                        itemBuilder: (context, index){
                         return  Column(
                           children: <Widget>[
                             UserSearchItem (
                                dummy[index].id,
                                dummy[index].name,
                                dummy[index].phone,
                                dummy[index].bloodtype,
                                dummy[index].imageUrl,
                                dummy[index].date,
                              ),
                           ],
                         );
                        },
                    //  separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
            ),
                ),



      ],),
    );
  }


}
*/
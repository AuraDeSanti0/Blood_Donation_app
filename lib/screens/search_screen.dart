import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userInfo.dart';
import '../widgets/user_search.dart';
import '../providers/donations.dart';
import '../models/db_url.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static List<UserInfo> users = [];
  static String city= "";
  static String urlL = url;
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text

 static void getNames(String city, String bt) async {
    final response = await http.post("http://$urlL/blood/search1.php",
        body: {
          "city": city,
          "bloodtype": bt,
        });
    //print(city);
    //print(bt);
    final extractedData = json.decode(response.body) ;
    print(extractedData);
    final List<UserInfo> loadedUsers = [];
    extractedData.forEach((userData) {
      loadedUsers.add(UserInfo(
          id: userData['id'],
          name: userData['name'],
          phone: userData['phone'],
          bloodtype: userData['bloodtype'],
          lastdate: userData['lastdate'],
      ));
    });
    print(loadedUsers.length);
    users = loadedUsers;
  }

  final List<String> blood_types = [
   // "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Donations>(context, listen: false).getHInfo();
    city = h['city'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).accentColor,
        title: const Text(
            "Search",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black87
          ),
        ),
          actions: <Widget>[
            IconButton(
               icon: const Icon(Icons.search),
               onPressed: () async {
                 setState(() {
                  //
                 });
        final String selected = await showSearch(
            context: context, delegate: _MySearchDelegate(blood_types));

        if (selected != null && selected != query) {
          setState(() {
            query = selected;
          });
        }
      },
    )
    ],
    ),
    body: Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("例如：A+, O-, AB+", style: TextStyle(fontSize: 20)),
      )//_buildList(''),
    ),
    resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildList(_searchText) {
    final searchItems = query.isEmpty
        ? blood_types
        : blood_types.where((c) => c.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if(query.isNotEmpty ){
      getNames(city, query);
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return new  UserSearchItem (
            query,
            users[index].id,
            users[index].name,
            users[index].phone,
            users[index].lastdate,
          );
        },
      );
    }
    else{
      return Text('');
    }
  }
}

class _MySearchDelegate extends SearchDelegate<String> {
    final List<String> blood_types;

    final List<String> _history = [""];

  List<String> filterName = new List();

  _MySearchDelegate(this.blood_types);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon((Icons.clear)),
        onPressed: () {
        query = '';
        _SearchScreenState.users =[];
        showSuggestions(context);
      },
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.isNotEmpty ){
      _SearchScreenState.getNames( _SearchScreenState.city, query);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _SearchScreenState.users.length != 0
        ? ListView.builder(
          itemCount: _SearchScreenState.users.length,
          itemBuilder: (BuildContext context, int index) {
            return new UserSearchItem(
              _SearchScreenState.users[index].bloodtype,
              _SearchScreenState.users[index].id,
              _SearchScreenState.users[index].name,
              _SearchScreenState.users[index].phone,
              _SearchScreenState.users[index].lastdate,
            );
          },
        )
         : Text('', style: TextStyle(fontSize: 20))
      );
    }
    else{
      return Center(child: Text('为了搜索请输入血型', style: TextStyle(fontSize: 20)));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  final suggestions = query.isEmpty
    ? _history
    :  blood_types.where((c) => c.contains(query)).toList();//blood_types.where((c) => c.startsWith(query)).toList();
  return ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (BuildContext context, int index) {
      return new ListTile(
        title: Text(suggestions[index]),
        onTap: () {
        showResults(context);
        //close(context, suggestions[index]);
        },
      );
    });
  }

}

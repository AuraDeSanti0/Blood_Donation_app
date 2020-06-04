import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/donations.dart';
import './hospital_homepage_screen.dart';
import './news_screen.dart';
import './search_screen.dart';
import '../widgets/hospital_drawer.dart';

class HospitalTabsScreen extends StatefulWidget {
  static const routeName = '/hospital-tabs-screen';
  @override
  _HospitalTabsScreenState createState() => _HospitalTabsScreenState();
}

class _HospitalTabsScreenState extends State<HospitalTabsScreen> {

  List <Map<String, Object>> _pages;
  int _selectedPageIndex =0;

  @override
  void initState() {
    _pages =[
      {'page': HospitalHomepageScreen(), 'title': 'Homepage',},
      {'page': SearchScreen(), 'title': 'search',},
      {'page': NewsScreen(), 'title': 'News',},
    ];
    super.initState();
  }

  void _selectPage(int index){
    setState((){
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Donations>(context, listen: false).getHInfo();
    return Scaffold(
     // appBar: AppBar(
      //  title:Text(_pages[_selectedPageIndex]['title']),
     //),
     // drawer: HospitalDrawer(h['hName']),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            //  backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.person_outline,size: 25,),
            title: Text('Homepage'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            //  backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.search, size: 25,),
            title: Text('Search'),
          ),
          /*
          BottomNavigationBarItem(
            //  backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.search, size: 25,),
            title: Text('Messages'),
          ),
          */
          BottomNavigationBarItem(
            //   backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.line_weight, size: 25,),
            title: Text('News'),
          ),
        ],
      ),
    );
  }
}
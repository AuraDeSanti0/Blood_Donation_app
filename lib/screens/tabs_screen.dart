import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './donor_homepage_screen.dart';
import './donor_news_screen.dart';
import '../providers/donations.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  List <Map<String, Object>> _pages;
  int _selectedPageIndex =0;

  @override
  void initState() {
    _pages =[
      {'page': DonorHomepageScreen(), 'title': 'Homepage',},
      //{'page': MessagesScreen(), 'title': 'Messages',},
      {'page':DonorNewsScreen(), 'title': 'News',},
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
    var d = Provider.of<Donations>(context, listen: false).getDInfo();
    return Scaffold(
      //appBar: AppBar(
      //  title:Text(_pages[_selectedPageIndex]['title']),
      //),
     // drawer: MainDrawer(d['dName']),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[500],
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
          ),
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
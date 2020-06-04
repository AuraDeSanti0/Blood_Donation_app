import 'package:flutter/material.dart';
import '../providers/donations.dart';
import '../providers/news.dart';
import '../widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/news_item_all.dart';
class DonorNewsScreen extends StatefulWidget {
  @override
  _DonorNewsScreenState createState() => _DonorNewsScreenState();
}

class _DonorNewsScreenState extends State<DonorNewsScreen> {

  String city;
  Future<void> _refreshAllNews(BuildContext context) async{
    await Provider.of<News>(context, listen: false).fetchAllNews(city);
  }

  @override
  Widget build(BuildContext context) {
    var d = Provider.of<Donations>(context,listen: false).getDInfo();
    city = d['city'];
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            '献血圈',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87//Colors.black87//
            ),),
          backgroundColor: Theme.of(context).accentColor,
         ),
      drawer: MainDrawer(d['dName'], d['sfz']),
     body: FutureBuilder(
       future: _refreshAllNews(context),
       builder: (ctx,snapshot) => RefreshIndicator(
           onRefresh: () => snapshot.connectionState == ConnectionState.waiting
               ? Center(child: CircularProgressIndicator())
               :  _refreshAllNews(context),
           child: Column(children: <Widget>[
             SizedBox(height: 20),
             Expanded(
               child: Consumer<News>(
                   builder: (ctx, newsData,_)=> Padding(
                       padding: EdgeInsets.all(0),
                       child: ListView.builder(
                           itemCount: newsData.allNews.length,
                           itemBuilder: (_,i){
                             return
                               NewsItemAll(newsData.allNews[i]);
                           }
                       )
                   )
               ),
             ),
           ])
       ),
     ),
    );
  }
}

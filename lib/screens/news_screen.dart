import 'package:flutter/material.dart';
import '../providers/news.dart';
import 'package:provider/provider.dart';
import '../widgets/hospital_drawer.dart';
import '../providers/auth.dart';
import '../widgets/news_item.dart';
import '../widgets/add_news.dart';
import '../widgets/news_item_all.dart';
class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  TextEditingController msg = TextEditingController();
  bool pressed;
  String license;
  String city;
  bool _isSwitched = false;
  showOverlay(BuildContext context) async {

    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder:(context) => Positioned(
            top: 50,
            right: 30,
            child:Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.height * 0.5,
              child: Card(
                child: Column(children: <Widget>[
                  Form(
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.height * 0.4,
                      child: TextFormField(
                         controller: msg,
                        maxLines: 3,
                        decoration: InputDecoration(
                            labelText: '消息内容',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    width: 1,
                                    //color: Colors.orange,
                                    style: BorderStyle.solid)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 120,
                    width: 200,
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('选择照片'),
                        onPressed: (){},
                      ),
                      RaisedButton(
                        child: Text('拍照'),
                        onPressed: (){},
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text('提交'),
                    onPressed: (){
                       pressed= false;
                    },
                  )
                ],),
              ),
            ),
        ));
/*
    if(pressed){
     overlayState.insert(overlayEntry);
    }
    if(!pressed) {
      await Future.delayed(Duration(seconds: 2));
      overlayEntry.remove();
    }
*/
   overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 5));
    overlayEntry.remove();
  }

  void _startAddNewsItem(BuildContext ctx){
    showModalBottomSheet(
     // elevation: 10,
      backgroundColor: Colors.grey[400],
     shape: StadiumBorder(
      //  borderRadius: BorderRadius.circular(10),
    ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddNewsIt(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );

  }

  Future<void> _refreshNews(BuildContext context) async{
    await Provider.of<News>(context, listen: false).fetchNewsHospital(license);
  }
  Future<void> _refreshAllNews(BuildContext context) async{
    await Provider.of<News>(context, listen: false).fetchAllNews(city);
  }

  @override
  Widget build(BuildContext context) {
    var h = Provider.of<Auth>(context, listen: true).getHInfo();
   license = h['license'];
   city = h['city'];
    return new Scaffold(
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
          actions: <Widget>[
            Switch(
              onChanged: (val) => setState(() => _isSwitched = val),
              value: _isSwitched,
              activeTrackColor: Colors.blueAccent,//Color.fromRGBO(254, 152, 16, 1.0),
              activeColor: Color.fromRGBO(0, 82, 180, 1.0),
              inactiveTrackColor: Colors.black26,
              inactiveThumbColor: Color.fromRGBO(0, 82, 180, 1.0),
            ),
          ]),
      drawer: HospitalDrawer(h['hName'], h['license']),
      body: _isSwitched
       ? FutureBuilder(
        future: _refreshNews(context),
        //need to change listen to true to update the homepageIcon
       // future: Provider.of<News>(context,listen: true).fetchNewsHospital(license),
        builder: (ctx,snapshot) => RefreshIndicator(//refreshindicator's on refresh f() has to return future
          //so that refreshindicator knows when you're done fetching data
            onRefresh: () => snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                :  _refreshNews(context),
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              Expanded(
                child: Consumer<News>(
                    builder: (ctx, newsData,_)=> Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                            itemCount: newsData.news.length,
                            itemBuilder: (_,i){
                              //print(_isSwitched);
                              return
                                  NewsIt(newsData.news[i]);
                            }
                        )
                    )
                ),
              ),
            ])
        ),
    )
       : FutureBuilder(
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
                        padding: EdgeInsets.only(bottom: 10),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: IconButton(
          icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
          ),
          onPressed: (){_startAddNewsItem(context);},
        ),
         onPressed: (){
        pressed = true;
        _startAddNewsItem(context);// showOverlay(context);
        },
      )

    );
  }

}


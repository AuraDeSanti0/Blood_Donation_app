import 'package:flutter/material.dart';
import '../providers/news.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import '../providers/news.dart' as n;
import 'edit_news.dart';

enum WhyFarther {edit, delete}

class NewsIt extends StatefulWidget {

  final n.NewsItem news1;
  NewsIt(this.news1);

  @override
  _NewsItState createState() => _NewsItState();
}

class _NewsItState extends State<NewsIt> {

  String msg =" ";
  bool isVis = true;
  void _startEditNews(BuildContext ctx, String n_id) {
    showModalBottomSheet(
      context: ctx,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: EditNews(n_id),
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
    String result = " ";
    result =  await Provider.of<News>(context,listen: false).deleteNewsItem(widget.news1.n_id);

    Navigator.of(context).pop();
    dialogText(result);
    //print(msg);
  }

  void _deleteDialog(String d_id){
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('信息'),
          content: Text('您确定想删除吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消',style: TextStyle(color: Colors.black)),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('确定',style: TextStyle(color: Colors.black)),
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
    return  Card(
        margin: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Column(
          children: <Widget>[
            Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white,
            ),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, top: 6.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(0, 83, 181, 1),
                    radius: 30,
                    child:Padding(
                      padding: EdgeInsets.all(0),
                      child:FittedBox(
                          child: Image.asset("assets/images/hospital-icon.png"),
                      ),
                    ),
                  ),
                ),
                title:Padding(
                  padding: const EdgeInsets.only(left: 3.0, bottom: 5.0),
                  child: Text(
                    widget.news1.hName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                //Text(bloodDonations[index].bloodType),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    widget.news1.date.toString(),
                    style: TextStyle(
                      fontSize: 14,
                     // fontWeight: FontWeight.bold,
                    ),
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
                          onPressed: (){
                            _startEditNews(context, widget.news1.n_id);
                          },
                          color: Colors.amber,
                        ),
                      ),
                      PopupMenuItem<WhyFarther>(
                        value: WhyFarther.delete,
                        child: IconButton(
                          icon:Icon(Icons.delete),
                          onPressed: () {
                            _deleteDialog(widget.news1.n_id);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    ],
                  )
              ),
            ),
            widget.news1.imageUrl == null
           ?  Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.news1.msg,
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
            : SizedBox(),
            widget.news1.imageUrl != null
            ? ExpandablePanel(
              header:  Container(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.news1.msg,
                    softWrap: true,
                    //overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              expanded: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: widget.news1.imageUrl != null
                    ?   Image.network(
                    widget.news1.imageUrl)
                    : SizedBox(),
              ),
              tapHeaderToExpand: true,
              hasIcon: true,
            )
            : SizedBox(),
            Padding(
              padding: EdgeInsets.only(bottom: widget.news1.imageUrl == null ? 10 : 0),
            )
           ],
        )

    );

  }

}

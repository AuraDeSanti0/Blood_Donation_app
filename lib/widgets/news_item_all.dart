import 'package:flutter/material.dart';
import '../providers/news.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import '../providers/news.dart' as n;

class NewsItemAll extends StatefulWidget {
  final n.AllNewsItem news1;
  NewsItemAll(this.news1);
  @override
  _NewsItemAllState createState() => _NewsItemAllState();
}

class _NewsItemAllState extends State<NewsItemAll> {
  @override
  Widget build(BuildContext context) {
    return Card(
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

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class AboutUsScreen extends StatefulWidget {
  static const routeName = '/about-us';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
     List<String>imgList = [
       "assets/images/1.png",
       "assets/images/2.png",
       "assets/images/3.png",
       "assets/images/4.png",
       "assets/images/5.png",
    ];
     final Widget placeholder = Container(color: Colors.grey);

     List<T> map<T>(List list, Function handler) {
       List<T> result = [];
       for (var i = 0; i < list.length; i++) {
         result.add(handler(i, list[i]));
       }

       return result;
     }
     final List child = map<Widget>(
       imgList,
           (index, i) {
         return Container(
           //width: mediaQuery.size.width - 100,
           //height: mediaQuery.size.height -200,
           margin: EdgeInsets.all(5.0),
           child: ClipRRect(
             borderRadius: BorderRadius.all(Radius.circular(5.0)),
             child: Stack(children: <Widget>[
               Image.asset(
                   i,
                   fit: BoxFit.cover,
                 width: 1000,
               ),
               Positioned(
                 bottom: 0.0,
                 left: 0.0,
                 right: 0.0,
                 child: Container(
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                       begin: Alignment.bottomCenter,
                       end: Alignment.topCenter,
                     ),
                   ),
                   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                   child: Text(
                     'No. $index ',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ),
             ]),
           ),
         );
       },
     ).toList();

     int _current = 0;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black, //change your color here
        ),
        title: Text(
          '关于我们',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 82, 180, 1.0),//Colors.black87//
          ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body:Padding(
        padding: const EdgeInsets.only(top : 10.0),
        child: Column(children: [
             CarouselSlider(
              items: child,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              imgList,
                  (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

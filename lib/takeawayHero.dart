import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class takeHeroScaffold extends StatefulWidget {
  final String imgPath;
  final String title1;

  const takeHeroScaffold({Key key,this.title1,this.imgPath}) : super(key:key);

  @override
  takeHeroBody createState() => new takeHeroBody();

}

class takeHeroBody extends State<takeHeroScaffold> with AutomaticKeepAliveClientMixin<takeHeroScaffold>{
  Future _loadingDeals;

  Future loadDeals(){
    return DefaultAssetBundle.of(context).loadString('jsons/takeaway.json');
  }

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    _loadingDeals = loadDeals(); // only create the future once.
    super.initState();
  }



  @override

  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 200,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: restHeader(imgPath: widget.imgPath,title1: widget.title1,),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs:[
                      Tab(text: "Entradas",),
                      Tab(text: 'Grelhados',),
                      Tab(text: 'Sushi',),
                      Tab(text: 'Extras',),
                      Tab(text: 'Bebidas',)
                    ],
                  ),
                  ),
                  pinned: true,
                )
              ];
            },
            body: FutureBuilder(
              future: _loadingDeals,
              builder: (context,AsyncSnapshot snapshot) {
                var takeawayItems = json.decode(snapshot.data.toString());
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                    break;
                  default:
                    if(snapshot.hasError)
                      return Container(child:Text(snapshot.error.toString()));
                    return TabBarView(
                      children: <Widget>[
                        GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(12, (index) {
                              return Column(
                                children: <Widget>[
                                  Card(
                                    margin: EdgeInsets.all(10),
                                    child: Container(
                                      child: FadeInImage(
                                        placeholder: MemoryImage(kTransparentImage),
                                        image: Image.asset('assets/takeaway/'+takeawayItems[index]['IMGpath'],fit: BoxFit.cover,).image,
                                        fadeInDuration: Duration(milliseconds: 500),
                                        fit: BoxFit.fill,
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                    child: Text(takeawayItems[index]['id'].toString() + '. '+takeawayItems[index]['nome']),
                                  ),
                                  Container(
                                    height: 16,
                                    child: Text('€'+takeawayItems[index]['price'].toStringAsFixed(2),style: TextStyle(color: Colors.grey),),
                                  )
                                ],
                              );
                            })
                        ),
                        GridView.count(
                            crossAxisCount: 2,
                            children: List.generate(7, (index) {
                              index = index + 12;
                              switch(snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                                break;
                              default:
                                if (snapshot.hasError)
                                  return Container(child:Text(snapshot.error.toString()));
                                return Column(
                                  children: <Widget>[
                                    Card(
                                      margin: EdgeInsets.all(10),
                                      child: Container(
                                          child: FadeInImage(
                                            placeholder: MemoryImage(
                                                kTransparentImage),
                                            image: Image
                                                .asset('assets/takeaway/' +
                                                takeawayItems[index]['IMGpath'],
                                              fit: BoxFit.cover,)
                                                .image,
                                            fadeInDuration: Duration(
                                                milliseconds: 500),
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: 16,
                                      child: Text(takeawayItems[index]['id']
                                          .toString() + '. ' +
                                          takeawayItems[index]['nome']),
                                    ),
                                    Container(
                                      height: 16,
                                      child: Text('€' +
                                          takeawayItems[index]['price']
                                              .toStringAsFixed(2),
                                        style: TextStyle(color: Colors.grey),),
                                    )
                                  ],
                                );
                            }
                            })
                        ),
                        GridView.builder(
                          itemCount: 28,
                          itemBuilder: (BuildContext context, int index){
                            index = index + 19;
                            switch(snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                child: CircularProgressIndicator());
                                break;
                              default:
                                if (snapshot.hasError)
                                return Container(child:Text(snapshot.error.toString()));
                            return new Column(
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                      child: FadeInImage(
                                        placeholder: MemoryImage(kTransparentImage),
                                        image: Image.asset('assets/takeaway/'+takeawayItems[index]['IMGpath'],fit: BoxFit.cover,).image,
                                        fadeInDuration: Duration(milliseconds: 500),
                                      )
                                  ),
                                ),
                                Container(
                                  height: 16,
                                  child: Text(takeawayItems[index]['id'].toString() + '. '+takeawayItems[index]['nome']),
                                ),
                                Container(
                                  height: 16,
                                  child: Text('€'+takeawayItems[index]['price'].toStringAsFixed(2),style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            );
                          }},
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2
                          ),
                        ),
                        GridView.builder(
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index){
                            index = index + 47;
                            return new Column(
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                      child: FadeInImage(
                                        placeholder: MemoryImage(kTransparentImage),
                                        image: Image.asset('assets/takeaway/'+takeawayItems[index]['IMGpath'],fit: BoxFit.cover,).image,
                                        fadeInDuration: Duration(milliseconds: 500),
                                      )
                                  ),
                                ),
                                Container(
                                  height: 16,
                                  child: Text(takeawayItems[index]['id'].toString() + '. '+takeawayItems[index]['nome']),
                                ),
                                Container(
                                  height: 16,
                                  child: Text('€'+takeawayItems[index]['price'].toStringAsFixed(2),style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2
                          ),
                        ),
                        GridView.builder(
                          itemCount: 7,
                          itemBuilder: (BuildContext context, int index){
                            index = index + 53;
                            return new Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(10),
                                  child: Container(
                                      child: FadeInImage(
                                        placeholder: MemoryImage(kTransparentImage),
                                        image:Image.asset(takeawayItems[index]['IMGpath'],fit: BoxFit.cover,).image,
                                        fadeInDuration: Duration(milliseconds: 500),
                                    ),
                                  )
                                ),
                                Container(
                                  height: 16,
                                  child: Text(takeawayItems[index]['id'].toString() + '. '+takeawayItems[index]['nome']),
                                ),
                                Container(
                                  height: 16,
                                  child: Text('€'+takeawayItems[index]['price'].toStringAsFixed(2),style: TextStyle(color: Colors.grey),),
                                )
                              ],
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2
                          ),
                        )
                      ],
                    );
                }
              },
            )
          ),
        )
      )
    );
  }
}

class restHeader extends StatelessWidget{
  String imgPath;
  String title1;

  restHeader({this.imgPath,this.title1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      height: 200,
      child: Hero(
        transitionOnUserGestures: true,
        tag: title1,
        child:
        ClipRRect(
          borderRadius:BorderRadius.circular(0),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: Image.asset(imgPath,
                    //fit: BoxFit.cover,
                    //height: 200,
                    //width: double.infinity,
                    alignment: Alignment.center,
                    //scale: 2,
                  ).image,
                  fadeInDuration: Duration(milliseconds: 250),
                  fit: BoxFit.fill,
                  height: 210,
                  alignment: Alignment.center,

                ),
                Container(
                  alignment:Alignment.center,
                  color: Colors.black26,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 20,right: 10,bottom: 5),
                      child: RichText(
                        text: TextSpan(
                            text: title1[0],
                            style: TextStyle(
                              fontFamily: 'Aclonica',
                              color: Color.fromARGB(240, 230, 40, 40),
                              fontSize: 40,
                            ),
                            children: [
                              TextSpan(
                                  text: title1.substring(1,title1.length),
                                  style: TextStyle(
                                    fontFamily: 'Aclonica',
                                    color: Color.fromARGB(220, 255, 255, 255),
                                    fontSize: 25,
                                  )
                              )
                            ]
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                      ),
                      height: 55,
                    ),
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Material(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}


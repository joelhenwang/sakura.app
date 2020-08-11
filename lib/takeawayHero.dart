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
                    background: restHeader(imgPath: 'assets/img/splash/logo1_illustration_x4.png',title1: 'Takeaway',),
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

                        itemGridView(snapshot, takeawayItems, 0, 12),
                        itemGridView(snapshot, takeawayItems, 12, 7),
                        itemGridView(snapshot, takeawayItems, 19, 28),
                        itemGridView(snapshot, takeawayItems, 47, 6),
                        itemGridView(snapshot, takeawayItems, 53, 7)
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

class itemGridView extends StatelessWidget{
  AsyncSnapshot snapshot;
  var takeawayItems;
  int sum_items;
  int num_items;
  itemGridView(this.snapshot,this.takeawayItems,this.sum_items,this.num_items);

  @override
  Widget build(BuildContext context) {


    return GridView.builder(
      itemCount: num_items,
      itemBuilder: (BuildContext context, int index){
        index = index + sum_items;
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
                  child: InkWell(
                    child: Container(
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: Image.asset(takeawayItems[index]['IMGpath'],fit: BoxFit.cover,).image,
                          fadeInDuration: Duration(milliseconds: 500),
                        )
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                        builder: (_) => itemOverlay()
                      );
                    },
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
    );
  }
}

class itemOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => itemOverlayState();
}

class itemOverlayState extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text("Well hello there!"),
            ),
          ),
        ),
      ),
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
                  fit: BoxFit.fitHeight,
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


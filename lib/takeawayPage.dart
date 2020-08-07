import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'takeawayHero.dart';

class takeawayScaffold extends StatefulWidget {

  @override
  takeawayBody createState() => new takeawayBody();

}

class takeawayBody extends State<takeawayScaffold> {

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: AppBar(
        title: Text('Seleccione o restaurante'),
        backgroundColor: Colors.black,
      ),

      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,

            width: screenSize.width * 0.9,
            height: screenSize.height * 0.9,
            child: ListView(
              padding: EdgeInsets.all(5),
              children: <Widget>[
                restaurantContainer(
                  imgPath: 'assets/restaurantes/entrecampos.JPG',
                  title1: 'Entrecampos',
                ),
                restaurantContainer(
                  imgPath: 'assets/restaurantes/infasakura.JPG',
                  title1: 'Infante Santo',
                ),
                restaurantContainer(
                  imgPath: 'assets/restaurantes/povoa.JPG',
                  title1: 'Póvoa de Varzim',
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

class restaurantContainer extends StatelessWidget{
  String imgPath;
  Image restHeader;
  String title1;
  Widget destScreen;
  restaurantContainer({this.imgPath,this.title1,this.destScreen});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return takeHeroScaffold(title1: title1,imgPath: imgPath,);
          })
          );
        },

        child: Hero(
          transitionOnUserGestures: true,
          tag: title1,
          child:  ClipRRect(
            borderRadius:BorderRadius.circular(25),
            child: Stack(
              fit: StackFit.expand,
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: Image.asset(imgPath,
                      fit: BoxFit.fitWidth,
                      //height: 190,
                      //width: double.infinity,
                      alignment: Alignment.center,
                      //scale: 2,
                    ).image,
                    fadeInDuration: Duration(milliseconds: 250),
                    fit: BoxFit.fill,


                  ),
                  Container(
                      alignment:Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black26,)
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
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)
                            )
                        ),
                        height: 55,
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute(Widget destinyScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinyScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation,curve: Curves.elasticInOut),
        child: child,
      );
    },
  );
}
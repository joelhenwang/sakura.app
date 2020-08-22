import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'ementa.dart';
import 'cartaBebidas2.dart';

class rodizioScaffold extends StatefulWidget {

  @override
  rodizioBody createState() => new rodizioBody();

}

class rodizioBody extends State<rodizioScaffold> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Seleccione a ementa'),
        backgroundColor: Colors.black,
      ),

      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              rodizioButton(
                imgPath: 'assets/img/rodizioFG.png',
                title: 'Rodízio',
                destScreen: ementaScaffold(),
              ),
              rodizioButton(
                imgPath: 'assets/img/bebidasFG.png',
                title:'Bebidas',
                destScreen: cartaBebidasScaffold(),
              )
            ],
          )
        ),
      ),
    );
  }
}

Route _createRoute(Widget destinyScreen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => destinyScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeOutExpo;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class rodizioButton extends StatelessWidget{
  String imgPath;
  String title;
  Widget destScreen;
  rodizioButton({this.imgPath,this.title,this.destScreen});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment:Alignment.center,
      margin:EdgeInsets.only(top: 10,bottom: 20),
      width: MediaQuery.of(context).size.width *0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          )]
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: (){Navigator.of(context).push(_createRoute(destScreen));},
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius:BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: Image.asset(imgPath,
                ).image,
                fadeInDuration: Duration(milliseconds: 250),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width *0.9,
              ),
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
                  padding: EdgeInsets.only(left: 15,right: 20,bottom: 10),
                  child: RichText(
                    text: TextSpan(
                        text: title[0],
                        style: TextStyle(
                          fontFamily: 'Aclonica',
                          color: Color.fromARGB(240, 230, 40, 40),
                          fontSize: 45,
                        ),
                        children: [
                          TextSpan(
                              text: title.substring(1,title.length),
                              style: TextStyle(
                                fontFamily: 'Aclonica',
                                color: Color.fromARGB(220, 255, 255, 255),
                                fontSize: 30,
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
                  height: 75,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
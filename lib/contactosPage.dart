import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:async' show Future;

class contactosScaffold extends StatefulWidget {

  @override
  contactosBody createState() => new contactosBody();

}

class contactosBody extends State<contactosScaffold> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),

      appBar: AppBar(
        title: new Text('Contactos'),
        backgroundColor: Colors.black,
      ),


      body: Center(
        child: ListView(
          children: <Widget>[
            restContactContainer(restJson: 'entrecampos.json',),
            restContactContainer(restJson: 'exposakura.json',),
            restContactContainer(restJson: 'infaSakura.json',),
            restContactContainer(restJson: 'picoas.json',),
            restContactContainer(restJson: 'povoa.json',),
            restContactContainer(restJson: 'oeiras.json',),
            restContactContainer(restJson: 'lindaVelha.json',),
          ],
        ),
      )
    );
  }
}

class restContactContainer extends StatelessWidget {

  String restJson;

  restContactContainer({this.restJson});
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('jsons/'+restJson),
      builder: (context, AsyncSnapshot snapshot){
        var restInfo = json.decode(snapshot.data.toString());
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            if (snapshot.hasError)
              return Container(child: Text(snapshot.error.toString()));
            return Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: (MediaQuery.of(context).size.width * 0.85 *9)/16,
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: Image.asset(restInfo['imgPath'],
                          ).image,
                          fadeInDuration: Duration(milliseconds: 250),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(restInfo['name'], style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.left,),
                        subtitle: Text(restInfo['morada'],
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          textAlign: TextAlign.left,),
                        children: <Widget>[
                          Container(
                            height: 1,
                            color: Color.fromARGB(255, 235, 235, 235),
                          ),
                          ListTile(
                              onTap: () =>
                                  launch("tel://${restInfo['telemovel']}"),
                              trailing: Icon(Icons.phone, color: Colors.green,),
                              title: RichText(
                                text: TextSpan(
                                    text: 'Telemovel: ',
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(text: restInfo['telemovel'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ]
                                ),
                              )
                          ),
                          Container(
                            height: 1,
                            color: Color.fromARGB(255, 235, 235, 235),
                          ),
                          ListTile(
                              onTap: () =>
                                  launch("tel://${restInfo['telefone']}"),
                              trailing: Icon(Icons.phone, color: Colors.green,),
                              title: RichText(
                                text: TextSpan(
                                    text: 'Telefone: ',
                                    style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(text: restInfo['telefone'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal))
                                    ]
                                ),
                              )
                          ),
                          ListTile(
                            onTap: () =>
                                    MapsLauncher.launchQuery(restInfo['morada']),
                            title: Text('Ver no Mapa',
                                        style: TextStyle(color: Colors.lightBlue),
                              textAlign: TextAlign.center,
                                        ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
        }
      }
    );
  }
}

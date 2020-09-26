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
            Column(
              children: [
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text("Sugerir ideia\nEnvie-nos um email!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue,fontSize: 18),
                    ),
                    margin: EdgeInsets.only(top: 5,bottom: 5),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    color: Colors.white,
                  ),
                  onTap: ()=>showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Encontrou um problema na App? Quer sugerir algo?'),
                        content: Text(
                            'Envie-nos um email!\n'
                                'Iremos fazer o melhor para corrigir qualquer problema e, possivelmente, tentar implementar as vossa sugestões!\n'
                                '\n'
                                'Muito Obrigado!'
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Fechar',style: TextStyle(color: Colors.grey),),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                              child: Text('Escrever email',style:
                              TextStyle(fontWeight: FontWeight.bold,color: Colors.lightBlue),
                              ),
                              onPressed: ()=>launch('mailto:sakura.restaurante.app@gmail.com')
                          )
                        ],
                      )
                  ),
                ),
              ],
            )
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
                          Container(
                            height: 1,
                            color: Color.fromARGB(255, 235, 235, 235),
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

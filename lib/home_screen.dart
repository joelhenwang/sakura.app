import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rodizioPage.dart';
import 'takeawayPage.dart';
import 'contactosPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  final keyIsFirstLoaded = 'is_first_loaded';

  AnimationController controller;
  Animation<Offset> rodizioPos;
  Animation<Offset> takeawayPos;
  Animation<Offset> contatosPos;

  @override
  double opacityLevel = 0;// For the welcome text and Logo
  double opacityLevel2 = 0;// For the buttons
  double opacityLevel3 = 0;

  void initState(){
    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);

    rodizioPos = Tween(begin: Offset(0.0,3.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart)
      ).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0, 0.4))
    );

    takeawayPos = Tween(begin: Offset(0.0,3.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart)
    ).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.2, 0.5))
    );

    contatosPos = Tween(begin: Offset(0.0,3.0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutQuart)
    ).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0.3, 1))
    );

    _mockCheckforSession().then(
            (status) {
          if(status){
            setState(() => opacityLevel = opacityLevel == 0 ? 1.0:0.0);
          }
        }
    );

    _mockCheckforSession2().then(
            (status) {
          if(status){
            setState(() => opacityLevel2 = opacityLevel2 == 0 ? 1.0:0.0);
            controller.forward();
          }
        }
    );

    _mockCheckforSession3().then(
            (status) {
          if(status){
            showDialogIfFirstLoaded(context);
            setState(() => opacityLevel3 = opacityLevel3 == 0 ? 1.0:0.0);
          }
        }
    );
  }//Animations config

  Future<bool> _mockCheckforSession() async{
    //Delay inteded for the OpacityAnimated
      await Future.delayed(Duration(milliseconds: 500),(){});
      return true;
  }//Delay for Text and Logo

  Future<bool> _mockCheckforSession2() async{
    //Delay intended for the buttons' SlideTransition
    await Future.delayed(Duration(milliseconds: 1000),(){});
    return true;
  }//Delay for the Buttons

  Future<bool> _mockCheckforSession3() async{
    //Delay intended for the buttons' SlideTransition
    await Future.delayed(Duration(milliseconds: 3500),(){});
    return true;
  }//Delay for the Buttons

  @override
  Widget build(BuildContext context) {
    //showDialogIfFirstLoaded(context);
    return Scaffold(
      primary: false,
      body: SafeArea(
        child:
          Stack(
            children: <Widget>[
              Image.asset(
                'assets/img/splash/D71jem.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,),
              Column(
                children: <Widget>[
                  welcomeContainer(opacityLevel: opacityLevel,),
                  AnimatedOpacity(
                    opacity: opacityLevel2,
                    duration: Duration(milliseconds: 2000),
                    child: Container(
                        margin: EdgeInsets.only(top: 0),
                        color: Colors.transparent,
                        child:Image.asset('assets/img/splash/logo1.png',alignment: Alignment.center,scale: 2,)
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 0,bottom: 0),
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            height: 50,
                          ),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 3000),
                            opacity: opacityLevel2,
                            child: SlideTransition(
                              position: rodizioPos,
                              child:menuButton(destPage: rodizioScaffold(),buttonText: 'RODÍZIO',)
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 3000),
                            opacity: opacityLevel2,
                            child: SlideTransition(
                              position: takeawayPos,
                              child: menuButton(destPage: takeawayScaffold(),buttonText: 'TAKEAWAY',)
                            ),
                          ),
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 3000),
                            opacity: opacityLevel2,
                            child: SlideTransition(
                              position: contatosPos,
                              child: menuButton(destPage: contactosScaffold(),buttonText: 'CONTACTOS',)
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 100,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(Icons.bug_report,size: 40,),
                              onPressed: ()=>showDialog(
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
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
      ),
    );
  }
  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
    if (isFirstLoaded == null) {
      showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AnimatedOpacity(
          opacity: opacityLevel3,
          duration: Duration(milliseconds: 1000),
          child: AlertDialog(
            title: Text('Bem Vindo!'),
            content: Text('Bem vindo à App Sakura Restaurante!\n'
                'Esta App encontra-se ainda em fase de desenvolvimento.\n'
                'Neste momento, a App destina-se apenas para vizualização das ementas de Rodízio/Bebidas/Takeaway e de contactos.\n'
                'No futuro iremos adicionar outras funcionalidades, como por exemplo:\n'
                '- Sistema de cupões\n'
                '- Reserva de mesa\n'
                '- E mais...\n'
                '\n'
                'Pedimos pela vossa compreensão e disfrute da nossa (simples e pequena) aplicação!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Compreendo'),
                onPressed: (){
                  Navigator.of(context).pop();
                  prefs.setBool(keyIsFirstLoaded, false);
                },
              )
            ],
          ),
        );
        }
      );
    };
  }
}

class menuButton extends StatelessWidget{
  Widget destPage;
  String buttonText;
  menuButton({this.destPage,this.buttonText});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => destPage));
      },
      child: Container(
        margin: EdgeInsets.all(20),
        width: 200,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
                stops: [0.01,0.9],
                colors: [Color.fromARGB(255, 255, 200, 200),Color.fromARGB(255, 255, 117, 117)]
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),]
        ),
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: buttonText,
              style: TextStyle(
                  shadows: [
                    Shadow( // bottomLeft
                        offset: Offset(-0.2, -0.2),
                        color: Colors.white70
                    ),
                    Shadow( // bottomRight
                        offset: Offset(0.2, -0.2),
                        color: Colors.white70
                    ),
                    Shadow( // topRight
                        offset: Offset(0.2, 0.2),
                        color: Colors.white70
                    ),
                    Shadow( // topLeft
                        offset: Offset(-0.2, 0.2),
                        color: Colors.white70
                    ),
                  ],
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20
              )
          ),
        ),
      ),
    );
  }
}

class welcomeContainer extends StatelessWidget{
  double opacityLevel;
  welcomeContainer({this.opacityLevel});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: AnimatedOpacity(
                opacity: opacityLevel,
                duration: Duration(milliseconds: 1500),
                child: Text(
                  'Bem Vindo',
                  style: TextStyle(
                    shadows: [
                      Shadow(offset: Offset(-0.2, 1),
                          color: Colors.black12),
                      Shadow( // bottomRight
                          offset: Offset(0.2, 1),
                          color: Colors.black12
                      ),
                    ],
                    fontFamily: 'Aclonica',
                    fontSize: 40,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                )
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
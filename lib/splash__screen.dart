import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:async';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override

  void initState(){
    super.initState();
    _mockCheckforSession().then(
            (status) {
          if(status){
            _navigateToHome();
          }
        }
    );
  }

  Future<bool> _mockCheckforSession() async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen()
      )
    );
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
                'assets/img/splash/D71jem.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,),
            Image.asset('assets/img/splash/logo1.png',alignment: Alignment.center,scale: 2,)
          ],
        ),
      ),
    );
  }
}

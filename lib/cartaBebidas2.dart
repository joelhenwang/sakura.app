import 'package:flutter/material.dart';

class cartaBebidasScaffold extends StatefulWidget {

  @override
  cartaBebidasBody createState() => new cartaBebidasBody();

}

class cartaBebidasBody extends State<cartaBebidasScaffold> {
  String categoria = 'Bebidas';
  PageController _pageController;

  List<String> categories = ['Bebidas','Branco/Verde','Tinto/Rosé','Aperitivo/Whisky',
    'Sekerinha/Gin'];


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        title: new Text('Carta de Bebidas',textAlign: TextAlign.center,),
        backgroundColor: Color.fromARGB(255, 100, 90, 90),
      ),


      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (page){
                    setState(() {
                      categoria = categories[page];
                    });
                  },
                  children: _buildPages(),
              )
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(255, 100, 90, 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: (){_pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut);}
                    ,
                  ),
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
                    value: categoria,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                    dropdownColor: Color.fromARGB(255, 100, 90, 90),
                    onChanged: (String newValue){
                      setState(() {
                        categoria = newValue;
                        pageSwitch(categoria, _pageController);
                      });
                    },
                    items: categories.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,textAlign: TextAlign.right,),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.white,
                    onPressed: (){_pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> _buildPages(){
  return[
    Image.asset('assets/bebidas/bebidas.jpg'),

    Image.asset('assets/bebidas/branco_verde.jpg'),

    Image.asset('assets/bebidas/tinto_rose.jpg'),

    Image.asset('assets/bebidas/aperitivos_whisky.jpg'),

    Image.asset('assets/bebidas/sekerinha_gin.jpg'),
  ];
}

void pageSwitch(String categoria,PageController _pageController){
  switch(categoria){
    case 'Bebidas':
      _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Branco/Verde':
      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Tinto/Rosé':
      _pageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Aperitivo/Whisky':
      _pageController.animateToPage(4, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Sekerinha/Gin':
      _pageController.animateToPage(5, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
  }
}
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ementaScaffold extends StatefulWidget {

  @override
  ementaBody createState() => new ementaBody();

}

class ementaBody extends State<ementaScaffold>{
  String categoria = 'Combinados';
  PageController _pageController;
  Image combinados;
  Image nigiri1;
  Image nigiri2;
  Image gunkan;
  Image sashimi;
  Image temaki;
  Image california;
  Image uramaki;
  Image braseados;
  Image hotSushi;
  Image couvert1;
  Image couvert2;
  Image teppan1;
  Image teppan2;
  Image especial;
  Image sobremesa;

  List<String> categories = ['Combinados','Nigiri','Gunkan','Sashimi','Temaki',
    'Califórnia','Uramaki','Braseado','Hot Sushi','Couvert','Teppanyaki','Especial','Sobremesa'];

  List<String> categories2 = ['Combinados','Nigiri','Nigiri','Gunkan','Sashimi','Temaki',
    'Califórnia','Uramaki','Braseado','Hot Sushi','Couvert','Couvert','Teppanyaki','Teppanyaki','Especial','Sobremesa'];

  @override
  void initState() {
    super.initState();
    combinados = Image.asset('assets/Rodizio/1.Combinados.png');
    nigiri1 = Image.asset('assets/Rodizio/2.Nigiri_Sushi.png');
    nigiri2 = Image.asset('assets/Rodizio/3.Nigiri_sushi.png');
    gunkan = Image.asset('assets/Rodizio/4.Gunkan_Sushi.png');
    sashimi = Image.asset('assets/Rodizio/5.Sashimi.png');
    temaki = Image.asset('assets/Rodizio/6.Temaki.png');
    california = Image.asset('assets/Rodizio/7.California_maki.png');
    uramaki = Image.asset('assets/Rodizio/8.Uramaki.png');
    braseados = Image.asset('assets/Rodizio/9.Braseados.png');
    hotSushi = Image.asset('assets/Rodizio/10.Hot_Sushi.png');
    couvert1 = Image.asset('assets/Rodizio/11.Couvert.png');
    couvert2 = Image.asset('assets/Rodizio/12.Couvert.png');
    teppan1 = Image.asset('assets/Rodizio/13.Teppan_Yaki.png');
    teppan2 = Image.asset('assets/Rodizio/14.Teppan_Yaki.png');
    especial = Image.asset('assets/Rodizio/15.Especial_Jantar.png');
    sobremesa = Image.asset('assets/Rodizio/16.Sobremesas.png');
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
        title: new Text('Ementa Rodizio',textAlign: TextAlign.center,),
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
                  categoria = categories2[page];
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
                      fontSize: 16
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

    Image.asset('assets/Rodizio/1.Combinados.png'),

    Image.asset('assets/Rodizio/2.Nigiri_Sushi.png'),

    Image.asset('assets/Rodizio/3.Nigiri_sushi.png'),

    Image.asset('assets/Rodizio/4.Gunkan_Sushi.png'),

    Image.asset('assets/Rodizio/5.Sashimi.png'),

    Image.asset('assets/Rodizio/6.Temaki.png'),

    Image.asset('assets/Rodizio/7.California_maki.png'),

    Image.asset('assets/Rodizio/8.Uramaki.png'),

    Image.asset('assets/Rodizio/9.Braseados.png'),

    Image.asset('assets/Rodizio/10.Hot_Sushi.png'),

    Image.asset('assets/Rodizio/11.Couvert.png'),

    Image.asset('assets/Rodizio/12.Couvert.png'),

    Image.asset('assets/Rodizio/13.Teppan_Yaki.png'),

    Image.asset('assets/Rodizio/14.Teppan_Yaki.png'),

    Image.asset('assets/Rodizio/15.Especial_Jantar.png'),

    Image.asset('assets/Rodizio/16.Sobremesas.png'),

  ];
}

void pageSwitch(String categoria,PageController _pageController){
  switch(categoria){
    case 'Combinados':
      _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Nigiri':
      _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Gunkan':
      _pageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Sashimi':
      _pageController.animateToPage(4, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Temaki':
      _pageController.animateToPage(5, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Califórnia':
      _pageController.animateToPage(6, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Uramaki':
      _pageController.animateToPage(7, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Braseado':
      _pageController.animateToPage(8, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Hot Sushi':
      _pageController.animateToPage(9, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Couvert':
      _pageController.animateToPage(10, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Teppanyaki':
      _pageController.animateToPage(12, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Especial':
      _pageController.animateToPage(14, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
    case 'Sobremesa':
      _pageController.animateToPage(15, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      break;
  }
}
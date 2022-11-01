import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends  StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var myFont = GoogleFonts.pragatiNarrow(
    textStyle: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      letterSpacing: 3,
      fontWeight: FontWeight.bold,
    ),
  );

  bool isTurn=true;
  int oScore=0;
  int xScore=0;
  int count=0;
  List<String> changeXO = ['','','','','','','','','',];

  @override
  void initState() {
    super.initState();
  }
      //255, 255, 0, 221 viola
      //197, 255, 115, 0 arancione
  @override
  Widget build(BuildContext context) {
    int x = 0;
    int y = 0;
    int z = 0;
    int o = 0;
    if (isTurn) {
      x = 255;
      y = 255;
      z = 0;
      o = 221;
    } else {
      x = 197;
      y = 255;
      z = 115;
      o = 0;
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(x, y, z, o),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Giocatore X',
                          style: GoogleFonts.pragatiNarrow(
                           textStyle: myFont,
                           color: Color.fromARGB(255, 161, 0, 135)
                          ),
                        ),
                        SizedBox(height: 5.0,),
                        Text(
                          xScore.toString(),
                          style: myFont
                        ),
                      ],
                    ),
                    SizedBox(width: 40,),
                    Column(
                      children: [
                        Text(
                          'Giocatore O',
                          style: GoogleFonts.pragatiNarrow(
                            textStyle: myFont,
                            color: Color.fromARGB(255, 124, 0, 97)
                          )
                          
                        ),
                        SizedBox(height: 10.0,),
                        Text(
                          oScore.toString(),
                          style: myFont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: GridView.builder(
                  itemBuilder: (BuildContext context,int index){
                    return GestureDetector(
                      onTap: (){
                        setXOrO(index); 
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color:Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: Center(
                            child: Text(
                          changeXO[index],
                          style: myFont,
                        )),
                      ),
                    );
                  },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void setXOrO (int i){

    if(isTurn&&changeXO[i]==''){
      setState(() {
        changeXO[i]='O';
        isTurn =!isTurn;
      });
    }
    else if(!isTurn && changeXO[i]==''){
      setState(() {
        changeXO[i]='X';
        isTurn =!isTurn;
      });
    }
    count++;
    checkWinner();
  }

  void checkWinner(){
    if(changeXO[0]==changeXO[1] && changeXO[0]==changeXO[2] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    else if(changeXO[3]==changeXO[4] && changeXO[3]==changeXO[5] && changeXO[3]!='' ){
      _showDialog(changeXO[3]);
    }
    else if(changeXO[6]==changeXO[7] && changeXO[6]==changeXO[8] && changeXO[6]!='' ){
      _showDialog(changeXO[6]);
    }

    else if(changeXO[0]==changeXO[3] && changeXO[0]==changeXO[6] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    else if(changeXO[1]==changeXO[4] && changeXO[1]==changeXO[7] && changeXO[1]!='' ){
      _showDialog(changeXO[1]);
    }
    else if(changeXO[2]==changeXO[5] && changeXO[2]==changeXO[8] && changeXO[2]!='' ){
      _showDialog(changeXO[2]);
    }

    else if(changeXO[0]==changeXO[4] && changeXO[0]==changeXO[8] && changeXO[0]!='' ){
      _showDialog(changeXO[0]);
    }
    else if(changeXO[2]==changeXO[4] && changeXO[2]==changeXO[6] && changeXO[2]!='' ){
      _showDialog(changeXO[2]);
    }

    if(count==9){
      _showNoWinner();
      clearBoard();
    }

  }

  void _showNoWinner(){
    showDialog(
        barrierDismissible: false,
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text('Nessun Vincitore'),
            actions: [
              TextButton(
                  onPressed: (){
                    count=0;
                    clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Riprova'),
              ),
            ],
          );
        }
    );

  }

  void _showDialog(String winner){

    showDialog(
       barrierDismissible: false,
         context:context,
      builder: (context){
           return AlertDialog(
             title: Text('$winner ha vinto'),
             actions: [
               TextButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 child: Text('Riprova'),
               ),
             ],
           );
      }
     );
    count=0;
    clearBoard();
    if(winner =='o'){
      setState(() {
        oScore++;
      });
     }else if(winner=='x'){
      setState(() {
        xScore++;
      });
     }
  }

  void clearBoard(){
    for(int i=0;i<9;i++){
      changeXO[i]='';
    }
  }


}

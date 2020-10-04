import 'package:flutter/material.dart';
import './buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

void main() {
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
 ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(fontFamily: 'Poppins'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var userOutput = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Expanded(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userInput,
                        style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.black45,
                            fontSize: 25,
                            fontFamily: 'Nutmeg'))),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userOutput,
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 45,
                            color: Colors.orange[300],
                            fontFamily: 'Nutmeg',
                            fontWeight: FontWeight.bold))),
              ],
            )),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttonClicked: () {
                            setState(() {
                              userInput = '';
                              userOutput = '';
                            });
                          },
                          buttonText: buttons[index],
                          textColor: Colors.red[400],
                          fontWeight: FontWeight.bold,
                          textSize: 30,
                          fontFamily: 'Poppins',
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttonClicked: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                              userOutput = '';
                            });
                          },
                          buttonPressed: () {
                            setState(() {
                              userInput = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.white,
                          textColor: Colors.black54,
                          fontWeight: FontWeight.bold,
                          textSize: 25,
                          fontFamily: 'Poppins',
                        );
                      } else if (index == 19) {
                        return MyButton(
                          buttonClicked: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.green[400],
                          textColor: Colors.white,
                          textSize: 40,
                          fontWeight: FontWeight.bold,
                        );
                      } else if (isOperator(buttons[index]) == true) {
                        return MyButton(
                          buttonClicked: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.white,
                          textColor: Colors.orange[400],
                          fontWeight: FontWeight.bold,
                          textSize: 30,
                        );
                      } else {
                        return MyButton(
                          buttonClicked: () {
                            setState(() {
                              userInput += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.white,
                          textColor: Colors.black54,
                          textSize: 30,
                          fontWeight: FontWeight.bold,
                        );
                      }
                    }),
              ))
        ]));
  }

  bool isOperator(String x) {
    if (x == '÷' || x == 'x' || x == '+' || x == '-' || x == '%') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalInput = userInput;
    finalInput = finalInput.replaceAll('x', '*');
    finalInput = finalInput.replaceAll('%', '/100');
    finalInput = finalInput.replaceAll('÷', '/');

    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userOutput = eval.toString();
  }
}

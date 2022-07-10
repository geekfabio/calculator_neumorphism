import 'package:calculator/app/utils/neumorphism_extension.dart';
import 'package:calculator/calculator/view/widgets/calculator_buttom.dart';
import 'package:calculator/calculator/view/widgets/top_menu_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userQuestion = '';
  String _userAnswer = '';

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopMenu(),
            SizedBox(
              height: _screenHeight > 610 ? 0 : 10,
            ),

            //Calculator Message
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 12,
                  bottom: 5,
                ),
                child: Container(
                  height: 115,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              '0.0',
                              style: TextStyle(
                                fontSize: _screenHeight < 670 ? 34 : 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FittedBox(
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              '0',
                              style: TextStyle(
                                fontSize: _screenHeight < 670 ? 40 : 45,
                                //fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).addNeumorphism(),
              ),
            ),
            SizedBox(
              height: _screenHeight > 610 ? 0 : 10,
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: button.length,
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return CalculatorButton(
                      onPressed: () {
                        setState(() {
                          _userQuestion = '';
                          _userAnswer = '';
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                  // Delete Button
                  else if (index == 1) {
                    return CalculatorButton(
                      onPressed: () {
                        setState(() {
                          if (_userQuestion != '') {
                            _userQuestion = _userQuestion.substring(
                              0,
                              _userQuestion.length - 1,
                            );
                          }
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                  // Equal Button
                  else if (index == button.length - 1) {
                    return CalculatorButton(
                      onPressed: () => setState(() {
                        if (_userQuestion != '' &&
                            !_userQuestion.startsWith('﹪') &&
                            !_userQuestion.startsWith('÷') &&
                            !_userQuestion.startsWith('×') &&
                            !_userQuestion.endsWith('÷') &&
                            !_userQuestion.endsWith('×') &&
                            !_userQuestion.endsWith('−') &&
                            !_userQuestion.endsWith('+')) {
                          print('equalPresser();');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Invalid input string..'),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            ),
                          );
                        }
                      }),
                      buttonText: button[index],
                    );
                  }
                  // Rest of the buttons
                  else {
                    return CalculatorButton(
                      onPressed: () {
                        setState(() {
                          _userQuestion += button[index];
                        });
                      },
                      buttonText: button[index],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> button = [
  'C',
  '⌫',
  '﹪',
  '÷',
  '1',
  '2',
  '3',
  '×',
  '4',
  '5',
  '6',
  '−',
  '7',
  '8',
  '9',
  '+',
  '0',
  '.',
  '+/-',
  '=',
];

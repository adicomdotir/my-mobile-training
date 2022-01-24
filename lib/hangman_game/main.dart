import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(HangmanApp());
}

class HangmanApp extends StatefulWidget {
  HangmanApp({Key? key}) : super(key: key);

  @override
  _HangmanAppState createState() => _HangmanAppState();
}

class _HangmanAppState extends State<HangmanApp> {
  List<bool> letterClick = List.generate(27, (index) => false);
  int globalIdx = 0;
  String actualAnswer = 'ANKARA';
  String correctAnswer = '------';
  String wrongAnswer = '------';
  bool gameComplete = false;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: Scaffold(
        body: SafeArea(
            child: Container(
          width: double.infinity,
          color: Color(0xFF40149C),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 64,
              ),
              Text(
                'What is capital of ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Turkey',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                correctAnswer,
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                wrongAnswer,
                style: TextStyle(fontSize: 40, color: Color(0xFF8B73C2)),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[0] = true;
                        checkAnswer('A');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[0] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[0] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[1] = true;
                        checkAnswer('B');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[1] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'B',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[1] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[2] = true;
                        checkAnswer('C');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[2] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'C',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[2] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[3] = true;
                        checkAnswer('D');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[3] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'D',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[3] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[4] = true;
                        checkAnswer('E');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[4] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'E',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[4] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[5] = true;
                        checkAnswer('F');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[5] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'F',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[5] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[6] = true;
                        checkAnswer('G');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[6] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[6] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[7] = true;
                        checkAnswer('H');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[7] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'H',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[7] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[8] = true;
                        checkAnswer('I');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[8] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'I',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[8] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[9] = true;
                        checkAnswer('J');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[9] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'J',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[9] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[10] = true;
                        checkAnswer('K');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[10] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'K',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[10] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[11] = true;
                        checkAnswer('L');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[11] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'L',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[11] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[12] = true;
                        checkAnswer('M');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[12] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[12] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[13] = true;
                        checkAnswer('N');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[13] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'N',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[13] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[14] = true;
                        checkAnswer('O');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[14] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'O',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[14] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[15] = true;
                        checkAnswer('P');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[15] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'P',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[15] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[16] = true;
                        checkAnswer('Q');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[16] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'Q',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[16] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[17] = true;
                        checkAnswer('R');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[17] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'R',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[17] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[18] = true;
                        checkAnswer('S');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[18] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[18] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[19] = true;
                        checkAnswer('T');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[19] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'T',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[19] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[20] = true;
                        checkAnswer('U');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[20] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'U',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[20] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[21] = true;
                        checkAnswer('V');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[21] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'V',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[21] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[22] = true;
                        checkAnswer('W');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[22] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'W',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[22] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[23] = true;
                        checkAnswer('X');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[23] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'X',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[23] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[24] = true;
                        checkAnswer('Y');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[24] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'Y',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[24] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[25] = true;
                        checkAnswer('Z');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[25] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          'Z',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[25] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        letterClick[26] = true;
                        checkAnswer(' ');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: letterClick[26] == false
                            ? Color(0xFF078AFF)
                            : Color(0xFF8B73C2),
                      ),
                      child: Center(
                        child: Text(
                          '',
                          style: TextStyle(
                              fontSize: 35,
                              color: letterClick[26] == false
                                  ? Colors.white
                                  : Color(0xFFB8AADA)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        '',
                        style: TextStyle(
                            fontSize: 35,
                            color: letterClick[26] == false
                                ? Colors.white
                                : Color(0xFFB8AADA)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void checkAnswer(String letter) {
    if (globalIdx >= actualAnswer.length) {
      message = 'You Lose';
      gameComplete = true;
    }

    if (gameComplete == false) {
      int cnt = 0;
      for (var i = 0; i < actualAnswer.length; i++) {
        if (actualAnswer[i] == letter) {
          var tmp = correctAnswer.split('');
          tmp[i] = letter;
          correctAnswer = tmp.join('');
          cnt++;
        }
      }
      if (cnt == 0) {
        var tmp = wrongAnswer.split('');
        tmp[globalIdx] = letter;
        wrongAnswer = tmp.join('');
        globalIdx += 1;
      }
      if (correctAnswer == actualAnswer) {
        message = 'You Win';
        gameComplete = true;
      }
    }
  }
}

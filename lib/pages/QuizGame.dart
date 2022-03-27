import 'dart:async';
import 'dart:convert';

import 'package:final_620710771/models/api_result.dart';
import 'package:final_620710771/models/quiz_list.dart';
import 'package:final_620710771/pages/quiz_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizGame extends StatefulWidget {
  final int quizIndex;

  const QuizGame({Key? key, required this.quizIndex}) : super(key: key);

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  late int _quizIndex;
  var trueee = false;
  var msg = "";

  @override
  void initState() {
    super.initState();
    _loadquiz();
    _quizIndex = widget.quizIndex;
  }

  @override
  Widget build(BuildContext context) {
    var quizItem = QuizData.list[_quizIndex];

    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Image.network(
                quizItem.image,
                height: 350.0,
              ),
              if (_quizIndex < QuizData.list.length)
                Column(
                  children: [
                    for (var i = 0; i < quizItem.choice_list.length; i++)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton(
                              onPressed: () => _handleClickButton(
                                  quizItem.choice_list[i], quizItem.answer),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("${quizItem.choice_list[i]} "),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              if (trueee)
                Text(
                  msg,
                  style: TextStyle(color: Colors.green, fontSize: 20.0),
                )
              else
                Text(msg, style: TextStyle(color: Colors.red, fontSize: 20.0))
            ],
          )
        ],
      ),
    );
  }

  Future<dynamic> _loadquiz() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    final response = await http.get(url, headers: {'id': '620710771'});
    var json = jsonDecode(response.body);
    var apiResult = ApiResult.fromJson(json);
    print(json);

    setState(() {
      QuizData.list = apiResult.data
          .map<QuizItem>((item) => QuizItem.fromJson(item))
          .toList();
    });
  }

  void _handleClickButton(String value, String ans) {
    if (value == ans)
      setState(() {
        trueee = true;
        msg = "เก่งมากครับ";
        Timer(Duration(seconds: 1), () {
          setState(() {
            _quizIndex++;
            msg = "";
          });
        });
      });
    else
      setState(() {
        trueee = false;
        msg = "ยังไม่ถูกครับ ลองทายใหม่";
      });
  }
}

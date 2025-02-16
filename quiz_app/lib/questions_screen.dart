import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
  });

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text((currentQuestionIndex + 1).toString(),
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(75, 255, 255, 255),
                  fontSize: 84,
                  fontWeight: FontWeight.w900,
                )),
            Text(currentQuestion.question,
                // style: TextStyle(
                //   color: Colors.white,
                //   fontFamily: 'Inter',
                //   fontSize: 24,
                //   fontWeight: FontWeight.bold,
                // ),
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(220, 255, 255, 255),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffledAnswers().map((answer) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: AnswerButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}

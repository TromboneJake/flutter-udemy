import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    return SizedBox(
      height: 420,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: summaryData.map((data) {
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: data['user_answer'] == data['answer']
                      ? Colors.greenAccent
                      : const Color.fromARGB(200, 255, 82, 82),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  ((data['question_index'] as int) + 1).toString(),
                  style: GoogleFonts.inter(
                    color: const Color.fromARGB(150, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['question'] as String,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      data['user_answer'] as String,
                      style: GoogleFonts.inter(
                        color: data['user_answer'] == data['answer']
                            ? Colors.greenAccent
                            : const Color.fromARGB(200, 255, 82, 82),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      data['answer'] as String,
                      style: GoogleFonts.inter(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

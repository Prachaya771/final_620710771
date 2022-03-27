class QuizItem {
  final String image;
  final String answer;
  final List choice_list;

  QuizItem({
    required this.image,
    required this.answer,
    required this.choice_list,
  });

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(
      image: json['image'],
      answer: json['answer'],
      choice_list: json['choice_list'],
    );
  }
}
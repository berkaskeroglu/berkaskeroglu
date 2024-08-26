class Income {
  final int id;
  final String uid;
  final String category;
  final double amount;
  final DateTime date;
  double incomeSum;

  Income({
    required this.id,
    required this.uid,
    required this.category,
    required this.amount,
    required this.date,
    this.incomeSum = 0,
  });
  
  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['id'],
      uid: json['uid'],
      category: json['category'],
      amount: (json['incomeAmount'] ?? 0).toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
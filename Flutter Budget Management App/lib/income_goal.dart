class IncomeGoal {
  final int id;
  final String uid;
  final String date;
  final double amount;

  IncomeGoal({
    required this.id,
    required this.uid,
    required this.amount,
    required this.date,
  });
  
  factory IncomeGoal.fromJson(Map<String, dynamic> json) {
    return IncomeGoal(
      id: json['id'],
      uid: json['uid'],
      date: json['date'],
      amount: (json['goal'] ?? 0).toDouble(),
    );
  }
}
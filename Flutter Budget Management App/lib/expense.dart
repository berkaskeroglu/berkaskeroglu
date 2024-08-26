class Expense {
  final int id;
  final String uid;
  final String category;
  final double amount;
  //final String description;
  final DateTime date;
  double expenseSum;

  Expense({
    required this.id,
    required this.uid,
    required this.category,
    required this.amount,
    //required this.description,
    required this.date,
    this.expenseSum = 0,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      uid: json['uid'],
      category: json['category'],
      amount: (json['expenseAmount'] ?? 0).toDouble(),
      // description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}

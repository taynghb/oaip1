class BankingService {
  final String id;
  final String name;
  final String description;
  final double interestRate;
  final int minDurationMonths;

  BankingService({
    required this.id,
    required this.name,
    required this.description,
    required this.interestRate,
    required this.minDurationMonths,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'interestRate': interestRate,
      'minDurationMonths': minDurationMonths,
    };
  }

  factory BankingService.fromMap(Map<String, dynamic> map) {
    return BankingService(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      interestRate: map['interestRate'] as double,
      minDurationMonths: map['minDurationMonths'] as int,
    );
  }

  @override
  String toString() {
    return 'ID: $id, Название: $name, Ставка: $interestRate%, Срок: $minDurationMonths мес., Описание: $description';
  }
}
class Position {
  final String id;
  final String title;
  final double salary;
  final String description;

  Position({
    required this.id,
    required this.title,
    required this.salary,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'salary': salary,
      'description': description,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      id: map['id'] as String,
      title: map['title'] as String,
      salary: map['salary'] as double,
      description: map['description'] as String,
    );
  }

  @override
  String toString() {
    return 'ID: $id, Должность: $title, Оклад: $salary руб., Описание: $description';
  }
}
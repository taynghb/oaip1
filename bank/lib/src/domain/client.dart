class Client {
  final String id;
  final String name;
  final String phone;
  final String email;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() {
    return 'ID: $id, Имя: $name, Телефон: $phone, Email: $email';
  }
}
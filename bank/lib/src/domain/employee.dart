import 'package:bank/src/data/repositories/position_rep.dart';
import 'package:bank/bank_system.dart';

class Employee {
  final String id;
  final String fullName;
  final String positionId;
  final String phone;
  final DateTime hireDate;
  Position? position; 

  Employee({
    required this.id,
    required this.fullName,
    required this.positionId,
    required this.phone,
    required this.hireDate,
    this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'positionId': positionId,
      'phone': phone,
      'hireDate': hireDate.toIso8601String(),
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      positionId: map['positionId'] as String,
      phone: map['phone'] as String,
      hireDate: DateTime.parse(map['hireDate'] as String),
    );
  }

  @override
  String toString() {
    return 'ID: $id, ФИО: $fullName, Должность: ${position?.title ?? positionId}, Телефон: $phone, Дата найма: ${hireDate.toLocal()}';
  }
}
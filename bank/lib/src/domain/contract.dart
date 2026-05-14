
import 'package:bank/bank_system.dart';

class Contract {
  final String id;
  final String clientId;
  final String employeeId;
  final String serviceId;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  
  // Связи с другими сущностями
  Client? client;
  Employee? employee;
  BankingService? service;

  Contract({
    required this.id,
    required this.clientId,
    required this.employeeId,
    required this.serviceId,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.client,
    this.employee,
    this.service,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'employeeId': employeeId,
      'serviceId': serviceId,
      'amount': amount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
    };
  }

  factory Contract.fromMap(Map<String, dynamic> map) {
    return Contract(
      id: map['id'] as String,
      clientId: map['clientId'] as String,
      employeeId: map['employeeId'] as String,
      serviceId: map['serviceId'] as String,
      amount: map['amount'] as double,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      status: map['status'] as String,
    );
  }

  @override
  String toString() {
    return '''
ID: $id
Клиент: ${client?.name ?? clientId}
Сотрудник: ${employee?.fullName ?? employeeId}
Услуга: ${service?.name ?? serviceId}
Сумма: $amount руб.
Период: ${startDate.toLocal()} - ${endDate.toLocal()}
Статус: $status''';
  }
}
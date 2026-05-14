import 'dart:convert';

import 'package:bank/bank_system.dart';
import 'dart:io';


void runMenu(BankDatabase db){
final clientRepo = ClientRepository(db);
  final positionRepo = PositionRepository(db);
  final employeeRepo = EmployeeRepository(db);
  final serviceRepo = BankingServiceRepository(db);
  final contractRepo = ContractRepository(db);
  
  while (true) {
    print('''
--- УПРАВЛЕНИЕ КЛИЕНТАМИ ---
1. Все клиенты
2. Добавить клиента
3. Обновить клиента
4. Удалить клиента

--- УПРАВЛЕНИЕ ДОЛЖНОСТЯМИ ---
5. Все должности
6. Добавить должность
7. Обновить должность
8. Удалить должность

--- УПРАВЛЕНИЕ СОТРУДНИКАМИ ---
9. Все сотрудники
10. Добавить сотрудника
11. Обновить сотрудника
12. Удалить сотрудника

--- УПРАВЛЕНИЕ УСЛУГАМИ ---
13. Все услуги
14. Добавить услугу
15. Обновить услугу
16. Удалить услугу

--- УПРАВЛЕНИЕ ДОГОВОРАМИ ---
17. Все договоры
18. Добавить договор
19. Обновить договор
20. Удалить договор

21. Показать всё из БД
0. Выход
''');
    
    stdout.write('Выберите пункт: ');
    final choice = stdin.readLineSync()?.trim() ?? '';
    
    switch (choice) {
      case '1':
        _listClients(clientRepo);
        break;
      case '2':
        _addClient(clientRepo);
        break;
      case '3':
        _updateClient(clientRepo);
        break;
      case '4':
        _deleteClient(clientRepo);
        break;
        
      case '5':
        _listPositions(positionRepo);
        break;
      case '6':
        _addPosition(positionRepo);
        break;
      case '7':
        _updatePosition(positionRepo);
        break;
      case '8':
        _deletePosition(positionRepo);
        break;
        
      case '9':
        _listEmployees(employeeRepo);
        break;
      case '10':
        _addEmployee(employeeRepo, positionRepo);
        break;
      case '11':
        _updateEmployee(employeeRepo);
        break;
      case '12':
        _deleteEmployee(employeeRepo);
        break;
        

      case '13':
        _listServices(serviceRepo);
        break;
      case '14':
        _addService(serviceRepo);
        break;
      case '15':
        _updateService(serviceRepo);
        break;
      case '16':
        _deleteService(serviceRepo);
        break;

      case '17':
        _listContracts(contractRepo);
        break;
      case '18':
        _addContract(contractRepo, clientRepo, employeeRepo, serviceRepo);
        break;
      case '19':
        _updateContract(contractRepo);
        break;
      case '20':
        _deleteContract(contractRepo);
        break;
        
      case '21':
        _showAllFromDb(clientRepo, positionRepo, employeeRepo, serviceRepo, contractRepo);
        break;
        
      case '0':
        print('До свидания!');
        return;
        
      default:
        print('Неверный выбор. Попробуйте снова.');
    }
  }
}

void _listClients(ClientRepository repo) {
  final clients = repo.getAll();
  if (clients.isEmpty) {
    print('Клиентов нет.');
    return;
  }
  print('\n--- КЛИЕНТЫ ---');
  for (var c in clients) {
    print('ID: ${c.id} | ${c.name} | ${c.phone} | ${c.email}');
  }
}

void _addClient(ClientRepository repo) {
  print('\n--- ДОБАВЛЕНИЕ КЛИЕНТА ---');
  final id = _readInput('ID клиента');
  final name = _readInput('ФИО');
  final phone = _readInput('Телефон');
  final email = _readInput('Email');
  
  repo.insert(Client(
    id: id,
    name: name,
    phone: phone,
    email: email,
  ));
  print('Клиент добавлен успешно!');
}

void _updateClient(ClientRepository repo) {
  final id = _readInput('ID клиента для обновления');
  final existing = repo.getById(id);
  if (existing == null) {
    print('Клиент с ID $id не найден');
    return;
  }
  
  print('\n--- ОБНОВЛЕНИЕ КЛИЕНТА---');
  final name = _readInput('ФИО (${existing.name})');
  final phone = _readInput('Телефон (${existing.phone})');
  final email = _readInput('Email (${existing.email})');
  
  repo.update(Client(
    id: id,
    name: name.isEmpty ? existing.name : name,
    phone: phone.isEmpty ? existing.phone : phone,
    email: email.isEmpty ? existing.email : email,
  ));
  print('Клиент обновлен');
}

void _deleteClient(ClientRepository repo) {
  final id = _readInput('ID клиента для удаления');
  repo.delete(id);
  print('Клиент удален');
}

void _listPositions(PositionRepository repo) {
  final positions = repo.getAll();
  if (positions.isEmpty) {
    print('Должностей нет.');
    return;
  }
  print('\n--- ДОЛЖНОСТИ ---');
  for (var p in positions) {
    print('ID: ${p.id} | ${p.title} | Оклад: ${p.salary} руб.');
  }
}

void _addPosition(PositionRepository repo) {
  print('\n--- ДОБАВЛЕНИЕ ДОЛЖНОСТИ ---');
  final id = _readInput('ID должности');
  final title = _readInput('Название должности');
  final salary = double.tryParse(_readInput('Оклад')) ?? 0;
  final description = _readInput('Описание');
  
  repo.insert(Position(
    id: id,
    title: title,
    salary: salary,
    description: description,
  ));
  print('Должность добавлена');
}

void _updatePosition(PositionRepository repo) {
  final id = _readInput('ID должности для обновления');
  final existing = repo.getById(id);
  if (existing == null) {
    print('Должность не найдена');
    return;
  }
  
  print('\n--- ОБНОВЛЕНИЕ ДОЛЖНОСТИ ---');
  final title = _readInput('Название (${existing.title})');
  final salaryStr = _readInput('Оклад (${existing.salary})');
  final description = _readInput('Описание (${existing.description})');
  
  repo.update(Position(
    id: id,
    title: title.isEmpty ? existing.title : title,
    salary: salaryStr.isEmpty ? existing.salary : double.parse(salaryStr),
    description: description.isEmpty ? existing.description : description,
  ));
  print('Должность обновлена');
}

void _deletePosition(PositionRepository repo) {
  final id = _readInput('ID должности для удаления');
  repo.delete(id);
  print('Должность удалена');
}

void _listEmployees(EmployeeRepository repo) {
  final employees = repo.getAll();
  if (employees.isEmpty) {
    print('Сотрудников нет.');
    return;
  }
  print('\n--- СОТРУДНИКИ ---');
  for (var e in employees) {
    print('ID: ${e.id} | ${e.fullName} | Должность: ${e.position?.title ?? e.positionId} | ${e.phone}');
  }
}

void _addEmployee(EmployeeRepository empRepo, PositionRepository posRepo) {
  final positions = posRepo.getAll();
  if (positions.isEmpty) {
    print('Сначала добавьте должность!');
    return;
  }
  
  print('\n--- ДОБАВЛЕНИЕ СОТРУДНИКА ---');
  final id = _readInput('ID сотрудника');
  final fullName = _readInput('ФИО');
  
  print('\nДоступные должности:');
  for (var i = 0; i < positions.length; i++) {
    print('${i + 1}. ${positions[i].title}');
  }
  final posIndex = int.tryParse(_readInput('Выберите должность (номер)')) ?? 1;
  final positionId = positions[posIndex - 1].id;
  
  final phone = _readInput('Телефон');
  final hireDateStr = _readInput('Дата найма (ГГГГ-ММ-ДД)');
  final hireDate = DateTime.parse(hireDateStr);
  
  empRepo.insert(Employee(
    id: id,
    fullName: fullName,
    positionId: positionId,
    phone: phone,
    hireDate: hireDate,
  ));
  print('Сотрудник добавлен');
}

void _updateEmployee(EmployeeRepository repo) {
  final id = _readInput('ID сотрудника для обновления');
  final existing = repo.getById(id);
  if (existing == null) {
    print('Сотрудник не найден');
    return;
  }
  
  print('\n--- ОБНОВЛЕНИЕ СОТРУДНИКА ---');
  final fullName = _readInput('ФИО (${existing.fullName})');
  final phone = _readInput('Телефон (${existing.phone})');
  
  repo.update(Employee(
    id: id,
    fullName: fullName.isEmpty ? existing.fullName : fullName,
    positionId: existing.positionId,
    phone: phone.isEmpty ? existing.phone : phone,
    hireDate: existing.hireDate,
  ));
  print('Сотрудник обновлен');
}

void _deleteEmployee(EmployeeRepository repo) {
  final id = _readInput('ID сотрудника для удаления');
  repo.delete(id);
  print('Сотрудник удален');
}

void _listServices(BankingServiceRepository repo) {
  final services = repo.getAll();
  if (services.isEmpty) {
    print('Услуг нет.');
    return;
  }
  print('\n--- БАНКОВСКИЕ УСЛУГИ ---');
  for (var s in services) {
    print('ID: ${s.id} | ${s.name} | Ставка: ${s.interestRate}% | Срок: ${s.minDurationMonths} мес.');
  }
}

void _addService(BankingServiceRepository repo) {
  print('\n--- ДОБАВЛЕНИЕ УСЛУГИ ---');
  final id = _readInput('ID услуги');
  final name = _readInput('Название услуги');
  final description = _readInput('Описание');
  final interestRate = double.tryParse(_readInput('Процентная ставка')) ?? 0;
  final minDuration = int.tryParse(_readInput('Минимальный срок (месяцы)')) ?? 0;
  
  repo.insert(BankingService(
    id: id,
    name: name,
    description: description,
    interestRate: interestRate,
    minDurationMonths: minDuration,
  ));
  print('Услуга добавлена');
}

void _updateService(BankingServiceRepository repo) {
  final id = _readInput('ID услуги для обновления');
  final existing = repo.getById(id);
  if (existing == null) {
    print('Услуга не найдена');
    return;
  }
  
  print('\n--- ОБНОВЛЕНИЕ УСЛУГИ ---');
  final name = _readInput('Название (${existing.name})');
  final description = _readInput('Описание (${existing.description})');
  final rateStr = _readInput('Ставка (${existing.interestRate})');
  
  repo.update(BankingService(
    id: id,
    name: name.isEmpty ? existing.name : name,
    description: description.isEmpty ? existing.description : description,
    interestRate: rateStr.isEmpty ? existing.interestRate : double.parse(rateStr),
    minDurationMonths: existing.minDurationMonths,
  ));
  print('Услуга обновлена');
}

void _deleteService(BankingServiceRepository repo) {
  final id = _readInput('ID услуги для удаления');
  repo.delete(id);
  print('✓ Услуга удалена');
}

void _listContracts(ContractRepository repo) {
  final contracts = repo.getAll();
  if (contracts.isEmpty) {
    print('Договоров нет.');
    return;
  }
  print('\n--- ДОГОВОРЫ ---');
  for (var c in contracts) {
    print('ID: ${c.id} | Клиент: ${c.client?.name ?? c.clientId} | Сумма: ${c.amount} руб. | Статус: ${c.status}');
  }
}

void _addContract(ContractRepository contractRepo, ClientRepository clientRepo, 
                   EmployeeRepository employeeRepo, BankingServiceRepository serviceRepo) {
  final clients = clientRepo.getAll();
  if (clients.isEmpty) {
    print('Сначала добавьте клиента!');
    return;
  }
  
  final employees = employeeRepo.getAll();
  if (employees.isEmpty) {
    print('Сначала добавьте сотрудника!');
    return;
  }
  
  final services = serviceRepo.getAll();
  if (services.isEmpty) {
    print('Сначала добавьте услугу!');
    return;
  }
  
  print('\n--- ДОБАВЛЕНИЕ ДОГОВОРА ---');
  final id = _readInput('ID договора');
  
  print('\nВыберите клиента:');
  for (var i = 0; i < clients.length; i++) {
    print('${i + 1}. ${clients[i].name}');
  }
  final clientIndex = int.tryParse(_readInput('Номер клиента')) ?? 1;
  final clientId = clients[clientIndex - 1].id;
  
  print('\nВыберите сотрудника:');
  for (var i = 0; i < employees.length; i++) {
    print('${i + 1}. ${employees[i].fullName}');
  }
  final empIndex = int.tryParse(_readInput('Номер сотрудника')) ?? 1;
  final employeeId = employees[empIndex - 1].id;
  
  print('\nВыберите услугу:');
  for (var i = 0; i < services.length; i++) {
    print('${i + 1}. ${services[i].name} (${services[i].interestRate}%)');
  }
  final serviceIndex = int.tryParse(_readInput('Номер услуги')) ?? 1;
  final serviceId = services[serviceIndex - 1].id;
  
  final amount = double.tryParse(_readInput('Сумма договора')) ?? 0;
  final startDateStr = _readInput('Дата начала (ГГГГ-ММ-ДД)');
  final startDate = DateTime.parse(startDateStr);
  final endDateStr = _readInput('Дата окончания (ГГГГ-ММ-ДД)');
  final endDate = DateTime.parse(endDateStr);
  
  print('\nВыберите статус:');
  print('1. активный');
  print('2. завершен');
  print('3. расторгнут');
  final statusChoice = _readInput('Номер статуса');
  final status = statusChoice == '1' ? 'active' : (statusChoice == '2' ? 'completed' : 'terminated');
  
  contractRepo.insert(Contract(
    id: id,
    clientId: clientId,
    employeeId: employeeId,
    serviceId: serviceId,
    amount: amount,
    startDate: startDate,
    endDate: endDate,
    status: status,
  ));
  print('Договор добавлен');
}

void _updateContract(ContractRepository repo) {
  final id = _readInput('ID договора для обновления');
  final existing = repo.getById(id);
  if (existing == null) {
    print('Договор не найден');
    return;
  }
  
  print('\n--- ОБНОВЛЕНИЕ СТАТУСА ДОГОВОРА ---');
  print('1. active (активный)');
  print('2. completed (завершен)');
  print('3. terminated (расторгнут)');
  final statusChoice = _readInput('Новый статус');
  final newStatus = statusChoice == '1' ? 'active' : (statusChoice == '2' ? 'completed' : 'terminated');
  
  repo.update(Contract(
    id: id,
    clientId: existing.clientId,
    employeeId: existing.employeeId,
    serviceId: existing.serviceId,
    amount: existing.amount,
    startDate: existing.startDate,
    endDate: existing.endDate,
    status: newStatus,
  ));
  print('Статус договора обновлен');
}

void _deleteContract(ContractRepository repo) {
  final id = _readInput('ID договора для удаления');
  repo.delete(id);
  print('Договор удален');
}

void _showAllFromDb(ClientRepository clientRepo, PositionRepository positionRepo,
                     EmployeeRepository employeeRepo, BankingServiceRepository serviceRepo,
                     ContractRepository contractRepo) {
  print('\n' + '=' * 50);
  print('=' * 50);
  
  _listClients(clientRepo);
  print('\n' + '-' * 30);
  _listPositions(positionRepo);
  print('\n' + '-' * 30);
  _listEmployees(employeeRepo);
  print('\n' + '-' * 30);
  _listServices(serviceRepo);
  print('\n' + '-' * 30);
  _listContracts(contractRepo);
  print('=' * 50);
}

String _readInput(String prompt) {
  stdout.write('$prompt: ');
  return stdin.readLineSync(encoding: utf8)?.trim() ?? '';
}


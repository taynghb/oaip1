import 'package:bank/bank_system.dart';

class ContractRepository {
  final BankDatabase _db;

  ContractRepository(this._db);

  void insert(Contract contract) {
    _db.db.execute(
      'INSERT OR REPLACE INTO contracts(id, clientId, employeeId, serviceId, amount, startDate, endDate, status) VALUES(?, ?, ?, ?, ?, ?, ?, ?)',
      [
        contract.id,
        contract.clientId,
        contract.employeeId,
        contract.serviceId,
        contract.amount,
        contract.startDate.toIso8601String(),
        contract.endDate.toIso8601String(),
        contract.status,
      ],
    );
  }

  List<Contract> getAll() {
    final rows = _db.db.select('''
      SELECT c.id, c.clientId, c.employeeId, c.serviceId, c.amount, c.startDate, c.endDate, c.status,
             cl.id as cl_id, cl.name, cl.phone, cl.email,
             e.id as e_id, e.fullName, e.positionId, e.phone as e_phone, e.hireDate,
             s.id as s_id, s.name as s_name, s.description as s_desc, s.interestRate, s.minDurationMonths
      FROM contracts c
      LEFT JOIN clients cl ON c.clientId = cl.id
      LEFT JOIN employees e ON c.employeeId = e.id
      LEFT JOIN services s ON c.serviceId = s.id
      ORDER BY c.startDate DESC
    ''');
    
    return rows.map((row) {
      final contract = Contract.fromMap(row);
      
      if (row['cl_id'] != null) {
        contract.client = Client(
          id: row['cl_id'] as String,
          name: row['name'] as String,
          phone: row['phone'] as String,
          email: row['email'] as String,
        );
      }
      
      if (row['e_id'] != null) {
        contract.employee = Employee(
          id: row['e_id'] as String,
          fullName: row['fullName'] as String,
          positionId: row['positionId'] as String,
          phone: row['e_phone'] as String,
          hireDate: DateTime.parse(row['hireDate'] as String),
        );
      }
      
      if (row['s_id'] != null) {
        contract.service = BankingService(
          id: row['s_id'] as String,
          name: row['s_name'] as String,
          description: row['s_desc'] as String,
          interestRate: row['interestRate'] as double,
          minDurationMonths: row['minDurationMonths'] as int,
        );
      }
      
      return contract;
    }).toList();
  }

  Contract? getById(String id) {
    final rows = _db.db.select('''
      SELECT c.id, c.clientId, c.employeeId, c.serviceId, c.amount, c.startDate, c.endDate, c.status,
             cl.id as cl_id, cl.name, cl.passport, cl.phone, cl.email,
             e.id as e_id, e.fullName, e.positionId, e.phone as e_phone, e.hireDate,
             s.id as s_id, s.name as s_name, s.description as s_desc, s.interestRate, s.minDurationMonths
      FROM contracts c
      LEFT JOIN clients cl ON c.clientId = cl.id
      LEFT JOIN employees e ON c.employeeId = e.id
      LEFT JOIN services s ON c.serviceId = s.id
      WHERE c.id=?
    ''', [id]);
    
    if (rows.isEmpty) return null;
    
    final contract = Contract.fromMap(rows.first);
    final row = rows.first;
    
    if (row['cl_id'] != null) {
      contract.client = Client(
        id: row['cl_id'] as String,
        name: row['name'] as String,
        phone: row['phone'] as String,
        email: row['email'] as String,
      );
    }
    
    if (row['e_id'] != null) {
      contract.employee = Employee(
        id: row['e_id'] as String,
        fullName: row['fullName'] as String,
        positionId: row['positionId'] as String,
        phone: row['e_phone'] as String,
        hireDate: DateTime.parse(row['hireDate'] as String),
      );
    }
    
    if (row['s_id'] != null) {
      contract.service = BankingService(
        id: row['s_id'] as String,
        name: row['s_name'] as String,
        description: row['s_desc'] as String,
        interestRate: row['interestRate'] as double,
        minDurationMonths: row['minDurationMonths'] as int,
      );
    }
    
    return contract;
  }

  void update(Contract contract) {
    _db.db.execute(
      'UPDATE contracts SET clientId=?, employeeId=?, serviceId=?, amount=?, startDate=?, endDate=?, status=? WHERE id=?',
      [
        contract.clientId,
        contract.employeeId,
        contract.serviceId,
        contract.amount,
        contract.startDate.toIso8601String(),
        contract.endDate.toIso8601String(),
        contract.status,
        contract.id,
      ],
    );
  }

  void delete(String id) {
    _db.db.execute('DELETE FROM contracts WHERE id=?', [id]);
  }

  List<Contract> getByClient(String clientId) {
    final rows = _db.db.select(
      'SELECT id, clientId, employeeId, serviceId, amount, startDate, endDate, status FROM contracts WHERE clientId=?',
      [clientId],
    );
    return rows.map((row) => Contract.fromMap(row)).toList();
  }

  double getTotalAmount() {
    final result = _db.db.select('SELECT SUM(amount) as total FROM contracts WHERE status="active"');
    return result.first['total'] as double? ?? 0.0;
  }
}
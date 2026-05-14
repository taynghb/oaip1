import 'package:bank/bank_system.dart';

class EmployeeRepository {
  final BankDatabase _db;

  EmployeeRepository(this._db);

  void insert(Employee employee) {
    _db.db.execute(
      'INSERT OR REPLACE INTO employees(id, fullName, positionId, phone, hireDate) VALUES(?, ?, ?, ?, ?)',
      [employee.id, employee.fullName, employee.positionId, employee.phone, employee.hireDate.toIso8601String()],
    );
  }

  List<Employee> getAll() {
    final rows = _db.db.select('''
      SELECT e.id, e.fullName, e.positionId, e.phone, e.hireDate,
             p.id as p_id, p.title, p.salary, p.description
      FROM employees e
      LEFT JOIN positions p ON e.positionId = p.id
      ORDER BY e.fullName
    ''');
    
    return rows.map((row) {
      final employee = Employee.fromMap(row);
      if (row['p_id'] != null) {
        employee.position = Position(
          id: row['p_id'] as String,
          title: row['title'] as String,
          salary: row['salary'] as double,
          description: row['description'] as String,
        );
      }
      return employee;
    }).toList();
  }

  Employee? getById(String id) {
    final rows = _db.db.select('''
      SELECT e.id, e.fullName, e.positionId, e.phone, e.hireDate,
             p.id as p_id, p.title, p.salary, p.description
      FROM employees e
      LEFT JOIN positions p ON e.positionId = p.id
      WHERE e.id=?
    ''', [id]);
    
    if (rows.isEmpty) return null;
    
    final employee = Employee.fromMap(rows.first);
    if (rows.first['p_id'] != null) {
      employee.position = Position(
        id: rows.first['p_id'] as String,
        title: rows.first['title'] as String,
        salary: rows.first['salary'] as double,
        description: rows.first['description'] as String,
      );
    }
    return employee;
  }

  void update(Employee employee) {
    _db.db.execute(
      'UPDATE employees SET fullName=?, positionId=?, phone=?, hireDate=? WHERE id=?',
      [employee.fullName, employee.positionId, employee.phone, employee.hireDate.toIso8601String(), employee.id],
    );
  }

  void delete(String id) {
    _db.db.execute('DELETE FROM employees WHERE id=?', [id]);
  }

  List<Employee> getByPosition(String positionId) {
    final rows = _db.db.select(
      'SELECT id, fullName, positionId, phone, hireDate FROM employees WHERE positionId=?',
      [positionId],
    );
    return rows.map((row) => Employee.fromMap(row)).toList();
  }
}
import 'package:bank/bank_system.dart';

class BankingServiceRepository {
  final BankDatabase _db;

  BankingServiceRepository(this._db);

  void insert(BankingService service) {
    _db.db.execute(
      'INSERT OR REPLACE INTO services(id, name, description, interestRate, minDurationMonths) VALUES(?, ?, ?, ?, ?)',
      [service.id, service.name, service.description, service.interestRate, service.minDurationMonths],
    );
  }

  List<BankingService> getAll() {
    final rows = _db.db.select('SELECT id, name, description, interestRate, minDurationMonths FROM services ORDER BY name');
    return rows.map((row) => BankingService.fromMap(row)).toList();
  }

  BankingService? getById(String id) {
    final rows = _db.db.select('SELECT id, name, description, interestRate, minDurationMonths FROM services WHERE id=?', [id]);
    return rows.isNotEmpty ? BankingService.fromMap(rows.first) : null;
  }

  void update(BankingService service) {
    _db.db.execute(
      'UPDATE services SET name=?, description=?, interestRate=?, minDurationMonths=? WHERE id=?',
      [service.name, service.description, service.interestRate, service.minDurationMonths, service.id],
    );
  }

  void delete(String id) {
    _db.db.execute('DELETE FROM services WHERE id=?', [id]);
  }

  BankingService? getByName(String name) {
    final rows = _db.db.select('SELECT id, name, description, interestRate, minDurationMonths FROM services WHERE name=?', [name]);
    return rows.isNotEmpty ? BankingService.fromMap(rows.first) : null;
  }
}
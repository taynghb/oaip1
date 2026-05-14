import 'package:bank/src/domain/client.dart';
import 'package:bank/bank_system.dart';

class ClientRepository {
  final BankDatabase _db;

  ClientRepository(this._db);

  void insert(Client client) {
    _db.db.execute(
      'INSERT OR REPLACE INTO clients(id, name, phone, email) VALUES(?,?, ?, ?)',
      [client.id, client.name, client.phone, client.email],
    );
  }

  List<Client> getAll() {
    final rows = _db.db.select('SELECT id, name, phone, email FROM clients ORDER BY name');
    return rows.map((row) => Client.fromMap(row)).toList();
  }

  Client? getById(String id) {
    final rows = _db.db.select('SELECT id, name, phone, email FROM clients WHERE id=?', [id]);
    return rows.isNotEmpty ? Client.fromMap(rows.first) : null;
  }

  void update(Client client) {
    _db.db.execute(
      'UPDATE clients SET name=?, phone=?, email=? WHERE id=?',
      [client.name, client.phone, client.email, client.id],
    );
  }

  void delete(String id) {
    _db.db.execute('DELETE FROM clients WHERE id=?', [id]);
  }

  List<Client> searchByName(String name) {
    final rows = _db.db.select(
      'SELECT id, name, phone, email FROM clients WHERE name LIKE ?',
      ['%$name%'],
    );
    return rows.map((row) => Client.fromMap(row)).toList();
  }

  int getCount() {
    final result = _db.db.select('SELECT COUNT(*) as count FROM clients');
    return result.first['count'] as int;
  }
}
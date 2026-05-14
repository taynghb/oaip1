import 'package:bank/bank_system.dart';

class PositionRepository {
  final BankDatabase _db;

  PositionRepository(this._db);

  void insert(Position position) {
    _db.db.execute(
      'INSERT OR REPLACE INTO positions(id, title, salary, description) VALUES(?, ?, ?, ?)',
      [position.id, position.title, position.salary, position.description],
    );
  }

  List<Position> getAll() {
    final rows = _db.db.select('SELECT id, title, salary, description FROM positions ORDER BY title');
    return rows.map((row) => Position.fromMap(row)).toList();
  }

  Position? getById(String id) {
    final rows = _db.db.select('SELECT id, title, salary, description FROM positions WHERE id=?', [id]);
    return rows.isNotEmpty ? Position.fromMap(rows.first) : null;
  }

  void update(Position position) {
    _db.db.execute(
      'UPDATE positions SET title=?, salary=?, description=? WHERE id=?',
      [position.title, position.salary, position.description, position.id],
    );
  }

  void delete(String id) {
    _db.db.execute('DELETE FROM positions WHERE id=?', [id]);
  }

  Position? getByTitle(String title) {
    final rows = _db.db.select('SELECT id, title, salary, description FROM positions WHERE title=?', [title]);
    return rows.isNotEmpty ? Position.fromMap(rows.first) : null;
  }
}
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

class BankDatabase {
  final Database _sqlite;

  BankDatabase(String filePath) : _sqlite = sqlite3.open(filePath) {
    _createTables();
  }

  factory BankDatabase.inApp() {
    final filePath = p.join(Directory.current.path, 'bank.db');
    return BankDatabase(filePath);
  }

  void _createTables() {
    // Таблица клиентов
    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS clients (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS positions (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL UNIQUE,
        salary REAL NOT NULL,
        description TEXT
      )
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS employees (
        id TEXT PRIMARY KEY,
        fullName TEXT NOT NULL,
        positionId TEXT NOT NULL,
        phone TEXT NOT NULL,
        hireDate TEXT NOT NULL,
        FOREIGN KEY (positionId) REFERENCES positions(id) ON DELETE RESTRICT
      )
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS services (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        description TEXT,
        interestRate REAL NOT NULL,
        minDurationMonths INTEGER NOT NULL
      )
    ''');

    _sqlite.execute('''
      CREATE TABLE IF NOT EXISTS contracts (
        id TEXT PRIMARY KEY,
        clientId TEXT NOT NULL,
        employeeId TEXT NOT NULL,
        serviceId TEXT NOT NULL,
        amount REAL NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (clientId) REFERENCES clients(id) ON DELETE RESTRICT,
        FOREIGN KEY (employeeId) REFERENCES employees(id) ON DELETE RESTRICT,
        FOREIGN KEY (serviceId) REFERENCES services(id) ON DELETE RESTRICT
      )
    ''');
  }

  Database get db => _sqlite;

  void close() {
    _sqlite.dispose();
  }
}
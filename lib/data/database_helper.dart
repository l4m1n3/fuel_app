import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '/models/fuel_card.dart';
import '/models/transaction.dart';
import '/models/station.dart';
import '/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('fuel_app.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 4, // Version mise à jour pour inclure password
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE fuel_cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardNumber TEXT NOT NULL,
        balance REAL NOT NULL,
        userId INTEGER NOT NULL,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fuelCardId INTEGER NOT NULL,
        stationName TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        status TEXT,
        fuelType TEXT,
        FOREIGN KEY (fuelCardId) REFERENCES fuel_cards(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE stations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        fuelTypes TEXT NOT NULL
      )
    ''');

    // Données initiales
    await db.insert('users', {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'password': sha256.convert(utf8.encode('password123')).toString(),
    });

    await db.insert('fuel_cards', {
      'cardNumber': '1234 5678 9012 3456',
      'balance': 50000.0,
      'userId': 1,
    });
    await db.insert('fuel_cards', {
      'cardNumber': '9876 5432 1098 7654',
      'balance': 75000.0,
      'userId': 1,
    });

    await db.insert('transactions', {
      'fuelCardId': 1,
      'stationName': 'Station Total',
      'amount': -15000.0,
      'date': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      'status': 'Terminé',
      'fuelType': 'Essence',
    });
    await db.insert('transactions', {
      'fuelCardId': 1,
      'stationName': 'Station Shell',
      'amount': -20000.0,
      'date': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      'status': 'Terminé',
      'fuelType': 'Diesel',
    });

    await db.insert('stations', {
      'name': 'Station Total',
      'address': '123 Avenue de la Liberté, Abidjan',
      'latitude': 5.359951,
      'longitude': -4.008256,
      'fuelTypes': 'Essence,Diesel',
    });
    await db.insert('stations', {
      'name': 'Station Shell',
      'address': '456 Boulevard des Martyrs, Abidjan',
      'latitude': 5.360000,
      'longitude': -4.010000,
      'fuelTypes': 'Essence',
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE transactions ADD COLUMN fuelType TEXT');
      await db.execute('''
        CREATE TABLE stations (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          address TEXT NOT NULL,
          latitude REAL NOT NULL,
          longitude REAL NOT NULL,
          fuelTypes TEXT NOT NULL
        )
      ''');

      await db.insert('stations', {
        'name': 'Station Total',
        'address': '123 Avenue de la Liberté, Abidjan',
        'latitude': 5.359951,
        'longitude': -4.008256,
        'fuelTypes': 'Essence,Diesel',
      });
      await db.insert('stations', {
        'name': 'Station Shell',
        'address': '456 Boulevard des Martyrs, Abidjan',
        'latitude': 5.360000,
        'longitude': -4.010000,
        'fuelTypes': 'Essence',
      });
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT
        )
      ''');

      await db.insert('users', {
        'name': 'John Doe',
        'email': 'john.doe@example.com',
        'password': sha256.convert(utf8.encode('password123')).toString(),
      });

      await db.update(
        'fuel_cards',
        {'userId': 1},
        where: 'userId IS NULL OR userId = 0',
      );
    }

    if (oldVersion < 4) {
      await db.execute('ALTER TABLE users ADD COLUMN password TEXT');
      await db.execute('UPDATE users SET password = ?', [sha256.convert(utf8.encode('password123')).toString()]);
      await db.execute('ALTER TABLE users ADD CONSTRAINT email_unique UNIQUE (email)');
    }
  }

  Future<User?> getUser(int userId) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> registerUser(String name, String email, String password) async {
    final db = await database;
    try {
      await db.insert('users', {
        'name': name,
        'email': email,
        'password': sha256.convert(utf8.encode(password)).toString(),
      });
      return true;
    } catch (e) {
      return false; // Email déjà utilisé ou autre erreur
    }
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, sha256.convert(utf8.encode(password)).toString()],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<FuelCard>> getFuelCards() async {
    final db = await database;
    final maps = await db.query('fuel_cards');
    return List.generate(maps.length, (i) {
      return FuelCard(
        id: maps[i]['id'] as int,
        cardNumber: maps[i]['cardNumber'] as String,
        balance: maps[i]['balance'] as double,
        userId: maps[i]['userId'] as int,
      );
    });
  }

  Future<List<Transaction>> getTransactions(int fuelCardId) async {
    final db = await database;
    final maps = await db.query(
      'transactions',
      where: 'fuelCardId = ?',
      whereArgs: [fuelCardId],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaction(
        id: maps[i]['id'] as int,
        fuelCardId: maps[i]['fuelCardId'] as int,
        stationName: maps[i]['stationName'] as String,
        amount: maps[i]['amount'] as double,
        date: maps[i]['date'] as String,
        status: maps[i]['status'] as String?,
        fuelType: maps[i]['fuelType'] as String?,
      );
    });
  }

  Future<List<Station>> getStations() async {
    final db = await database;
    final maps = await db.query('stations');
    return List.generate(maps.length, (i) {
      return Station.fromMap(maps[i]);
    });
  }

  Future<void> updateFuelCard(FuelCard card) async {
    final db = await database;
    await db.update(
      'fuel_cards',
      {
        'cardNumber': card.cardNumber,
        'balance': card.balance,
        'userId': card.userId,
      },
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<void> insertTransaction(Transaction transaction) async {
    final db = await database;
    await db.insert('transactions', {
      'fuelCardId': transaction.fuelCardId,
      'stationName': transaction.stationName,
      'amount': transaction.amount,
      'date': transaction.date,
      'status': transaction.status,
      'fuelType': transaction.fuelType,
    });
  }

  Future<void> insertStation(Station station) async {
    final db = await database;
    await db.insert('stations', station.toMap());
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
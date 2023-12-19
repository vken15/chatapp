import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDataBase {
  static const DB_NAME = "ChatAppDB.db";
  static const DB_VERSION = 1;

  static final LocalDataBase _singleton = LocalDataBase._();
  static LocalDataBase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;
  LocalDataBase._();

  Future<Database?> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
    
      _openDataBase();
    }
    return _dbOpenCompleter?.future;
  }

  Future _openDataBase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, DB_NAME);
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter?.complete(database);
  }
}
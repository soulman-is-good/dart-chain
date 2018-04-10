import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Database {
  String dbPath;
  Database db = null;

  Database(this.dbPath);
  
  Future<Database> open() {
    return ioDatabaseFactory.openDatabase(dbPath)
      .then((Database dbInstance) {
        this.db = dbInstance;

        return dbInstance;
      });
  }
  
  Future put(dynamic value, String key) {
    open()
      .then((Database db) {
        Future putOp = db.put(value, key);
        
        return putOp;
      })
      .whenComplete(() {
        db.close();
      });
  }
}
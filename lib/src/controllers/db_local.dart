import 'package:agendamiento_canchas/src/models/agendamiento..dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class ClientDatabaseProvider {
  ClientDatabaseProvider._();

  static final ClientDatabaseProvider db = ClientDatabaseProvider._();
  Database _database;

  //para evitar que abra varias conexciones una y otra vez podemos usar algo como esto..
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstanace();
    return _database;
  }

  Future<Database> getDatabaseInstanace() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "client.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Agendamiento ("
          "id integer primary key,"
          "nombrecancha String,"
          "nombrepersona String,"
          "fecha String"
          ")");
    });
  }

  Future<List<Agendamiento>> getAllReservas() async {
    final db = await database;
    var response = await db.query("Agendamiento", orderBy: "fecha");
    List<Agendamiento> list =
        response.map((c) => Agendamiento.fromMap(c)).toList();
    return list;
  }

  addElement(Agendamiento producto) async {
    print(producto);
    final db = await database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Agendamiento");
    int id = table.first["id"];
    producto.id = id;
    var raw = await db.insert(
      "Agendamiento",
      producto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Agendamiento Agregado: " + raw.toString());
    return raw;
  }

  Future<bool> getValueElements(String nombrecancha, String fecha) async {
    print(nombrecancha);
    bool value;

    final db = await database;
    List res = await db.rawQuery(
        'SELECT * FROM Agendamiento WHERE fecha=? and nombrecancha=? ',
        [fecha, nombrecancha]);

    value = false;
    if (res.length == 3) {
    } else {
      value = true;
    }
    print("BANDERA EVALUADA: " + value.toString());
    return value;
  }

  deleteReserva(int id) async {
    final db = await database;
    return db.delete("Agendamiento", where: "id = ?", whereArgs: [id]);
  }
}

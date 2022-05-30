import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modelClass/employeeModel.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  static const table = 'employee';
  static const colId = 'id';
  static const colName = 'name';
  static const colLastName = 'lastName';
  static const colDesignation = 'designation';
  static const colCompanyName = 'companyName';
  static const colTwitterId = 'twitterId';
  static const colWhatsAppNumber = 'whatsAppNumber';
  //static const colImage = 'image';

  Database? db;

  Future<Database?> initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'student.db');

   if(db != null) {
     return db;
   }
   else{
     db = await openDatabase(
       path,
       version: 1,
       onCreate: (Database db, int version) {
         String query =
             "CREATE TABLE IF NOT EXISTS $table($colId INTEGER PRIMARY KEY AUTOINCREMENT , $colName TEXT , $colLastName TEXT , $colDesignation TEXT, $colCompanyName TEXT,$colTwitterId TEXT,$colWhatsAppNumber TEXT)";
         return db.execute(query);
       },
     );
    return db;
   }
  }

  Future<int> insert (Employee data) async {
    db = await initDB();

    String query = "INSERT INTO $table($colName, $colLastName , $colDesignation,$colCompanyName,$colTwitterId,$colWhatsAppNumber) VALUES(?, ?, ?,?,?,?)";

    List args = [
      data.name,
      data.lastName,
      data.designation,
      data.companyName,
      data.twitterId,
      data.whatsAppNumber
      // data.image,
    ];
    return await db!.rawInsert(query , args);
  }

  Future<List<Employee>> fetchAllData() async {
    db = await initDB();

    String query = "SELECT * FROM $table";

    List response = await db!.rawQuery(query);
    return response.map((e) => Employee.formSql(e)).toList();

  }

  Future<int> delete(int? id) async {
    await initDB();

    String query = "DELETE FROM $table WHERE id = ?";
    List args = [id];
    return await db!.rawDelete(query,args);
  }

  Future<int> update(Employee s, int? id) async {
    db = await initDB();

    String query = "UPDATE $table SET name = ?, city = ?, age = ?WHERE id = ?";
    List args = [s.name, s.lastName, s.designation,s.companyName,s.twitterId,s.whatsAppNumber,id];

    return await db!.rawUpdate(query,args);
  }

  Future<List<Employee>> fetchSearchedData (String val) async {
    db = await initDB();

    String query = "SELECT * FROM $table WHERE name LIKE '%$val%'";

    List response = await db!.rawQuery(query);
    return response.map((e) => Employee.formSql(e)).toList();
  }
}

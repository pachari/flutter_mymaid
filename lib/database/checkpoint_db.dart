import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../services/checkpoint_service.dart';

// สร้าง class จัดการข้อมูล
class CheckpointDatabase {
  // กำหนดตัวแปรสำหรับอ้างอิงฐานข้อมูล
  static final CheckpointDatabase instance = CheckpointDatabase._init();

  // กำหนดตัวแปรฐานข้อมูล
  static Database? _database;

  CheckpointDatabase._init();

  Future<Database> get database async {
    // ถ้ามีฐานข้อมูลนี้แล้วคืนค่า
    if (_database != null) return _database!;
    // ถ้ายังไม่มี สร้างฐานข้อมูล กำหนดชื่อ นามสกุล .db
    _database = await _initDB('checkpoint.db');
    // คืนค่าฐานข้อมูล
    return _database!;
  }

  // ฟังก์ชั่นสร้างฐานข้อมูล รับชื่อไฟล์ที่กำหนดเข้ามา
  Future<Database> _initDB(String filePath) async {
    // หาตำแหน่งที่จะจัดเก็บในระบบ ที่เตรียมไว้ให้
    final dbPath = await getDatabasesPath();
    // ต่อกับชื่อที่ส่งมา จะเป็น path เต็มของไฟล์
    final path = join(dbPath, filePath);
    // สร้างฐานข้อมูล และเปิดใช้งาน หากมีการแก้ไข ให้เปลี่ยนเลขเวอร์ชั่น เพิ่มขึ้นไปเรื่อยๆ
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // สร้างตาราง
  Future _createDB(Database db, int version) async {
    // รูปแบบข้อมูล sqlite ที่รองรับ
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    // ทำคำสั่งสร้างตาราง
    await db.execute('''
                      CREATE TABLE $tableCheckpoint (
                        ${CheckpointFields.id} $idType,
                        ${CheckpointFields.checkpointid} $integerType,
                        ${CheckpointFields.title} $textType,
                        ${CheckpointFields.subtitle} $textType,
                        ${CheckpointFields.status} $integerType,
                        ${CheckpointFields.active} $boolType,
                        ${CheckpointFields.typecheckpoint} $integerType
                       
                      )
                      ''');
  }
//  ${CheckpointFields.cdate} $textType
//                         ${CheckpointFields.cby} $textType
  // คำสั่งสำหรับเพิ่มข้อมูลใหม่ คืนค่าเป็น book object ที่เพิ่มไป
  Future<Checkpoint> create(Checkpoint check) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    final id = await db.insert(tableCheckpoint, check.toJson());
    return check.copy(id: id);
  }

  // คำสั่งสำหรับแสดงข้อมูลหนังสือตามค่า id ที่ส่งมา
  Future<Checkpoint> readBook(int id) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // ทำคำสั่งคิวรี่ข้อมูลตามเงื่อนไข
    final maps = await db.query(
      tableCheckpoint,
      columns: CheckpointFields.values,
      where: '${CheckpointFields.id} = ?',
      whereArgs: [id],
    );

    // ถ้ามีข้อมูล แสดงข้อมูลกลับออกไป
    if (maps.isNotEmpty) {
      return Checkpoint.fromJson(maps.first);
    } else {
      // ถ้าไม่มีแสดง error
      throw Exception('ID $id not found');
    }
  }

  // คำสั่งแสดงรายการหนึงสือทั้งหมด ต้องส่งกลับเป็น List
  Future<List<Checkpoint>> readAllBook() async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // กำหนดเงื่อนไขต่างๆ รองรับเงื่อนไขและรูปแบบของคำสั่ง sql ตัวอย่าง
    // ใช้แค่การจัดเรียงข้อมูล
    const orderBy = '${CheckpointFields.id} ASC';
    final result = await db.query(tableCheckpoint, orderBy: orderBy);

    // ข้อมูลในฐานข้อมูลปกติเป็น json string data เวลาสั่งค่ากลับต้องทำการ
    // แปลงข้อมูล จาก json ไปเป็น object กรณีแสดงหลายรายการก็ทำเป็น List
    return result.map((json) => Checkpoint.fromJson(json)).toList();
  }

  // คำสังสำหรับอัพเดทข้อมููล ส่ง book object ที่จะอัพเดทเข้ามา
  Future<int> update(Checkpoint check) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.update(
      tableCheckpoint,
      check.toJson(),
      where: '${CheckpointFields.id} = ?',
      whereArgs: [check.id],
    );
  }

  // คำสั่งสำหรับลบข้อมล รับค่า id ที่จะลบ
  Future<int> delete(int id) async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableCheckpoint,
      where: '${CheckpointFields.id} = ?',
      whereArgs: [id],
    );
  }

  // คำสั่งสำหรับลบข้อมูลทั้งหมด
  Future<int> deleteAll() async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล
    // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
    return db.delete(
      tableCheckpoint,
    );
  }

  // คำสั่งสำหรับปิดฐานข้อมูล เท่าที่ลองใช้ เราไม่ควรปิด หรือใช้คำสั่งนี้
  // เหมือนจะเป็น bug เพราะถ้าปิดฐานข้อมูล จะอ้างอิงไม่ค่อยได้ ในตัวอย่าง
  // จะไม่ปิดหรือใช้คำสั่งนี้
  Future close() async {
    final db = await instance.database; // อ้างอิงฐานข้อมูล

    db.close();
  }
}

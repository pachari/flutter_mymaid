// กำหนดชื่อตารางไว้ในตัวแปร
const String tableTodolist = 'todolist';

// กำหนดฟิลด์ข้อมูลของตาราง
class TodolistFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [
    id,
    checkpointid,
    todolistid,
    title,
    subtitle,
    status,
    active,
  ];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String id = '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String todolistid = 'todolistid';
  static const String checkpointid = 'checkpointid';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String status = 'status';
  static const String active = 'active';
}

// ส่วนของ Data Model ของหนังสือ
class Todolist {
  final int? id; // จะใช้ค่าจากที่ gen ในฐานข้อมูล
  final int todolistid;
  final int checkpointid;
  final String title;
  final String subtitle;
  final int status;
   final bool active;

  // constructor
  const Todolist({
    this.id,
    required this.todolistid,
    required this.checkpointid,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.active,
  });


  // ฟังก์ชั่นสำหรับ สร้างข้อมูลใหม่ โดยรองรับแก้ไขเฉพาะฟิลด์ที่ต้องการ
  Todolist copy({
    int? id, // จะใช้ค่าจากที่ gen ในฐานข้อมูล
    int? todolistid,
    int? checkpointid,
    String? title,
    String? subtitle,
    int? status,
    bool? active,
  }) =>
      Todolist(
        id: id ?? this.id,
        todolistid: todolistid ?? this.todolistid,
        checkpointid: checkpointid ?? this.checkpointid,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        status: status ?? this.status,
        active: active ?? this.active,
      );

  // สำหรับแปลงข้อมูลจาก Json เป็น Book object
  static Todolist fromJson(Map<String, Object?> json) => Todolist(
        id: json[TodolistFields.id] as int?,
        todolistid: json[TodolistFields.todolistid] as int,
        checkpointid: json[TodolistFields.checkpointid] as int,
        title: json[TodolistFields.title] as String,
        subtitle: json[TodolistFields.subtitle] as String,
        status: json[TodolistFields.status] as int,
        active: json[TodolistFields.active] == 1,
      );

  // สำหรับแปลง Book object เป็น Json บันทึกลงฐานข้อมูล
  Map<String, Object?> toJson() => {
        TodolistFields.id: id,
        TodolistFields.todolistid: todolistid,
        TodolistFields.checkpointid: checkpointid,
        TodolistFields.title: title,
        TodolistFields.subtitle: subtitle,
        TodolistFields.status: status,
        TodolistFields.active: active ? 1 : 0,
      };
}

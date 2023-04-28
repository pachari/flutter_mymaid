// กำหนดชื่อตารางไว้ในตัวแปร
const String tableCheckpoint = 'checkpoint';

// กำหนดฟิลด์ข้อมูลของตาราง
class CheckpointFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [
    id,
    checkpointid,
    title,
    subtitle,
    status,
    active,
    typecheckpoint
    // cdate,
    // cby
  ];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String id = '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String checkpointid = 'checkpointid';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String status = 'status';
  static const String active = 'active';
  static const String typecheckpoint = 'typecheckpoint';
  // static const String cdate = 'cdate';
  // static const String cby = 'cby';
}

// ส่วนของ Data Model ของหนังสือ
class Checkpoint {
  final int? id; // จะใช้ค่าจากที่ gen ในฐานข้อมูล
  final int checkpointid;
  final String title;
  final String subtitle;
  final int status;
  final bool active;
  final int typecheckpoint;
  // final DateTime cdate;
  // final String cby;

  // constructor
  const Checkpoint(
      {this.id,
      required this.checkpointid,
      required this.title,
      required this.subtitle,
      required this.status,
      required this.active,
      required this.typecheckpoint
      // required this.cdate,
      // required this.cby
      });

  // ฟังก์ชั่นสำหรับ สร้างข้อมูลใหม่ โดยรองรับแก้ไขเฉพาะฟิลด์ที่ต้องการ
  Checkpoint copy(
          {int? id, // จะใช้ค่าจากที่ gen ในฐานข้อมูล
          int? checkpointid,
          String? title,
          String? subtitle,
          int? status,
          bool? active,
          int? typecheckpoint
          // DateTime? cdate,
          // String? cby
          }) =>
      Checkpoint(
          id: id ?? this.id,
          checkpointid: checkpointid ?? this.checkpointid,
          title: title ?? this.title,
          subtitle: subtitle ?? this.subtitle,
          status: status ?? this.status,
          active: active ?? this.active,
          typecheckpoint: typecheckpoint ?? this.typecheckpoint
          // cdate: cdate ?? this.cdate,
          // cby: cby ?? this.cby
          );

  // สำหรับแปลงข้อมูลจาก Json เป็น Book object
  static Checkpoint fromJson(Map<String, Object?> json) => Checkpoint(
      id: json[CheckpointFields.id] as int?,
      checkpointid: json[CheckpointFields.checkpointid] as int,
      title: json[CheckpointFields.title] as String,
      subtitle: json[CheckpointFields.subtitle] as String,
      status: json[CheckpointFields.status] as int,
      active: json[CheckpointFields.active] == 1,
      typecheckpoint: json[CheckpointFields.typecheckpoint] as int
      // cdate: DateTime.parse(json[CheckpointFields.cdate] as String),
      // cby: json[CheckpointFields.cby] as String
      );

  // สำหรับแปลง Book object เป็น Json บันทึกลงฐานข้อมูล
  Map<String, Object?> toJson() => {
        CheckpointFields.id: id,
        CheckpointFields.checkpointid: checkpointid,
        CheckpointFields.title: title,
        CheckpointFields.subtitle: subtitle,
        CheckpointFields.status: status,
        CheckpointFields.active: active ? 1 : 0,
        CheckpointFields.typecheckpoint: typecheckpoint
        // CheckpointFields.cdate: cdate.toIso8601String(),
        // CheckpointFields.cby: cby
      };
}

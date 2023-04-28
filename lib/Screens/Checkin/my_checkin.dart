import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mymaid/componants/background.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter_mymaid/database/checkpoint_db.dart';
import 'package:flutter_mymaid/services/checkpoint_service.dart';
import 'package:flutter_mymaid/Screens/Menu/appbar.dart';
import 'package:flutter_mymaid/constants.dart';

// import '../Qrcode/qrview.dart';
import '../todos_page/page_todo.dart';
// import 'package:flutter_mymaid/Screens/Checkin/components/my_checkin_view.dart';

class Mycheck extends StatefulWidget {
  static const routeName = '/checkpoint';

  const Mycheck({Key? key}) : super(key: key);

  @override
  State<Mycheck> createState() => _MycheckState();
}

// final titles = ["จุดที่ 1", "จุดที่ 2", "จุดที่ 3", "จุดที่ 4"];
// final subtitles = [
//   "อาคารสำนักงาน",
//   "อาคารโรงผลิตที่ 1",
//   "อาคารโรงผลิตที่ 2",
//   "อาคารโรงผลิตที่ 3"
// ];
// final icons = [
//   Icons.ac_unit,
//   Icons.access_alarm,
//   Icons.access_time,
//   Icons.access_time
// ];

class _MycheckState extends State<Mycheck> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  late CheckpointDatabase _db; // อ้างอิงฐานข้อมูล
  late Future<List<Checkpoint>> checkpoints; // ลิสรายการหนังสือ
  int i = 0; // จำลองตัวเลขการเพิ่่มจำนวน
  late DateFormat dateFormat; // รูปแบบการจัดการวันที่และเวลา

  @override
  void initState() {
    // กำหนดรูปแบบการจัดการวันที่และเวลา มีเพิ่มเติมเล็กน้อยในในท้ายบทความ
    Intl.defaultLocale = 'th';
    initializeDateFormatting();
    // dateFormat = DateFormat.yMMMMEEEEd('th');
    dateFormat = DateFormat.yMMMd('th');

    // อ้างอิงฐานข้อมูล
    _db = CheckpointDatabase.instance;
    checkpoints = _db.readAllBook(); // แสดงรายการหนังสือ
    super.initState();
  }

  // คำสั่งลบรายการทั้งหมด
  Future<void> clearBook() async {
    await _db.deleteAll(); // ทำคำสั่งลบข้อมูลทั้งหมด
    setState(() {
      checkpoints = _db.readAllBook(); // แสดงรายการหนังสือ
    });
  }

  // คำสั่งลบเฉพาะรายการที่กำหนดด้วย id ที่ต้องการ
  Future<void> deleteBook(int id) async {
    await _db.delete(id); // ทำคำสั่งลบข้มูลตามเงื่อนไข id
    setState(() {
      checkpoints = _db.readAllBook(); // แสดงรายการหนังสือ
    });
  }

  // จำลองทำคำสั่งแก้ไขรายการ
  // Future<void> editBook(Checkpoint check) async {
  //   // เลื่อกเปลี่ยนเฉพาะส่วนที่ต้องการ โดยใช้คำสั่ง copy
  //   check = check.copy(
  //       title: '${check.title} new ',
  //       price: 30.00,
  //       in_stock: true,
  //       num_pages: 300,
  //       publication_date: DateTime.now());
  //   await _db.update(check); // ทำคำสั่งอัพเดทข้อมูล
  //   setState(() {
  //     checkpoints = _db.readAllBook(); // แสดงรายการหนังสือ
  //   });
  // }

  // จำลองทำคำสั่งเพิ่มข้อมูลใหม่
  Future<void> newBook() async {
    i++;
    Checkpoint check = Checkpoint(
        checkpointid: i,
        title: 'จุดที่ 9', //'อาคารสำนักงาน $i',
        subtitle: 'อาคารโรงผลิต 8', //'อาคารโรงผลิต 3อาคารสำนักงาน $i',
        status: 2,
        active: true,
        typecheckpoint: 1 //typeid
        // cdate: DateTime.now(),
        // cby: 'pachari_pm@hotmail.com'
        ); //user?.email.toString()
    // ignore: non_constant_identifier_names, unused_local_variable
    Checkpoint new_book = await _db.create(check); // ทำคำสั่งเพิ่มข้อมูลใหม่
    setState(() {
      checkpoints = _db.readAllBook(); // แสดงรายการหนังสือ
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        // appBar: const BuildAppBar(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "Check List  (sqlite)",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: Background(
          child: SafeArea(
            child: TabBarView(
              children: choices.map((Choice choice) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      child: buildbody(context, checkpoints, choice.page),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => newBook(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

// สร้างฟังก์ชั่นจำลองการแสดงรายละเอียดข้อมูล
  Future<Widget?> _viewDetail(int id) async {
    Future<Checkpoint> check = _db.readBook(id); // ดึงข้อมูลจากฐานข้อมูลมาแสดง
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<Checkpoint>(
              future: check,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var check = snapshot.data!;
                  return Container(
                    height: 200,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('รายละเอียด จุดเช็คอิน',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text('ลำดับ: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('${check.id}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text('ชื่อ: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(check.title,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text('รายละเอียด: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(check.subtitle,
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        // Text('ราคา: ${check.status}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Text('สถานะ: ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(check.active ? 'เปิดใช้งาน' : 'ปืดใช้งาน',
                                style: const TextStyle(fontSize: 16)),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  // กรณี error
                  return Text('${snapshot.error}');
                }
                return const RefreshProgressIndicator();
              });
        });
    return null;
  }

// ListView buildbody(BuildContext context, label, page) {
//   return ListView.builder(
//     itemCount: page, //label.length,
//     itemBuilder: (context, index) {
//       return Card(
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//           side: BorderSide(
//             color: Theme.of(context).colorScheme.outline,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(10)),
//         ),
//         child: ListTile(
//           // title: Text(label[index] +" : " + subtitles[index],style: const TextStyle(fontWeight: FontWeight.w500),), //title: Text(label[index]),
//           title: Text(label[index]),
//           subtitle: Text(subtitles[index]),
//           // leading: const FlutterLogo(),
//           // leading: Image.asset(
//           //   "assets/images/icon_flutter.png",
//           //   scale: 2,
//           // ),
//           trailing: const Icon(
//             Icons.arrow_forward_ios_rounded,
//             size: 20,
//           ),
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => MycheckView(index)));
//           },
//         ),
//       );
//     },
//   );
// }

  FutureBuilder<List<Checkpoint>> buildbody(
      BuildContext context, checkpoints, page) {
    return FutureBuilder<List<Checkpoint>>(
      // ชนิดของข้อมูล
      future: checkpoints, // ข้อมูล Future
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                // ส่วนของลิสรายการ
                child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขตรงนี้
                    ? ListView.separated(
                        // กรณีมีรายการ แสดงปกติหนด controller ที่จะใช้งานร่วม
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Checkpoint check = snapshot.data![index];
                          Widget card; // สร้างเป็นตัวแปร
                          card = Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ), // การเยื้องขอบ
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                        // leading: Image.asset("assets/images/icon_flutter.png",scale: 1,),
                                        // leading: IconButton(onPressed: () => editBook(check),icon: const Icon(Icons.edit),),// จำลองแก้ไขข้อมูล
                                        leading: IconButton(
                                          onPressed: () => {}, // ลบข้อมูล
                                          icon: _viewIcon(check.status),
                                        ),
                                        title: Text(
                                            '${check.title} : ${check.subtitle}',style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                                        // subtitle: Text(check.subtitle), // 'Date: ${dateFormat.format(check.cdate)}'
                                        // trailing: IconButton(onPressed: () => {}, // ลบข้อมูล icon: _viewIcon(check.status),),
                                        onTap: () {}),
                                    // const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[        
                                        Expanded(
                                          child: Container(
                                            color: kBackgroundColor,
                                            alignment: Alignment.center,
                                            child: TextButton(
                                              child: const Text('เข้าทำงาน',style: TextStyle(color: kPrimaryColor),),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const TodosPage(1)), // Qrview const TodosPage()),  MycheckView(name: '${check.id}')
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Container(
                                            color: kBackgroundColor,
                                            alignment: Alignment.center,
                                            child: TextButton(
                                              child: const Text('รายละเอียด',style: TextStyle(color: kPrimaryColor),),
                                              onPressed: () {
                                                _viewDetail(check.id!);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                          return card;
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(),
                      )
                    : const Center(child: Text('No items')), // กรณีไม่มีรายการ
              ),
            ],
          );
        } else if (snapshot.hasError) {
          // กรณี error
          return Text('${snapshot.error}');
        }
        return const RefreshProgressIndicator(); // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
      },
    );
  }
}

_viewIcon(int i) {
  if (i == 2) {
    return const Icon(
      Icons.check_circle_rounded,
      color: Colors.green,
      size: 25,
    );
  } else{ // if (i == 4) 
    return const Icon(
      Icons.remove_circle_rounded,
      color: Colors.grey,
      size: 25,
    );
  } 
  //else {
  //   return const Icon(Icons.arrow_circle_right_outlined, size: 30);
  // }
}

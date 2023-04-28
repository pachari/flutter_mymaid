import 'package:flutter/material.dart';
// import '../../../componants/background.dart';
import '../../../constants.dart';
import 'checkbox_start.dart';
import '../../../database/todolist_db.dart';
import '../../../services/todolist_service.dart';

class MycheckView extends StatefulWidget {
  static const routeName = '/todolist';
  // ignore: prefer_typing_uninitialized_variables
  final name;
  const MycheckView({super.key, this.name});

  @override
  State<MycheckView> createState() => _MycheckViewState();
}

class _MycheckViewState extends State<MycheckView> {
  bool value = false;
  final notification = [
    CheckBoxState(title: 'กวาดพื้นห้อง , ดูดฝุ่น , ถูพื้น'),
    CheckBoxState(title: 'เช็ดตู้เอกสาร , เครื่องใช้สำนักงาน , เช็ดโต๊ะ'),
    CheckBoxState(title: 'ทำความสะอาด ถังขยะ , เก็บขยะ'),
    CheckBoxState(title: 'ทำความสะอาด ห้องน้ำ'),
    CheckBoxState(title: 'ทำความสะอาด เพดาน'),
    CheckBoxState(title: 'ทำความสะอาด ผนัง'),
    CheckBoxState(title: 'ทำความสะอาด ตู้เย็น'),
    CheckBoxState(title: 'ทำความสะอาด พัดลม'),
    CheckBoxState(title: 'อื่นๆ'),
  ];

  @override
  void initState() {
    super.initState();
    // อ้างอิงฐานข้อมูล
    _db = TodolistDatabase.instance;
    todolists = _db.readAllTodo(); // แสดงรายการหนังสือ
    super.initState();
  }

  late TodolistDatabase _db; // อ้างอิงฐานข้อมูล
  late Future<List<Todolist>> todolists; // ลิสรายการหนังสือ
  int i = 0; // จำลองตัวเลขการเพิ่่มจำนวน

  // จำลองทำคำสั่งเพิ่มข้อมูลใหม่
  Future<void> newTodo() async {
    i++;
    Todolist check = Todolist(
      checkpointid: i,
      todolistid: i,
      title: 'กวาดพื้นห้อง อาคารสำนักงาน', //'อาคารสำนักงาน $i',
      subtitle: '', //'อาคารโรงผลิต 3อาคารสำนักงาน $i',
      status: 1,
      active: true,
      // typecheckpoint: 1
      // cdate: DateTime.now(),
      // cby: 'pachari_pm@hotmail.com'
    ); //user?.email.toString()
    // ignore: non_constant_identifier_names, unused_local_variable
    Todolist newTodo = await _db.create(check); // ทำคำสั่งเพิ่มข้อมูลใหม่
    setState(() {
      todolists = _db.readAllTodo(); // แสดงรายการหนังสือ
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "To-do List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      // body: Background(
      //   child: SafeArea(
      //     child: Stack(
      //       children: <Widget>[
      //         // Text(
      //         //   widget.name,
      //         //   style: const TextStyle(
      //         //       fontSize: 90,
      //         //       fontFamily: 'Helvetica',
      //         //       fontWeight: FontWeight.bold),
      //         // ),
      //         ListView(
      //           children: [
      //             buildListView(context),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            child: buildbody(context, todolists, widget.name),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => newTodo(),
        child: const Icon(Icons.add),
      ),
    );
  }
// }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: kPrimaryColor,
  //       title: const Text(
  //         "To-do List",
  //         style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 20,
  //             color: Color.fromARGB(255, 255, 255, 255)),
  //       ),
  //     ),
  //     body: SafeArea(
  //       child: Stack(
  //         children: <Widget>[
  //           Container(
  //             color: kPrimaryColor,
  //             child: ListView(
  //               padding: const EdgeInsets.all(10),
  //               children: [
  //                 buildListView(),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildSingleCheckbox(CheckBoxState checkbox) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: kPrimaryColor,
      value: checkbox.value,
      title: Text(
        checkbox.title,
        style: const TextStyle(fontSize: 16),
      ),
      checkboxShape: const CircleBorder(),
      onChanged: (value) => setState(() => checkbox.value = value!),
    );
  }

  Widget buildListView(context) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ]),
            ),
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(2),
            child: Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ...notification.map(buildSingleCheckbox).toList(),
                    buildbody(context, todolists, widget.name),
                  ],
                ),
                // Column(
                //   children: [buildContainerButton(context)],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainerButton(context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints:
                    const BoxConstraints.expand(height: 45, width: 150),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kselectedItemColor),
                margin: const EdgeInsets.only(top: 16, bottom: 10, right: 10),
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  child: const Icon(
                    Icons.qr_code_scanner_sharp,
                    color: Colors.white,
                  ),
                  onTap: () {
                    const snackBar =
                        SnackBar(content: Text('Tap SnackBar Scan bar'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
              Container(
                constraints:
                    const BoxConstraints.expand(height: 45, width: 150), //250
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 12, 152, 33)),
                margin: const EdgeInsets.only(top: 16, bottom: 10),
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                    onTap: () {
                      // print(widget.name);
                      // const snackBar =
                      //     SnackBar(content: Text('Tap SnackBar Save'));
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Todolist>> buildbody(
      BuildContext context, todolists, page) {
    return FutureBuilder<List<Todolist>>(
      // ชนิดของข้อมูล
      future: todolists, // ข้อมูล Future
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                // ส่วนของลิสรายการ
                child: snapshot.data!.isNotEmpty
                    ? ListView.separated(
                        // กรณีมีรายการ แสดงปกติหนด controller ที่จะใช้งานร่วม
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          // print(index);
                          // return Text(page);
                          Todolist check = snapshot.data![index];
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
                              child: Column(
                                children: [
                                  CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      activeColor: kPrimaryColor,
                                      value: check.active,
                                      title: Text(
                                        '${check.title} ${check.subtitle}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      checkboxShape: const CircleBorder(),
                                      // onChanged: (value) => {}
                                      onChanged: (value) =>
                                          setState(() => value = value!),
                                      ),

                                  /// ...notification.map(buildSingleCheckbox).toList(),/ ListTile(
                                  //   // leading: Image.asset("assets/images/icon_flutter.png",scale: 1,),
                                  //   // leading: IconButton(onPressed: () => editBook(check),icon: const Icon(Icons.edit),),// จำลองแก้ไขข้อมูล
                                  //   title: Text(
                                  //       '${check.title} ${check.subtitle}'),
                                  //   // subtitle: Text(check.subtitle), // 'Date: ${dateFormat.format(check.cdate)}'
                                  //   // trailing: IconButton(
                                  //   //   onPressed: () => {}, // ลบข้อมูล
                                  //   //   icon: _viewIcon(check.status),
                                  //   // ),
                                  //   onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             MycheckView(name: '${check.id}')),
                                  //   ),
                                  //   // onTap: () {_viewDetail(check.id!);} // กดเลือกรายการให้แสดงรายละเอียด
                                  // ),
                                ],
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

  // _viewIcon(int i) {
  //   if (i == 2) {
  //     return const Icon(
  //       Icons.check_circle_rounded,
  //       color: Colors.green,
  //       size: 30,
  //     );
  //   } else {
  //     return const Icon(Icons.arrow_circle_right_outlined, size: 30);
  //   }
  // }
}

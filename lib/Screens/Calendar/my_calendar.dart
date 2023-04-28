import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';
import '../../responsive.dart';
// import '../../componants/background.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
// import '../Login/components/login_screen_top_image.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

final Map<DateTime, List<CleanCalendarEvent>> _events = {
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
    CleanCalendarEvent('Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 12, 0),
        description: 'A special event',
        color: Colors.blue),
  ],
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2): [
    CleanCalendarEvent('Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange),
    CleanCalendarEvent('Event C',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink),
  ],
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3): [
    CleanCalendarEvent('Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange),
    CleanCalendarEvent('Event C',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink),
    CleanCalendarEvent('Event D',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.amber),
    CleanCalendarEvent('Event E',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.deepOrange),
    CleanCalendarEvent('Event F',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.green),
    CleanCalendarEvent('Event G',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.indigo),
    CleanCalendarEvent('Event H',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.brown),
    CleanCalendarEvent('Event I',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: const Color.fromARGB(255, 255, 68, 0)),
    CleanCalendarEvent('Event J',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: const Color.fromARGB(255, 0, 67, 10)),
    CleanCalendarEvent('Event K',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: const Color.fromARGB(255, 222, 0, 225)),
  ],
};

class _CalendarScreenState extends State<CalendarScreen> {
  // final user = FirebaseAuth.instance.currentUser;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    // var email = user?.email.toString();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          title: const Text(
            "History",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      body: SafeArea(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset("assets/images/login_bottom.png",
                        width: 120),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child:
                        Image.asset("assets/images/main_bottom.png", width: 50),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 800,
                        child: buildContainerbodyHello(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNewDate(date) {
    // ignore: avoid_print
    print('Date selected: $date');
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContainerbodyHello(),
    );
  }
}

Widget buildContainerbodyHello() {
  return InkWell(
    child: Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Calendar(
        startOnMonday: true,
        events: _events,
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: kPrimaryColor,
        todayColor: Colors.red,
        eventColor: Colors.red,
        locale: 'en_US',
        todayButtonText: ' ',
        isExpanded: false,
        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        dayOfWeekStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 14),
      ),
    ),
  );
}

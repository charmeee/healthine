import 'package:flutter/material.dart';
import 'package:healthin/home/profile.dart';
import '../userSetting/userSetting.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:healthin/home/util.dart';

import '../models.dart';
import 'hometab/hometab.dart';

class Home2 extends StatelessWidget {
  Home2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['홈', '달력'];
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          physics: PageScrollPhysics(),
          //physics: NeverScrollableScrollPhysics(), //이걸안하면 상단바 생긴만큼 길이가 추가됨;but 하면아래로 스크롤이 안됨.
          // NeverScrollableScrollPhysics : 목록 스크롤 불가능하게 설정
          // BouncingScrollPhysics : 튕겨저 올라가는 듯한 동작 가능 List 끝에 도달했을 시에 다시 되돌아감
          // ClampingScrollPhysics : 안드로이드의 기본 스크롤과 동일하다. List의 끝에 도달하면 동작을 멈춤
          // PageScrollPhysics : 다른 스크롤에 비해 조금더 부드럽게 만듬
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.indigo,
                pinned: true,
                floating: true,
                snap: true,
                expandedHeight: 270.0,
                flexibleSpace: FlexibleSpaceBar(background: Profile()),
                bottom: TabBar(
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ];
          },

          body: TabBarView(
            //physics: NeverScrollableScrollPhysics(),
            //physics: PageScrollPhysics(),
            children: [
              Tab1(),
              Tab2(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              accountName: Text("yong"),
              accountEmail: Text("otrodevym@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                //backgroundImage: null,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850],
              ),
              title: Text('헬스장 정보'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('설정'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserSetting()));
                print('Setting is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.grey[850],
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A is clicked');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class Tab2 extends StatefulWidget {
  const Tab2({Key? key}) : super(key: key);

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar<Event>(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              leftChevronIcon: Icon(Icons.arrow_left),
              rightChevronIcon: Icon(Icons.arrow_right),
              titleTextStyle: const TextStyle(fontSize: 17.0),
            ),
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

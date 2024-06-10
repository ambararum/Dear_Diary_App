import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static Map<DateTime, List<Map<String, String>>> selectedMoods = {};

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Map<String, String>>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return CalendarScreen.selectedMoods[day] ?? [];
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<int> _getYears() {
    return List<int>.generate(101, (index) => 2000 + index);
  }

  List<int> _getMonths() {
    return List<int>.generate(12, (index) => index + 1);
  }

  void _onYearChanged(int? year) {
    if (year != null) {
      setState(() {
        _selectedYear = year;
        _focusedDay = DateTime(_selectedYear, _selectedMonth);
      });
    }
  }

  void _onMonthChanged(int? month) {
    if (month != null) {
      setState(() {
        _selectedMonth = month;
        _focusedDay = DateTime(_selectedYear, _selectedMonth);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  value: _selectedYear,
                  items: _getYears().map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: _onYearChanged,
                ),
                SizedBox(width: 20),
                DropdownButton<int>(
                  value: _selectedMonth,
                  items: _getMonths().map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: _onMonthChanged,
                ),
              ],
            ),
            SizedBox(height: 20),
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarFormat: CalendarFormat.month,
              availableCalendarFormats: const { CalendarFormat.month: 'Month' },
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  _selectedEvents.value = _getEventsForDay(selectedDay);
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Map<String, String>>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final event = value[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(event['mood']!),
                        ),
                        title: Text(event['title']!),
                        subtitle: Text(event['content']!),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/journal_detail',
                            arguments: {
                              'title': event['title']!,
                              'mood': event['mood']!,
                              'content': event['content']!,
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

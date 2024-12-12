import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScheduleScreen extends StatefulWidget {
  const AttendanceScheduleScreen({super.key});

  @override
  State<AttendanceScheduleScreen> createState() => _AttendanceScheduleScreenState();
}

class _AttendanceScheduleScreenState extends State<AttendanceScheduleScreen> {
  late final ValueNotifier<List<DateTime>> _holidays;
  late final ValueNotifier<List<DateTime>> _workingDays;
  late final ValueNotifier<List<DateTime>> _remainingLeave;

  @override
  void initState() {
    super.initState();
    _holidays = ValueNotifier([
      DateTime.utc(2024, 12, 25), // Christmas
      DateTime.utc(2024, 12, 31), // New Year's Eve
    ]);

    _workingDays = ValueNotifier([
      DateTime.utc(2024, 12, 1), // Example working days
      DateTime.utc(2024, 12, 2),
      DateTime.utc(2024, 12, 4),
      DateTime.utc(2024, 12, 5),
      DateTime.utc(2024, 12, 6),
      // Add all other working days here...
    ]);

    _remainingLeave = ValueNotifier([
      DateTime.utc(2024, 12, 10), // Example remaining leave day
      DateTime.utc(2024, 12, 12),
      // Add other leave days...
    ]);
  }

  @override
  void dispose() {
    _holidays.dispose();
    _workingDays.dispose();
    _remainingLeave.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Attendance & Schedule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar View with highlighted holidays, working days, and remaining days
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: DateTime.now(),
                calendarStyle: CalendarStyle(
                  // Highlight holidays in red and working days in green
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                  ),
                  holidayDecoration: BoxDecoration(
                    color: Colors.red.shade400,
                    shape: BoxShape.circle,
                  ),
                  defaultTextStyle: TextStyle(color: Colors.black),
                ),
                holidayPredicate: (day) {
                  return _holidays.value.contains(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  // Handle day selection if needed
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    // Custom styling for working days and remaining leave days
                    if (_workingDays.value.contains(day)) {
                      return Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: Colors.green, // Working days in green
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    if (_remainingLeave.value.contains(day)) {
                      return Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: Colors.blue, // Remaining leave days in blue
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return null; // Default rendering for other days
                  },
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Summary',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryItem('Total Working Days:', '20'), // Example working days
                  _buildSummaryItem('Holidays:', '5'), // Example holidays
                  _buildSummaryItem('Remaining Leave:', '2'), // Example remaining leave
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Item Builder
  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

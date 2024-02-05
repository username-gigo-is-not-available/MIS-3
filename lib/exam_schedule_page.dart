import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamSchedulePage extends StatefulWidget {
  const ExamSchedulePage({super.key});

  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  final TextEditingController _subjectController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final List<Map<String, dynamic>> _schedules = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Add Exam Schedule'),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: _subjectController,
                            decoration: const InputDecoration(labelText: 'Subject'),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: _selectedDate == null
                                        ? ''
                                        : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: TextEditingController(
                                    text: _selectedTime == null
                                        ? ''
                                        : _selectedTime!.format(context),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Time',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.access_time),
                                      onPressed: () {
                                        _selectTime(context);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _schedules.add({
                              'subject': _subjectController.text,
                              'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
                              'time': _selectedTime!.format(context),
                            });
                            _subjectController.clear();
                            _selectedDate = null;
                            _selectedTime = null;
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _schedules.length,
        itemBuilder: (BuildContext context, int index) {
          final schedule = _schedules[index];
          return Card(
            child: ListTile(
              title: Text(schedule['subject'] ?? ''),
              subtitle: Text('${schedule['date']} | ${schedule['time']}'),
            ),
          );
        },
      ),
    );
  }
}

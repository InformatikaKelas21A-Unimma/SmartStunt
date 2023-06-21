class ReminderData {
  static ReminderData? _instance;
  List<Map<String, dynamic>> reminders = [];

  ReminderData._();

  factory ReminderData.getInstance() {
    if (_instance == null) {
      _instance = ReminderData._();
    }
    return _instance!;
  }

  void clearData() {
    reminders.clear();
  }

  void addReminder(Map<String, dynamic> reminder) {
    reminders.add(reminder);
  }

  void removeReminderAt(int index) {
    reminders.removeAt(index);
  }

  void updateStatusAtIndex(int index, bool newStatus) {
    if (index >= 0 && index < reminders.length) {
      reminders[index]['status'] = newStatus;
    }
  }
}

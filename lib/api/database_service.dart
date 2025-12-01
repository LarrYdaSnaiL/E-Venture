import 'package:firebase_database/firebase_database.dart';
import 'package:eventure/models/user_model.dart';
import 'package:eventure/models/event_model.dart';
import 'package:eventure/models/attendance_model.dart';

class DatabaseService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<void> saveUserData(UserModel user) async {
    try {
      await _db.ref('users/${user.uid}').set(user.toJson());
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      final snapshot = await _db.ref('users/$uid').get();

      if (snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return UserModel.fromFirebase(uid, data);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createEvent(EventModel event) async {
    try {
      final newEventRef = _db.ref('events').push();
      event.id = newEventRef.key;
      await newEventRef.set(event.toJson());
    } catch (e) {
      print('Error creating event: $e');
      rethrow;
    }
  }

  Stream<DatabaseEvent> getAllEventsStream() {
    return _db.ref('events').onValue;
  }

  Future<void> registerForEvent(String eventId, String userId) async {
    try {
      final attendanceRef = _db.ref('attendance/$eventId/$userId');
      final newAttendance = AttendanceModel(
        userId: userId,
        eventId: eventId,
        registeredAt: DateTime.now(),
      );
      await attendanceRef.set(newAttendance.toJson());
    } catch (e) {
      print('Error registering for event: $e');
      rethrow;
    }
  }

  Future<void> markAttendance(String eventId, String userId) async {
    try {
      final attendanceRef = _db.ref('attendance/$eventId/$userId');
      await attendanceRef.update({
        'attended': true,
        'attendedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error marking attendance: $e');
      rethrow;
    }
  }

  Stream<DatabaseEvent> getEventAttendanceStream(String eventId) {
    return _db.ref('attendance/$eventId').onValue;
  }
}

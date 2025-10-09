import 'package:firebase_database/firebase_database.dart';
import 'package:eventure/models/user_model.dart';
import 'package:eventure/models/event_model.dart';
import 'package:eventure/models/attendance_model.dart';

/// A service class to handle all Firebase Realtime Database operations.
/// This isolates database logic, making it easy to manage and test.
class DatabaseService {
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  /// Saves a new user's data to the '/users/' path in the database.
  Future<void> saveUserData(UserModel user) async {
    try {
      await _db.ref('users/${user.uid}').set(user.toJson());
    } catch (e) {
      print('Error saving user data: $e');
      rethrow;
    }
  }

  /// Fetches a user's data from the database.
  Future<UserModel?> getUserData(String uid) async {
    try {
      final snapshot = await _db.ref('users/$uid').get();
      if (snapshot.exists && snapshot.value != null) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return UserModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  /// Creates a new event in the '/events/' path.
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

  /// Returns a stream of all events.
  Stream<DatabaseEvent> getAllEventsStream() {
    return _db.ref('events').onValue;
  }

  /// Registers a user for an event by creating a new attendance record.
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

  /// Marks a user as attended for a specific event after a QR scan.
  Future<void> markAttendance(String eventId, String userId) async {
    try {
      final attendanceRef = _db.ref('attendance/$eventId/$userId');
      // Using update to modify only specific fields without overwriting the whole object
      await attendanceRef.update({
        'attended': true,
        'attendedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error marking attendance: $e');
      rethrow;
    }
  }

  /// Returns a stream of attendance data for a specific event.
  Stream<DatabaseEvent> getEventAttendanceStream(String eventId) {
    return _db.ref('attendance/$eventId').onValue;
  }
}

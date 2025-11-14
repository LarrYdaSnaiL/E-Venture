import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

/// A service class to handle all Firebase Storage operations.
/// This is used primarily for uploading and managing files like user KTM images.
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a file to a specified path in Firebase Storage and returns the download URL.
  ///
  /// [file] The file to be uploaded.
  /// [userId] The UID of the user, used to create a unique folder path.
  ///
  /// This is perfect for uploading the student ID card (KTM). The path will be
  /// something like 'ktm_uploads/USER_ID/filename.jpg', which keeps files organized.
  Future<String?> uploadKtmImage(File file, String userId) async {
    try {
      // Create a unique file name to avoid conflicts.
      // Using a timestamp ensures that even if a user uploads a new KTM,
      // it won't overwrite the old one if needed for historical records.
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}';

      // Define the path where the file will be stored in Firebase Storage.
      final String filePath = 'ktm_uploads/$userId/$fileName';

      // Get a reference to the storage location.
      final Reference ref = _storage.ref().child(filePath);

      // Start the upload task.
      final UploadTask uploadTask = ref.putFile(file);

      // Await the completion of the upload task.
      final TaskSnapshot snapshot = await uploadTask;

      // Once uploaded, get the public URL for the file.
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      // Handle potential errors like permission issues.
      print('Error uploading KTM image: $e');
      // You could use your ToastHelper here as well if you want to show an error.
      // ToastHelper.showShortToast('Upload failed: ${e.message}');
      return null;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future SignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      User? user = await FirebaseAuth.instance.currentUser;
      print(user == null ? "User  is signed out" : "User  is still signed in");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> deleteUserAndData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Ambil dokumen pengguna berdasarkan UID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          // Hapus data di Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .delete();
          print("Data Firestore berhasil dihapus untuk UID: ${user.uid}");
        }

        // Hapus akun pengguna
        await user.delete();
        print("User berhasil dihapus.");
      } catch (e) {
        print("Error saat menghapus user atau data: $e");
      }
    } else {
      print("Tidak ada user yang sedang login.");
    }
  }

  Future<bool> verifyOldPassword(String oldPassword) async {
    try {
      User? user = auth.currentUser;

      // Reauthentikasi pengguna dengan email dan password lama
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      return true; // Password lama valid
    } catch (e) {
      return false; // Password lama tidak valid
    }
  }

  Future<void> updatePassword(String newPassword) async {
    User? user = auth.currentUser; // Ambil pengguna saat ini
    if (user != null) {
      await user.updatePassword(newPassword); // Perbarui password pengguna
    } else {
      throw FirebaseAuthException(
        code: 'USER_NOT_FOUND',
        message: 'Pengguna tidak ditemukan',
      );
    }
  }
}

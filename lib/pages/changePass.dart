import 'package:dapoerjengsri/widget/auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String errorMessage = "";

  void handleChangePassword() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;

    try {
      // Verifikasi password lama
      bool isOldPasswordCorrect =
          await AuthMethods().verifyOldPassword(oldPassword);
      if (!isOldPasswordCorrect) {
        setState(() {
          errorMessage = "Password lama salah!";
        });
        return;
      }

      // Perbarui password baru
      await AuthMethods().updatePassword(newPassword);

      Navigator.pop(context); // Tutup dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password has been successfully changed!")),
      );
    } catch (e) {
      setState(() {
        errorMessage = "There's a mistake: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change Password"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: oldPasswordController,
            decoration: const InputDecoration(
              labelText: "Old Password",
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: newPasswordController,
            decoration: const InputDecoration(
              labelText: "New  Password",
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 10),
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: handleChangePassword,
          child: const Text("Save"),
        ),
      ],
    );
  }
}

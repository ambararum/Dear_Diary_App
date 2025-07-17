import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  String? _selectedLanguage;
  String? _selectedGender;

  void _saveProfile(BuildContext context) {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String hobby = _hobbyController.text.trim();
    String? language = _selectedLanguage;
    String? gender = _selectedGender;

    // Validasi input
    if (name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        hobby.isNotEmpty &&
        language != null &&
        gender != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance.collection('profiles').doc(userId).set({
        'name': name,
        'email': email,
        'phone': phone,
        'hobby': hobby,
        'language': language,
        'gender': gender,
        'updatedAt': DateTime.now(),
      }).then((value) {
        // Profil berhasil disimpan, bisa tambahkan navigasi atau feedback lain jika diperlukan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile saved successfully')),
        );
      }).catchError((error) {
        // Tangani kesalahan jika gagal menyimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: $error')),
        );
      });
    } else {
      // Tampilkan pesan jika ada input yang kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedLanguage,
              decoration: InputDecoration(labelText: 'Language'),
              items: ['Indonesian', 'English'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(labelText: 'Gender'),
              items: ['Female', 'Male'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
            ),
            TextField(
              controller: _hobbyController,
              decoration: InputDecoration(labelText: 'Hobby'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveProfile(context);
              },
              child: Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}

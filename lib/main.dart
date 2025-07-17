import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dear_diary_app/sign_in.dart';
import 'package:dear_diary_app/sign_up.dart';
import 'package:dear_diary_app/home.dart';
import 'package:dear_diary_app/profil.dart';
import 'package:dear_diary_app/edit_profil.dart';
import 'package:dear_diary_app/language.dart';
import 'package:dear_diary_app/privacy_policy.dart';
import 'package:dear_diary_app/my_journals.dart';
import 'package:dear_diary_app/create_journal.dart';
import 'package:dear_diary_app/calendar.dart';
import 'package:dear_diary_app/journal_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DearDiaryApp());
}

class DearDiaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dear Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/editProfile': (context) => EditProfileScreen(),
        '/language': (context) => LanguageScreen(),
        '/privacyPolicy': (context) => PrivacyPolicyScreen(),
        '/my_journals': (context) => MyJournalsScreen(),
        '/create_journal': (context) => CreateJournalScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/journal_detail') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) {
              return JournalDetailScreen(
                title: args['title']!,
                mood: args['mood']!,
                content: args['content']!,
              );
            },
          );
        }
        return null;
      },
    );
  }
}

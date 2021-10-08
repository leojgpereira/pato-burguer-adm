import 'package:flutter/material.dart';

import 'components/auth_check.dart';

class PatoBurguerAdminApp extends StatelessWidget {
  const PatoBurguerAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFF9B0D),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheck(),
      },
    );
  }
}

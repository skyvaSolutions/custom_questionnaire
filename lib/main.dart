import 'package:custom_questionnaire/screens/add_or_view_forms.dart';
import 'package:custom_questionnaire/utils/device_id.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

Color teal = const Color(0xFF3CD1BB);
Color purple = const Color(0xFF4C44B3);
Color black = const Color(0xFF11162E);
Color orange = const Color(0xFFEDAF11);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: teal,
      ),
      home: const MyHomePage(title: 'Custom Questionnaire'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const AddOrViewForms(),
    );
  }

  @override
  void initState() {
    super.initState();
    deviceID.getInfo();
  }
}

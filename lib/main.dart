import 'package:employee_directory/src/services/hive_service.dart';
import 'package:employee_directory/src/view_model/employee_provider.dart';
import 'package:employee_directory/src/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  HiveService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EmployeeProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Employee Directory',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen()),
    );
  }
}

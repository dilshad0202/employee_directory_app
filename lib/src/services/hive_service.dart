import 'package:employee_directory/src/models/company.dart';
import 'package:employee_directory/src/models/employee.dart';
import 'package:employee_directory/src/models/geo.dart';
import 'package:employee_directory/src/models/address.dart';
import 'package:hive_flutter/adapters.dart';


class HiveService {


  static const String EMPLOYEE = "employee";




  static void init() {

    if (!Hive.isAdapterRegistered(EmployeeAdapter().typeId)) {
      Hive.registerAdapter(EmployeeAdapter());
    }
    if (!Hive.isAdapterRegistered(GeoAdapter().typeId)) {
      Hive.registerAdapter(GeoAdapter());
    }
    if (!Hive.isAdapterRegistered(AddressAdapter().typeId)) {
      Hive.registerAdapter(AddressAdapter());
    }
    if (!Hive.isAdapterRegistered(CompanyAdapter().typeId)) {
      Hive.registerAdapter(CompanyAdapter());
    }
  }

 static Future<bool>isExists(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    await Hive.close();
    return length != 0 ? true : false;
  }
}

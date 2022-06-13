import 'package:employee_directory/src/models/employee.dart';
import 'package:employee_directory/src/services/api_service.dart';
import 'package:employee_directory/src/services/download_helper.dart';
import 'package:employee_directory/src/services/file_service.dart';
import 'package:employee_directory/src/services/hive_service.dart';
import 'package:employee_directory/src/utilities/api_s.dart';
import 'package:employee_directory/src/utilities/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employee = [];
  List<Employee> get employee => _employee;

  ProviderStatus dataFecthStatusDB = ProviderStatus.IDLE;
  ProviderStatus dataFetchStatusWeb = ProviderStatus.IDLE;

  String appDataPath = "";
  bool isDataStored = false;

  void set dataStored(bool value) {
    isDataStored = value;
  }

  Future<void> searchUser(String searchText) async {
    var employeeDb = await Hive.openBox<Employee>(HiveService.EMPLOYEE);
    try {
      _employee.clear();
      employeeDb.isNotEmpty
          ? _employee = employeeDb.values
              .where((c) => (c.name!
                      .replaceAll(' ', '')
                      .toLowerCase()
                      .contains(searchText.replaceAll(' ', '').toLowerCase()) ||
                  c.email!
                      .replaceAll(' ', '')
                      .toLowerCase()
                      .contains(searchText.replaceAll(' ', '').toLowerCase())))
              .toList()
          : null;
      notifyListeners();
    } catch (e) {
      print("Search data failed $e");
    }
  }


  Future<void> saveToDB(Employee employee) async {
    var employeeDb = await Hive.openBox<Employee>(HiveService.EMPLOYEE);
    try {
      employeeDb.add(employee);
    } catch (e) {
      print("save to DB $e");
    }
  }

  Future<void> getDataFromDb() async {
    try {
      _employee.clear();
      dataFecthStatusDB = ProviderStatus.LOADING;
      notifyListeners();
      final employeeDb = await Hive.openBox<Employee>(HiveService.EMPLOYEE);
      if (employeeDb.length > 0) {
        employeeDb.values.forEach((element) {
          _employee.add(element);
        });
      }
      dataFecthStatusDB = ProviderStatus.LOADED;
      dataStored = true;
      notifyListeners();
    } catch (e) {
      dataFecthStatusDB = ProviderStatus.ERROR;
      notifyListeners();
      print("Fetching Data from DB $e");
    }
  }

  Future<void> initializeAppDataPath() async {
    appDataPath = await FileService.getApplicationDataPath();
  }

  Future<void> downloadProfileImage(Employee employee) async {
    try {
      await DownloadHelper.downloadFileFromUrl(
        url: employee.profileImage ?? "",
        filePath: "$appDataPath/Profiles/${employee.username}.jpg",
        downloadSuccessActions: () {},
        downloadFailedActions: () {},
      );
    } catch (e) {
      print("Profile Image Downloading Failed$e");
    }
  }

  Future<void> fetchDataAndSaveToDB() async {
    dataFetchStatusWeb = ProviderStatus.LOADING;
    notifyListeners();
    employee.clear();
    try {
      var response = await ApiService.getApiData(url: ApiConstants.api);
      response.data.forEach((data) async {
        _employee.add(Employee.fromJson(data));
        Employee employee = Employee.fromJson(data);
        downloadProfileImage(employee);
        employee.profileImage =
            "$appDataPath/Profiles/${employee.username}.jpg";
        saveToDB(employee);
      });
      dataFetchStatusWeb = ProviderStatus.LOADED;
      notifyListeners();
    } catch (e) {
      dataFetchStatusWeb = ProviderStatus.ERROR;
      notifyListeners();
      print(e);
    }
  }
}

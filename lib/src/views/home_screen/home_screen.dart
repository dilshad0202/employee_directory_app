import 'package:employee_directory/src/services/hive_service.dart';
import 'package:employee_directory/src/utilities/enums.dart';
import 'package:employee_directory/src/view_model/employee_provider.dart';
import 'package:employee_directory/src/views/home_screen/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    EmployeeProvider _employeeProvider = context.read<EmployeeProvider>();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await _employeeProvider.initializeAppDataPath();
      if (await HiveService.isExists(HiveService.EMPLOYEE) == true) {
        await _employeeProvider.getDataFromDb();
        _employeeProvider.dataStored = true;
      } else {
        await _employeeProvider.fetchDataAndSaveToDB().whenComplete(() {
          if (_employeeProvider.dataFetchStatusWeb == ProviderStatus.LOADED) {
            ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
                SnackBar(content: Text("Employees Data Stored Successfully")));
          }
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Consumer<EmployeeProvider>(builder: (context, provider, child) {
          if (provider.dataFecthStatusDB == ProviderStatus.ERROR ||
              provider.dataFetchStatusWeb == ProviderStatus.ERROR) {
            return Center(
              child: Text("Something went wrong"),
            );
          } else if (provider.dataFecthStatusDB == ProviderStatus.LOADED ||
              provider.dataFetchStatusWeb == ProviderStatus.LOADED) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  
                  floating: true,
                  toolbarHeight: 70,
                  backgroundColor: Colors.black87,
                  title: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: TextField(
                      onChanged: (String value) async {
                        provider.dataStored = true;
                        if (value.isNotEmpty || value.characters.isNotEmpty) {
                          await provider.searchUser(value);
                        } else {
                          await provider.getDataFromDb();
                        }
                      },
                      cursorColor: Colors.black54,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.all(12),
                        border: InputBorder.none,
                        hintText: "Search name or email",
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                    hasScrollBody: true,
                    child: Container(
                      color: Colors.black87,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          margin: EdgeInsets.only(top: 10),
                          child: provider.employee.isEmpty
                              ? Center(
                                  child: Text("No Data Found"),
                                )
                              : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                  itemCount: provider.employee.length,
                                  itemBuilder: (context, index) {
                                    return EmployeeCard(
                                      index: index,
                                    );
                                  })),
                    ))
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(color: Color(0xff99425d),
            strokeWidth: 2,),
          );
        }),
      ),
    );
  }
}

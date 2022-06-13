import 'dart:io';
import 'package:employee_directory/src/models/employee.dart';
import 'package:employee_directory/src/view_model/employee_provider.dart';
import 'package:employee_directory/src/views/empolyee_details_screen/widgets/named_border.dart';
import 'package:flutter/material.dart';
import 'package:employee_directory/src/utilities/styling.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee? employee;

  EmployeeDetailsScreen({this.employee});
  @override
  Widget build(BuildContext context) {
    EmployeeProvider provider = context.read<EmployeeProvider>();
    double _height = MediaQuery.of(context).size.height / 812;
    double _width = MediaQuery.of(context).size.width / 375;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: .05)
              ]),
          margin: EdgeInsets.symmetric(
              horizontal: _width * 20, vertical: _height * 50),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: _height * 35),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0, 2),
                            blurRadius: 5,
                            spreadRadius: .05)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xff99425d), Color(0xffdd7886)]),
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: provider.isDataStored
                            ? Image.file(File(employee!.profileImage ?? ""),
                                errorBuilder: (context, error, stackTrace) {
                                return Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                    ));
                              })
                            : Image.network(employee!.profileImage ?? "",
                                errorBuilder: (context, error, stackTrace) {
                                  
                                return Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                    ));
                              }),
                      ),
                      radius: 65,
                    ),
                    Text(employee?.username ?? "",
                        style: fontStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ]),
                ),
                SizedBox(
                  height: _height * 10,
                ),
                Text(
                  employee?.name ?? "",
                  style: fontStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: _height * 5,
                ),
                Text(
                  employee?.email ?? "",
                  style: fontStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                SizedBox(
                  height: _height * 5,
                ),
                Text(
                  employee?.phone ?? "",
                  style: fontStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]),
                ),
                Text(
                  employee?.website ?? "",
                  style: fontStyle(color: Colors.blue),
                ),
                SizedBox(
                  height: _height * 20,
                ),
                if (employee!.address != null)
                  NamedBorderColumn(children: [
                    tableRow(employee?.address?.street ?? ""),
                    tableRow(employee?.address?.city ?? ""),
                    tableRow(employee?.address?.suite ?? ""),
                    tableRow(employee?.address?.zipcode ?? ""),
                    tableRow("Lat : ${employee?.address?.geo?.lat ?? ""}"),
                    tableRow("Lon : ${employee?.address?.geo?.lng ?? ""}"),
                  ], title: "Address"),
                if (employee!.company != null)
                  NamedBorderColumn(children: [
                    tableRow(
                      employee?.company?.name ?? "",
                      textStyle:
                          fontStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    tableRow(employee?.company?.catchPhrase ?? ""),
                    tableRow(employee?.company?.bs ?? ""),
                  ], title: "Company Details"),
                SizedBox(
                  height: _height * 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow tableRow(String adrress, {TextStyle? textStyle}) {
    return TableRow(children: [
      Text(
        "$adrress",
        style: textStyle ??
            fontStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600]),
      ),
    ]);
  }
}

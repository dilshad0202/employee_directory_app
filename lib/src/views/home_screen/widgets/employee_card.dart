import 'package:employee_directory/src/view_model/employee_provider.dart';
import 'package:employee_directory/src/views/empolyee_details_screen/employee_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EmployeeCard extends StatelessWidget {
  final int? index;

  EmployeeCard({this.index});

  @override
  Widget build(BuildContext context) {
    EmployeeProvider provider = context.read<EmployeeProvider>();
    return Container(
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
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                            employee: provider.employee[index!],
                          )));
            },
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Row(
                children: [
                  CircleAvatar(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: provider.isDataStored
                            ? Image.file(
                                File(provider.employee[index!].profileImage ??
                                    ""),
                                errorBuilder: (context, error, stackTrace) {
                                return Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                    ));
                              })
                            : provider.employee[index!].profileImage == null ||
                                    provider
                                        .employee[index!].profileImage!.isEmpty
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      size: 35,
                                    ))
                                : Image.network(
                                    provider.employee[index!].profileImage ??
                                        "",
                                  )),
                    radius: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.employee[index!].name ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        provider.employee[index!].company?.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

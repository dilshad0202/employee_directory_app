import 'dart:convert';
import 'package:employee_directory/src/models/address.dart';
import 'package:employee_directory/src/models/company.dart';
import 'package:hive_flutter/adapters.dart';
part 'employee.g.dart';


@HiveType(typeId: 0)
class Employee {
    Employee({
        this.id,
        this.name,
        this.username,
        this.email,
        this.profileImage,
        this.address,
        this.phone,
        this.website,
        this.company,
    });

    @HiveField(0)
    int? id;

    @HiveField(1)
    String? name;

    @HiveField(2)
    String? username;

    @HiveField(3)
    String? email;

    @HiveField(4)
    String? profileImage;

    @HiveField(5)
    Address? address;

    @HiveField(6)
    String? phone;

    @HiveField(7)
    String? website;

    @HiveField(8)
    Company? company;
    


    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        profileImage: json["profile_image"] == null ? null : json["profile_image"],
        address: Address.fromJson(json["address"]),
        phone: json["phone"] == null ? null : json["phone"],
        website: json["website"] == null ? null : json["website"],
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "profile_image": profileImage == null ? null : profileImage,
        "address": address!.toJson(),
        "phone": phone == null ? null : phone,
        "website": website == null ? null : website,
        "company": company == null ? null : company!.toJson(),
    };

List<Employee> employeeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}



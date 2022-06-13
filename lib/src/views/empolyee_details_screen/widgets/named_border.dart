import 'package:flutter/material.dart';


class NamedBorderColumn extends StatelessWidget {
  
  NamedBorderColumn({this.children, this.title});

 final List<TableRow>? children;
 final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Table(children: children!),
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!, width: 0.5),
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
        ),
        Positioned(
            left: 50,
            top: 12,
            child: Container(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              color: Colors.white,
              child: Text(
                title!,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class StatActiveUsers extends StatefulWidget {
  const StatActiveUsers({Key? key}) : super(key: key);

  @override
  _StatActiveUsersState createState() => _StatActiveUsersState();
}

class _StatActiveUsersState extends State<StatActiveUsers> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Container(
          margin: const EdgeInsets.only(top:10, right: 5, bottom:0, left:10),
          padding: const EdgeInsets.all(15),
          height: 100,
          color: Colors.indigo,
          child: Column(
            children: [
              Text("100",style: TextStyle(color: Colors.white, fontSize: 30.0),),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Active Users",style: TextStyle(color: Colors.white, fontSize: 15.0),),
            ],
          )
      ),
    );
  }
}

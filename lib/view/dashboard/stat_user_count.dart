import 'package:flutter/material.dart';

class StatUserCount extends StatefulWidget {
  const StatUserCount({Key? key}) : super(key: key);

  @override
  _StatUserCountState createState() => _StatUserCountState();
}

class _StatUserCountState extends State<StatUserCount> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Container(
          height: 100,
          margin: const EdgeInsets.only(top:10, right: 10, bottom:0, left:5),
          padding: const EdgeInsets.all(15),
          color: Colors.indigo,
          child: Column(
            children: <Widget>[
              Text("1000",style: const TextStyle(color: Colors.white, fontSize: 30.0),),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Total Users",style: TextStyle(color: Colors.white, fontSize: 15.0),),
            ],
          )
      ),
    );
  }
}

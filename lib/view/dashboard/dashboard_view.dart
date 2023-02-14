import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/dashboard/active_users/active_user_view.dart';
import 'package:mikrotik_manager/view/dashboard/code_generator/code_generator_view.dart';
import 'package:mikrotik_manager/view/dashboard/dashboard_controller.dart';
import 'all_user.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardController dashboard = DashboardController();
  int index = 0;


  Widget _DialogWithTextField(BuildContext context) => Container(
        padding: EdgeInsets.all(20),
        height: 250,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            FormHelper.inputField(
                dashboard.customUser,
                "User Account",
                false,
                true,
                TextInputType.text,
                TextInputAction.next,
                dashboard.customUserFocus),
            const SizedBox(
              height: 20,
            ),
            FormHelper.inputField(
                dashboard.customTime,
                "Custom Time",
                false,
                true,
                TextInputType.number,
                TextInputAction.done,
                dashboard.customTimeFocus),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FormHelper.button2('Cancel', (){
                  Navigator.of(context).pop();
                }),
                FormHelper.button2('Save', (){
                  dashboard.addUser();
                  return Navigator.of(context).pop(true);
                })
              ],
            ),
          ],
        ),
      );
  displayDialog() {
    return showDialog(
        context: dashboard.ctx,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }

  List<Widget> screens = [
    const AllUser(),
    const ActiveUserView(),
    const CodeGeneratorView(),
  ];
  @override
  Widget build(BuildContext context) {
    dashboard.ctx = context;
    return SafeArea(
        child: Scaffold(
          body: screens[index],
          floatingActionButton: Visibility(
            child: FloatingActionButton(
                onPressed: () {
                displayDialog();
              },
              child: const Icon(Icons.person_add),
              backgroundColor: Colors.indigo,
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            height: 60,
            onDestinationSelected: ( i ){
              log(index.toString());
              setState(() {
                index = i;
              });
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.supervised_user_circle), label: "All Users"),
              NavigationDestination(icon: Icon(Icons.online_prediction), label: "Online Users"),
              NavigationDestination(icon: Icon(Icons.code_off_outlined), label: "Code Generator")
            ],
          ),
    ));
  }
}

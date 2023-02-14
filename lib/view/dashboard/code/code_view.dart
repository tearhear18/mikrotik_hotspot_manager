import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/config.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/dashboard/code/code_controller.dart';

class CodeView extends StatefulWidget {
  const CodeView({Key? key}) : super(key: key);

  @override
  _CodeViewState createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  CodeController codeController = CodeController();
  bool loading = true;

  Widget _DialogWithTextField(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        height: 180,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            FormHelper.inputField(
                codeController.customTime,
                "Hours",
                false,
                true,
                TextInputType.number,
                TextInputAction.done,
                codeController.customTimeFocus),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FormHelper.elevatedButton("Minus Time", () {
                  int hour = int.parse(codeController.customTime.text.trim());
                  codeController.subCredit(hour);
                  Navigator.pop(context);
                }),
                FormHelper.elevatedButton("Add Time", () {
                  int hour = int.parse(codeController.customTime.text.trim());
                  codeController.addCredit(hour);
                  Navigator.pop(context);
                })
              ],
            ),
          ],
        ),
      );
  displayDialog() {
    return showDialog(
        context: codeController.context,
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

  @override
  Widget build(BuildContext context) {
    codeController.context = context;
    codeController.setStateCallback = () {
      loading = false;
      setState(() {});
    };
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    codeController.getUserInfo(arguments['username']);

    List<Widget> loadTimeButton(List<int> settings) {
      List<Widget> elem = [];
      int count = 1;
      for (var timeButton in settings) {
        elem.add(Flexible(
          fit: FlexFit.loose,
          flex: 5,
          child: FormHelper.button2(
              "$timeButton H", () => {codeController.addCredit(timeButton)}),
        ));
        if (count < settings.length) {
          elem.add(const SizedBox(width: 5));
        }
        count++;
      }
      return elem;
    }

    return SafeArea(
        child: Scaffold(
      body: loading
          ? FormHelper.loadingScreen()
          : Column(children: [
              Container(
                width: double.infinity,
                color: Colors.indigo,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(codeController.userInfo.username,
                        style: const TextStyle(
                            color: Colors.yellow, fontSize: 40)),
                    const SizedBox(height: 5),
                    FormHelper.infoText(
                        'Account Status', codeController.userInfo.status),
                    const SizedBox(height: 5),
                    FormHelper.infoText(
                        'Speed Limit', codeController.userInfo.profile),
                    const SizedBox(height: 5),
                    FormHelper.infoText(
                        'Mac Address', codeController.userInfo.macAddress),
                    const SizedBox(height: 5),
                    FormHelper.infoText(
                        'Time Consumed', codeController.userInfo.uptime),
                    const SizedBox(height: 5),
                    FormHelper.infoText(
                        'Time Limit', codeController.userInfo.uptimeLimit),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 168,
                          child: GridView.count(
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            crossAxisCount: 4,
                            children: List.generate(Config.timeSettings.length, (index) {
                              return InkWell(
                                splashColor: Colors.black,
                                onTap: (){
                                  codeController.addCredit(Config.timeSettings[index]);
                                },
                                child: Card(
                                  elevation: 1,
                                  color: Colors.amber,
                                  child: Center(
                                    child: Text(
                                      '${Config.timeSettings[index]} H'
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: loadTimeButton(Config.timeSettings),
                        // ),

                        // const SizedBox(
                        //   height: 30,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        (codeController.userInfo.status == 'Active')
                            ? FormHelper.button("Disable Account",
                                () => {codeController.disable()})
                            : FormHelper.button("Enable Account",
                                () => {codeController.enable()}),
                        const SizedBox(
                          height: 10,
                        ),
                        FormHelper.button("Remove Mac Address",
                            () => {codeController.removeMac()})
                      ],
                    ),
                  ),
                ),
              )
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialog();
        },
        child: const Icon(Icons.add_box),
        backgroundColor: Colors.indigo,
      ),
    ));
  }
}

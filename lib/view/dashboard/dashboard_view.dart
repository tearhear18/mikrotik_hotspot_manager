import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/dashboard/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  DashboardController dashboard = DashboardController();
  List<String> activeCodes = [];
  List<String> onlineUsers = [];
  bool loading = true;

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

  @override
  Widget build(BuildContext context) {
    dashboard.ctx = context;
    dashboard.setStateCallback = () {
      setState(() {});
      loading = false;
    };
    dashboard.codeVoucher.addListener(() {
      String code = dashboard.codeVoucher.text.toString();
      activeCodes =
          dashboard.codes.where((element) => element.contains(code)).toList();
      setState(() {});
    });
    return SafeArea(
        child: Scaffold(
      body: loading
          ? FormHelper.loadingScreen()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: FormHelper.button("View Active Users", () {
                    Navigator.pushNamed(context, '/active_users');
                  }),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: FormHelper.button("Generate Voucher Code", () {
                    Navigator.pushNamed(context, '/code_generator');
                  }),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: FormHelper.inputField(
                      dashboard.codeVoucher,
                      "Search Code",
                      false,
                      true,
                      TextInputType.text,
                      TextInputAction.next,
                      dashboard.codeVoucherFocus),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: activeCodes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/code',
                                arguments: {'username': activeCodes[index]});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(activeCodes[index]),
                          ),
                        );
                      }),
                ),
              ],
            ),
      floatingActionButton: Visibility(
        visible: !loading,
        child: FloatingActionButton(
          onPressed: () {
            displayDialog();
          },
          child: const Icon(Icons.person_add),
          backgroundColor: Colors.indigo,
        ),
      ),
    ));
  }

  @override
  initState() {
    dashboard.getVouchers();
    // dashboard.getActiveUsers();
    super.initState();
  }
}

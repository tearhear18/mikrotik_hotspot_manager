
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/form_helper.dart';
import 'dashboard_controller.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  DashboardController dashboard = DashboardController();
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  bool loading = true;

  List<String> activeCodes = [];


  void _onRefresh() async {
    // monitor network fetch
    dashboard.setStateCallback = () {
      setState(() {
        _refreshController.refreshCompleted();
      });
    };
    dashboard.getVouchers();
  }

  @override
  Widget build(BuildContext context) {
    dashboard.ctx = context;

    dashboard.setStateCallback = ()=>{
      setState(() {
        activeCodes = dashboard.codes;
        loading = false;
      })
    };

    dashboard.codeVoucher.addListener(() {
      String code = dashboard.codeVoucher.text.toString();
      activeCodes =
          dashboard.codes.where((element) => element.contains(code)).toList();
      setState(() {});
    });
    return loading ? FormHelper.loadingScreen() : Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: FormHelper.inputField(
              dashboard.codeVoucher,
              "Search Code",
              false,
              false,
              TextInputType.text,
              TextInputAction.next,
              dashboard.codeVoucherFocus),
        ),
        Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            header: const WaterDropHeader(),
            onRefresh: _onRefresh,
            enablePullDown: true,
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
        ),
      ],
    );
  }

  @override
  initState() {
    dashboard.getVouchers();
    super.initState();
  }
}

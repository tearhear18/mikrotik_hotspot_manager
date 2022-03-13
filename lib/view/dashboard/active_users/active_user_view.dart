import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mikrotik_manager/common/form_helper.dart';
import 'package:mikrotik_manager/view/dashboard/active_users/active_user_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActiveUserView extends StatefulWidget {
  const ActiveUserView({Key? key}) : super(key: key);

  @override
  _ActiveUserViewState createState() => _ActiveUserViewState();
}

class _ActiveUserViewState extends State<ActiveUserView> {
  ActiveUserController activeUserCtrl = ActiveUserController();
  bool loading = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    activeUserCtrl.setStateCallback = () {
      _refreshController.refreshCompleted();
      setState(() {
        _refreshController.loadComplete();
      });
    };
    activeUserCtrl.getActiveUsers();
  }

  @override
  Widget build(BuildContext context) {
    activeUserCtrl.context = context;
    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          // onLoading: _onLoading,
          child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: activeUserCtrl.activeUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.black26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(activeUserCtrl.activeUsers[index].code),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FormHelper.button3("Lock", () {
                              activeUserCtrl
                                  .lock(activeUserCtrl.activeUsers[index]);
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            FormHelper.button3("Disconnect", () {
                              activeUserCtrl.disconnect(
                                  activeUserCtrl.activeUsers[index]);
                              activeUserCtrl.activeUsers.removeAt(index);
                              setState(() {});
                            }),
                          ],
                        ))
                      ],
                    ));
              }),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeUserCtrl.setStateCallback = () {
      setState(() {
        loading = false;
      });
    };
    activeUserCtrl.getActiveUsers();
  }
}

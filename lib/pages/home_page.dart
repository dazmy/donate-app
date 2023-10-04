import 'package:donate_app/global/constant.dart';
import 'package:donate_app/providers/donate_provider.dart';
import 'package:donate_app/widget/widget_alert_add.dart';
import 'package:donate_app/widget/widget_donate.dart';
import 'package:donate_app/widget/widget_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    DonateProvider donateProvider = Provider.of<DonateProvider>(context, listen: false);
    if (await donateProvider.getAllDonation()) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DonateProvider donateProvider = Provider.of<DonateProvider>(context);


    PreferredSizeWidget header() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            title: const Text("Infaq App"),
            centerTitle: true,
            backgroundColor: Colors.green.withOpacity(0.8),
          ));
    }

    Widget totalDonate() {
      return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Constant.myMargin, vertical: Constant.myMargin * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Infaq : ",
              style: TextStyle(fontSize: 20),
            ),
            Text("Rp. ${donateProvider.totalDonation}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
      );
    }

    Widget listDonate() {
      return Column(
        children: donateProvider.listDonateModel.map((e) {
          return WidgetDonate(donateModel: e,);
        }).toList(),
      );
    }

    Future<void> showDialogAdd() async {
      return showDialog(barrierDismissible: false, context: context, builder: (_) {
        return const WidgetAlertAdd();
      });
    }

    FloatingActionButton myFloatingActionButton() {
      return FloatingActionButton.extended(
        onPressed: showDialogAdd,
        icon: const Icon(Icons.add),
        label: const Text('ADD'),
      );
    }

    refreshThisPage() async {
      await donateProvider.getAllDonation();
      setState(() {});
    }

    return Scaffold(
      appBar: header(),
      body: RefreshIndicator(
        color: Colors.lightBlue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          return refreshThisPage();
        },
        child: SafeArea(
          child: (_isLoading) ? const WidgetLoading() : ListView(
            children: [
              totalDonate(),
              listDonate(),
            ],
          ),
        ),
      ),
      floatingActionButton: myFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

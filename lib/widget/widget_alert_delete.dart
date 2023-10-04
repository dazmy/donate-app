import 'package:donate_app/global/constant.dart';
import 'package:donate_app/providers/donate_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetAlertDelete extends StatefulWidget {
  final int id;
  final String donationName;
  const WidgetAlertDelete({Key? key, required this.donationName, required this.id}) : super(key: key);

  @override
  State<WidgetAlertDelete> createState() => _WidgetAlertDeleteState();
}

class _WidgetAlertDeleteState extends State<WidgetAlertDelete> {
  @override
  Widget build(BuildContext context) {
    DonateProvider donateProvider = Provider.of<DonateProvider>(context);

    handleDeleteDonation() async {
      if (await donateProvider.deleteDonation(widget.id)) {
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/');
      }
    }

    return AlertDialog(
      title: const Text('Hapus Donasi Ini ?',),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(widget.donationName),
          const SizedBox(height: Constant.myMargin,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(onPressed: () {
                Navigator.pop(context);
              }, color: Colors.green.withOpacity(0.8), child: const Text('Cancel',),),
              MaterialButton(onPressed: handleDeleteDonation, color: Colors.red, child: const Text('Hapus',),),
            ],
          ),
        ],
      ),
    );
  }
}

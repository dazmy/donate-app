import 'package:donate_app/models/donate_model.dart';
import 'package:donate_app/providers/donate_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetAlertUpdate extends StatefulWidget {
  final DonateModel donateModel;
  const WidgetAlertUpdate({Key? key, required this.donateModel}) : super(key: key);

  @override
  State<WidgetAlertUpdate> createState() => _WidgetAlertUpdateState();
}

class _WidgetAlertUpdateState extends State<WidgetAlertUpdate> {
  @override
  Widget build(BuildContext context) {
    DateTime donationDate = widget.donateModel.donationDate;
    TextEditingController donationAmountController = TextEditingController(text: widget.donateModel.donationAmountPlus.toString());
    TextEditingController donationNameController = TextEditingController(text: widget.donateModel.donationName);
    TextEditingController donationDateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(donationDate));

    DonateProvider donateProvider = Provider.of<DonateProvider>(context);

    handleUpdateDonation() async {
      if (await donateProvider.updateDonation(donationNameController.text, donationAmountController.text, donationDateController.text, widget.donateModel.id)) {
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/');
      }
    }

    return AlertDialog(
      title: const Text('Edit Donasi',),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.assignment, size: 20,),
                hintText: 'Nama Donasi',
            ),
            controller: donationNameController,
          ),
          const SizedBox(height: 30,),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.attach_money, size: 20,),
                hintText: 'Infaq'
            ),
            controller: donationAmountController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30,),
          TextFormField(
            keyboardType: TextInputType.none,
            controller: donationDateController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_month, size: 20,),
              hintText: 'Pilih Tanggal'
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: donationDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  donationDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
              print(pickedDate);
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
      actions: [
        MaterialButton(onPressed: () {
          Navigator.pop(context);
        }, color: Colors.green[600], child: const Text('Cancel',),),
        MaterialButton(onPressed: handleUpdateDonation, color: Colors.blueAccent, child: const Text('Edit',),),
      ],
    );
  }
}

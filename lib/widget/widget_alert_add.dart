import 'package:donate_app/providers/donate_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WidgetAlertAdd extends StatefulWidget {
  const WidgetAlertAdd({Key? key}) : super(key: key);

  @override
  State<WidgetAlertAdd> createState() => _WidgetAlertAddState();
}

class _WidgetAlertAddState extends State<WidgetAlertAdd> {
  TextEditingController donationAmountController = TextEditingController();
  TextEditingController donationNameController = TextEditingController();
  TextEditingController donationDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DonateProvider donateProvider = Provider.of<DonateProvider>(context);

    handleAddDonate() async {
      if (await donateProvider.insertDonation(donationNameController.text, donationAmountController.text, donationDateController.text)) {
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/');
      }
    }

    return AlertDialog(
      title: const Text('Tambah Donasi',),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.assignment, size: 20,),
                hintText: 'Nama Donasi'
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
              hintText: 'Pilih Tanggal',
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2050),
              );

              if (pickedDate != null) {
                setState(() {
                  donationDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
          ),
          const SizedBox(height: 30,),
        ],
      ),
      actions: [
        MaterialButton(onPressed: () {
          Navigator.pop(context);
        }, color: Colors.green.withOpacity(0.6), child: const Text('Cancel',),),
        MaterialButton(onPressed: handleAddDonate, color: Colors.green[600], child: const Text('Tambah',),),
      ],
    );
  }
}

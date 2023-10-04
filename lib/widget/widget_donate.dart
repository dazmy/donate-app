import 'package:donate_app/global/constant.dart';
import 'package:donate_app/models/donate_model.dart';
import 'package:donate_app/widget/widget_alert_delete.dart';
import 'package:donate_app/widget/widget_alert_update.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetDonate extends StatelessWidget {
  final DonateModel donateModel;
  const WidgetDonate({Key? key, required this.donateModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime donationDate = donateModel.donationDate;
    String formattedDate = DateFormat.yMMMMd().format(donationDate);

    Future<void> showDialogUpdate() async {
      return showDialog(barrierDismissible: false, context: context, builder: (_) {
        return WidgetAlertUpdate(donateModel: donateModel);
      });
    }

    Future<void> showDialogDelete() async {
      return showDialog(context: context, builder: (_) {
        return WidgetAlertDelete(donationName: donateModel.donationName, id: donateModel.id,);
      });
    }

    return Container(
      margin: const EdgeInsets.all(7),
      padding: const EdgeInsets.symmetric(
          vertical: 7, horizontal: Constant.myMargin - 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.black26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donateModel.donationName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  formattedDate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Rp. ${donateModel.donationAmountPlus}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(onTap: showDialogUpdate, child: Icon(Icons.edit, size: 20, color: Colors.green[600],)),
                  const SizedBox(width: 10,),
                  GestureDetector(onTap: showDialogDelete, child: const Icon(Icons.delete, size: 20, color: Colors.red,)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

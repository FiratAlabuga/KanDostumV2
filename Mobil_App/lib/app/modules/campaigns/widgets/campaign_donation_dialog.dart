import 'package:flutter/material.dart';
import 'package:kandostum2/app/shared/helpers/date_helper.dart';

class CampaignDonationDialog {
  static void show(BuildContext context, {String nextDonationDate, Function onConfirm}) {
    final date = DateHelper.parse(nextDonationDate);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    if (DateHelper.format(date) == DateHelper.format(today) || date.isBefore(today)) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _successDialog(context, onConfirm);
        },
      );
    } else {


      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _wrongDialog(context, date.difference(today).inDays);
        },
      );
    }
  }

  static _successDialog(BuildContext context, Function onConfirm) {
    return AlertDialog(
      title: new Text('Bağış yap!'),
      content: new Text(
          'Onayla düğmesine tıklayarak bağış yaptığınızı onaylarsınız. Gerçekten bağışta bulunduysan lütfen onayla butonuna tıkla.'),
      actions: <Widget>[
        FlatButton(
          child: Text('İptal et'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Onayla'),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
        ),
      ],
    );
  }

  static _wrongDialog(BuildContext context, int days) {

    return AlertDialog(
      title: new Text('Bağış yapmaya izin verilmiyor!'),
      content: new Text(
          'Maalesef şu anda bağış yapamazsınız, Tekrar bağışta bulunmanız için $days kaldı.'),
      actions: <Widget>[
        FlatButton(
          child: Text('Tamam'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

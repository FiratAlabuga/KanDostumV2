import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kandostum2/app/modules/faq/controllers/faq_controller.dart';
import 'package:kandostum2/app/modules/faq/widgets/faq_card.dart';
import 'package:kandostum2/app/shared/helpers/chatscreen.dart';
import 'package:kandostum2/app/shared/widgets/containers/busy_container.dart';
import 'package:kandostum2/app/shared/widgets/forms/news_card.dart';
import 'package:provider/provider.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  FaqController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= Provider.of<FaqController>(context);
    _controller.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Frequently Asked Questions'),
          actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => HbrKart()
              ));
            },
            icon: Icon(
              Icons.info
            ),
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          return BusyContainer(
            busy: _controller.busy,
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              shrinkWrap: true,
              itemCount: _controller.faqList.length,
              itemBuilder: (context, index) {
                final faq = _controller.faqList[index];
                return FaqCard(faq: faq);
              },
            ),
            length: _controller.faqList.length,
            icon: Icons.sentiment_dissatisfied,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstScreen()),
    );
      },
      label: Text('Start Conversation'),
      icon: Icon(Icons.thumb_up),
      backgroundColor: Colors.redAccent[300],
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kandostum2/app/modules/campaigns/controllers/campaign_person_controller.dart';
import 'package:kandostum2/app/shared/helpers/validator.dart';
import 'package:kandostum2/app/shared/widgets/containers/photobox.dart';
import 'package:kandostum2/app/shared/widgets/forms/blood_type_input_field.dart';
import 'package:kandostum2/app/shared/widgets/forms/custom_input_field.dart';
import 'package:kandostum2/app/shared/widgets/forms/date_input_field.dart';
import 'package:kandostum2/app/shared/widgets/forms/list_tile_header.dart';
import 'package:kandostum2/app/shared/widgets/forms/submit_button.dart';
import 'package:provider/provider.dart';

class EditorCampaignPersonPage extends StatefulWidget {
  @override
  _EditorCampaignPersonPageState createState() =>
      _EditorCampaignPersonPageState();
}

class _EditorCampaignPersonPageState extends State<EditorCampaignPersonPage> {
  final _formKey = new GlobalKey<FormState>();

  CampaignPersonController _controller;

  final _endDateController = TextEditingController();
  final _bloodTypeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= Provider.of<CampaignPersonController>(context);
  }

  @override
  void dispose() {
    _endDateController.dispose();
    _bloodTypeController.dispose();
    super.dispose();
  }

  _save() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      _controller.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bağış İsteği'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Observer(builder: (_) {
                return PhotoBox(
                  busy: _controller.busy,
                  onChanged: (pictureUrl) {
                    _controller.setPicture(pictureUrl);
                  },
                );
              }),
              ListTileHeader('Hasta Bilgileri', leftPadding: 0.0),
              Observer(builder: (_) {
                return CustomInputField(
                  busy: _controller.busy,
                  label: 'Hasta Adı',
                  onSaved: (value) {
                    _controller.campaign.name = value;
                  },
                  validator: Validator.isNotEmptyText,
                );
              }),
              Observer(builder: (_) {
                return BloodTypeInputField(
                  busy: _controller.busy,
                  controller: _bloodTypeController,
                  label: 'Kan grubu',
                  onSaved: (value) {
                    _controller.campaign.bloodType = value;
                  },
                );
              }),
              ListTileHeader('Kampanya verileri', leftPadding: 0.0),
              Observer(builder: (_) {
                return DateInputField(
                  busy: _controller.busy,
                  controller: _endDateController,
                  label: 'Talebin bitiş tarihi',
                  onSaved: (value) {
                    _controller.campaign.endDate = value;
                  },
                  validator: Validator.isNotEmptyText,
                );
              }),
              Observer(builder: (_) {
                return CustomInputField(
                  busy: _controller.busy,
                  label: 'Konaklama yeri',
                  onSaved: (value) {
                    _controller.campaign.hospitalization = value;
                  },
                  validator: Validator.isNotEmptyText,
                );
              }),
              Observer(builder: (_) {
                return CustomInputField(
                  busy: _controller.busy,
                  label: 'Bağış sitesi',
                  onSaved: (value) {
                    _controller.campaign.location = value;
                  },
                  validator: Validator.isNotEmptyText,
                );
              }),
              SizedBox(height: 20),
              Observer(
                builder: (_) {
                  return SubmitButton(
                    label: 'Kaydet ve İlet',
                    busy: _controller.busy,
                    firstColor: Theme.of(context).accentColor,
                    secondColor: Theme.of(context).primaryColor,
                    onTap: _save,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

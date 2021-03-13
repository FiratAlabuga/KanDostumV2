import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kandostum2/app/shared/helpers/image_helper.dart';
import 'package:kandostum2/app/shared/helpers/snackbar_helper.dart';

class PhotoBox extends StatefulWidget {
  final Function(String) onChanged;
  final bool busy;
  final String initialPhotoPath;

  PhotoBox({this.onChanged, this.busy, this.initialPhotoPath});

  @override
  _PhotoBoxState createState() => _PhotoBoxState();
}

class _PhotoBoxState extends State<PhotoBox> {
  File _image;
  @override
  void initState() {
    super.initState();
    if (widget.initialPhotoPath != null)
      _image = File(widget.initialPhotoPath);
  }

  Future _changeImage(bool camera) async {
    var image = await ImageHelper.getImage(context, camera);
    if (image != null) {
      ImageHelper.uploadImage(
        image: image,
        onSuccess: (pictureUrl) {
          SnackBarHelper.showSuccessMessage(
            context,
            title: 'Başarılı',
            message: 'Resim yükleme tamamlandı.',
          );

          setState(() {
            _image = image;
            if (widget.onChanged != null) {
              widget.onChanged(pictureUrl ?? '');
            }
          });
        },
      );
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                enabled: !widget.busy,
                leading: new Icon(Icons.camera_alt),
                title: new Text('Kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _changeImage(true);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.image),
                title: new Text('Galeri'),
                onTap: () {
                  Navigator.pop(context);
                  _changeImage(false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          _settingModalBottomSheet(context);
        },
        child: Container(
          height: 180.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _image == null ? Text('Fotoğraf Yok.') : Image.file(_image),
            ),
          ),
        ),
      ),
    );
  }
}

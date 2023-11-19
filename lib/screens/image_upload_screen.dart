import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = pickedImage;
      } else {
        print('Nenhuma amostra foi selecionada para análise.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload amostras'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text("Nenhuma amostra foi selecionada para análise.")
                : Image.file(
                    File(_image!.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
              child: Text('Tire uma foto'),
            ),
            ElevatedButton(
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
              child: Text('Selecione da galeria'),
            ),
          ],
        ),
      ),
      floatingActionButton: _image == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                // Add the functionality to send the selected image
              },
              child: Icon(Icons.send),
            ),
    );
  }
}

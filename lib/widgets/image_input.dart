import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
 final Function? onSelectImage;

 ImageInput(this.onSelectImage);
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async{
      final  picker = ImagePicker();
    final  imageFile = await picker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null){
      return;
    }
  setState(() {
    _storedImage = File(imageFile.path);
  });

   final appDir =await syspaths.getApplicationDocumentsDirectory();
   final fileName =path.basename(imageFile.path);
   final savedImage =await _storedImage?.copy('${appDir.path}/${fileName}');
    widget.onSelectImage!(savedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Is Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: FlatButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Take Picture'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        ))
      ],
    );
  }
}

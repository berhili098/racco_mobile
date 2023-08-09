
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: style,
          onPressed: () {
            userProvider.selectImages(context);
          },
          child: const Text('choisir une image'),
        ),
        ElevatedButton(
          style: style,
          onPressed: () {
            // userProvider.addImage(context,
            //       id: "1",
            //       path: base64Encode(userProvider.imagelist[0]));
          },
          child: const Text('Enregistrer une image'),
        ),
        userProvider.image != null
            ? Image.memory(
                   userProvider.image!, 
                fit: BoxFit.cover,
              )
            : Container(),

          const  Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text('Resized',style: TextStyle(fontSize: 20),),
            ),
        userProvider.imagelist.isNotEmpty
            ? Image.memory(
                userProvider.imagelist[0],
                fit: BoxFit.cover,
              )
            : Container(),
      ],
    ));
  }
}

import 'package:flutter/material.dart';

class ImageText extends StatelessWidget {
  final String url;
  final String text;

  ImageText(this.url, this.text); //command n constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('클릭!!!!');

      },
      child: Column(children: [
        Image.network(
          url,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        Text(text),
      ]),
    );
  }
}

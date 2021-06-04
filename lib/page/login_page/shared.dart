import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

class ImageWithText extends StatelessWidget {
  final ImageProvider image;
  final String text;
  final double fontSize;

  const ImageWithText({Key key, this.image, this.text, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image(image: image)),
        AspectRatio(
          aspectRatio: 2.82,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  const CircleButton({
    Key key,
    this.onPressed,
    this.icon,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            height: 50,
            width: 50,
            child: Icon(
              icon,
              size: 40,
              color: (onPressed == null) ? Colors.grey : Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: (onPressed == null)
                ? kSecondaryButtonOfGrey
                : kSecondaryButtonOfWhite,
          ),
        ],
      ),
    );
  }
}

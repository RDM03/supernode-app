import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

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
                color: darkThemeColors.textPrimaryAndIcons,
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
              color: ColorsTheme.of(context).boxComponents,
              shape: BoxShape.circle,
            ),
            height: 50,
            width: 50,
            child: Icon(
              icon,
              size: 40,
              color: (onPressed == null)
                  ? darkThemeColors.textLabel
                  : ColorsTheme.of(context).textPrimaryAndIcons,
            ),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: (onPressed == null)
                ? FontTheme(darkThemeColors).middle.label()
                : FontTheme(darkThemeColors).middle.secondary(),
          ),
        ],
      ),
    );
  }
}

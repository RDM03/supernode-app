import 'package:feedback/src/icon_button.dart';
import 'package:feedback/src/translation.dart';
import 'package:flutter/material.dart';

enum ControlMode {
  draw,
}

/// This is the Widget on the right side of the app when the feedback view
/// is active.
class ControlsColumn extends StatelessWidget {
  ControlsColumn({
    Key key,
    @required this.activeColor,
    @required this.onColorChanged,
    @required this.onUndo,
    @required this.onCloseFeedback,
    @required this.onClearDrawing,
    @required this.colors,
    @required this.translation,
  })  : assert(onColorChanged != null),
        assert(onUndo != null),
        assert(onCloseFeedback != null),
        assert(onClearDrawing != null),
        assert(translation != null),
        assert(
          colors.isNotEmpty,
          'There must be at least one color to draw in colors',
        ),
        assert(colors.contains(activeColor), 'colors must contain activeColor'),
        super(key: key);

  final ValueChanged<Color> onColorChanged;
  final VoidCallback onUndo;
  final VoidCallback onCloseFeedback;
  final VoidCallback onClearDrawing;
  final List<Color> colors;
  final Color activeColor;
  final FeedbackTranslation translation;

  @override
  Widget build(BuildContext context) {
    const isNavigatingActive = false;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          RotatedBox(
            quarterTurns: 1,
            child: MaterialButton(
              key: const Key('draw_button'),
              minWidth: 20,
              child: Text(
                translation.draw,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              onPressed: () {},
            ),
          ),
          for (final color in colors)
            _ColorSelectionIconButton(
              key: ValueKey<Color>(color),
              color: color,
              onPressed: isNavigatingActive
                  ? null
                  : (col) {
                      onColorChanged(col);
                    },
              isActive: activeColor == color,
            ),
          FeedbackIconButton(
            key: const Key('undo_button'),
            icon: Icon(Icons.undo),
            onPressed: isNavigatingActive ? null : onUndo,
          ),
          FeedbackIconButton(
            key: const Key('clear_button'),
            icon: Icon(Icons.delete),
            onPressed: isNavigatingActive ? null : onClearDrawing,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _ColorSelectionIconButton extends StatelessWidget {
  const _ColorSelectionIconButton({
    Key key,
    this.color,
    this.onPressed,
    this.isActive,
  }) : super(key: key);

  final Color color;
  final ValueChanged<Color> onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return FeedbackIconButton(
      icon: Icon(isActive ? Icons.lens : Icons.panorama_fish_eye),
      color: color,
      onPressed: onPressed == null ? null : () => onPressed(color),
    );
  }
}

class _ColumnDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 1,
      color: Theme.of(context).dividerColor,
    );
  }
}

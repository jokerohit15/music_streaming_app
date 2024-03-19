import 'package:flutter/material.dart';

class IconButtonWidget extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPress;
  final bool isDark;

  const IconButtonWidget({
    super.key,
    required this.icon,
    this.onPress,
    required this.isDark,
  });

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  late Color _color;
  late IconData _icon;
  bool _willColorChange = false;

  @override
  void initState() {
    super.initState();
    _icon = widget.icon;
    _color = widget.isDark ? Colors.white : Colors.black;
    _willColorChange = _shouldColorChange(_icon);
  }

  bool _shouldColorChange(IconData icon) {
    return icon == Icons.shuffle ||
        icon == Icons.repeat_one ||
        icon == Icons.favorite_border ||
        icon == Icons.favorite;
  }

  void _toggleIcon() {
    if (_icon == Icons.favorite_border) {
      _icon = Icons.favorite;
    } else if (_icon == Icons.favorite) {
      _icon = Icons.favorite_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (_willColorChange) {
          setState(() {
            _toggleIcon();
            _color = _color == Colors.black || _color == Colors.white ? Colors.red
                : Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
          });
        }
        widget.onPress?.call();
      },
      icon: Icon(
        _icon,
        color: _color,
        size: _icon == Icons.play_arrow ? 40 : 22,
      ),
    );
  }
}

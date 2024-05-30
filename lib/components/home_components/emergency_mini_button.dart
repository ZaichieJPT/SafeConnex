import 'package:flutter/material.dart';

class EMGMiniButton extends StatefulWidget {
  final bool toggle;
  final Alignment alignment;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final String tooltip;

  const EMGMiniButton({
    super.key,
    required this.toggle,
    required this.alignment,
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.tooltip,
  });

  @override
  State<EMGMiniButton> createState() => _EMGMiniButtonState();
}

class _EMGMiniButtonState extends State<EMGMiniButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: widget.toggle
          ? const Duration(milliseconds: 875)
          : const Duration(milliseconds: 275),
      alignment: widget.alignment,
      curve: widget.toggle ? Curves.elasticOut : Curves.easeIn,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 275),
        curve: widget.toggle ? Curves.easeIn : Curves.easeOut,
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(40),
        ),
        child: IconButton(
          tooltip: widget.tooltip,
          onPressed: () {},
          icon: Icon(
            widget.icon,
            color: widget.iconColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

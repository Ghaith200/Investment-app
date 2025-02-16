import 'package:flutter/material.dart';

class DrawerListtile extends StatefulWidget {
  final Text title;
  final Icon icon;
  final Icon TraillerIcon;
  final VoidCallback onTap;
  const DrawerListtile({
    super.key,
    required this.title,
    required this.icon,
    required this.TraillerIcon,
    required this.onTap,
  });

  @override
  State<DrawerListtile> createState() => _DrawerListtileState();
}

class _DrawerListtileState extends State<DrawerListtile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            widget.icon.icon,
            size: 30,
            color: Colors.black,
          )),
      title: widget.title,
    );
  }
}

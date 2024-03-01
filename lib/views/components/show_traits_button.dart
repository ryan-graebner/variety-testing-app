import 'package:flutter/material.dart';

import '../../utilities/ui_config.dart';

class ShowTraitsButton extends StatelessWidget {
  const ShowTraitsButton({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          const Text("Show/Hide Traits",
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: UIConfig.primaryOrange
            ),
          ),
          Icon(icon, size: 24, color: UIConfig.primaryOrange),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String property;
  final Widget icon;
  final void Function()? onTap;
  SettingsTile({super.key, required this.property, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          //Container
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: 110,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    property,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 24
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                onPressed: () {},
                icon: icon,
                style: IconButton.styleFrom(
                  foregroundColor: Colors.red
                ),)
              ],
            ),
          ),
          //Space between tiles
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
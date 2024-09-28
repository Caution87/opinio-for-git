import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opinio/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsTileWithCupertino extends StatelessWidget {
  final String property;
  final CupertinoSwitch cupertinoSwitch;
  final void Function()? onTap;
  SettingsTileWithCupertino({super.key, required this.property, required this.onTap, required this.cupertinoSwitch});

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
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen:false).isLightMode,
                  onChanged: (value) =>
                  Provider.of<ThemeProvider>(context,listen:false).toggleTheme(),)
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

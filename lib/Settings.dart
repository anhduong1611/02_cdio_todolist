import 'package:flutter/cupertino.dart';

class MSettings extends StatefulWidget {
  const MSettings({Key? key}) : super(key: key);

  @override
  State<MSettings> createState() => _MSettingsState();
}

class _MSettingsState extends State<MSettings> {
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: Text("Settings Screen"),
      );

  }
}

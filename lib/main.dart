import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';

late final DBusRemoteObject object;

void main() {
  object = DBusRemoteObject(
    DBusClient.session(),
    'org.freedesktop.Notifications',
    DBusObjectPath('/org/freedesktop/Notifications'),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DBus Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('DBus Demo'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await object.callMethod(
                'org.freedesktop.Notifications',
                'Notify',
                <DBusValue>[
                  // app_name
                  DBusString('Test'),
                  // replaces_id
                  DBusUint32(0),
                  // app_icon
                  DBusString(''),
                  // summary
                  DBusString('Summary'),
                  // body
                  DBusString('Body'),
                  // actions
                  DBusArray.string([]),
                  // hints
                  DBusDict.stringVariant({}),
                  // expire_timeout
                  DBusInt32(-1),
                ],
                replySignature: DBusSignature('u'),
              );
            },
            child: Text('Show notification'),
          ),
        ),
      ),
    );
  }
}

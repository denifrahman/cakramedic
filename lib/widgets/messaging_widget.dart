//import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cakramedic/models/notif_message.dart';

class messaging_widget extends StatefulWidget {
  messaging_widget({Key key}) : super(key: key);

  @override
  _messaging_widgetState createState() {
    return _messaging_widgetState();
  }
}

class _messaging_widgetState extends State<messaging_widget> {
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> message = [];
  @override
  void initState() {
    super.initState();
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async{
////        print("onMessage: $message");
////      var data = json.decode(message);
////        print(data);
//      },
//      onLaunch:  (Map<String, dynamic> message) async{
//        print("onMessage: $message");
//        print(message.length);
//      },
//      onResume:  (Map<String, dynamic> message) async{
//        print("onMessage: $message");
//        print(message.length);
//      },
//    );
//    _firebaseMessaging.requestNotificationPermissions(
//      const IosNotificationSettings(sound: true, badge: true,alert: true)
//    );
//    _firebaseMessaging.getToken().then((token){
//      update(token);
//    });
  }
//  update (String token ){
//    print(token);
//    DatabaseReference databaseReference = new FirebaseDatabase().reference();
//    databaseReference.child('fcm-token/$token').set({"token":token});
//  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: message.length,
        itemBuilder: (context, index) {
          return Container(
            child: Card(
              child: ListTile(
                title: Text('test $message'),
                subtitle: Text('test'),
              ),
            )
          );
        }
        );
  }
}
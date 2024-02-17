import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../commons/common_imports/apis_commons.dart';
import 'constants/constants.dart';
import 'models/firebase_message_model.dart';
import 'models/notification_model.dart';

final notificationProvider = Provider((ref) => MessagingFirebase());

class MessagingFirebase {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  Future<String> getFcmToken() async{
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if(token!=null) {
        return token;
      }else{
        return '';
      }
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  Future<bool> uploadFcmToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      await store
          .collection('register_id')
          .doc(token)
          .set(MessageModel(register_id: token).toJson());

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
// Notifications

  Future<bool> pushNotificationsSpecificDevice({
    required NotificationModel model,
    required String token,
  }) async {
    print(token);
    String dataNotifications = '{ "to" : "$token",'
        '"notification" : {'
        '"title":"${model.title}",'
        '"body":"${model.description}",'
        '"bodyLocKey":"${model.toMap()}",'
        ' },'
        '"data" : {'
        '"screen": "${model.toString()},'
        '},'
        '}';

    try {
      await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
        },
        body: dataNotifications,
      );
      print('Done');

    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
    }
    return true;
  }

  Future<bool> pushNotificationsAllDevice({
    required String title,
    required String body,
    required List<String> registerIds,
  }) async {
    List<String> tempLst = [];
    for (var element in registerIds) {
      print(' "$element" ');
      tempLst.add(' "$element" ');
    }

    try {
      String dataNotifications = '{'
          '"operation": "create",'
          '"notification_key_name": "appUser-testUser",'
          '"registration_ids": $tempLst,'
          '"notification" : {'
          '"title":"$title",'
          '"body":"$body"'
          ' },'
          '}';

      var response = await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
          'project_id': "${Constants.SENDER_ID}"
        },
        body: dataNotifications,
      );
      if (response.body.toString() ==
          '"registration_ids" field cannot be empty') {
        return false;
      } else {
        print(response.body.toString());
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }


  Future<bool> pushNotificationsGroupDevice({
    required WidgetRef ref,
    required BuildContext context,
    required NotificationModel model,
    required List<String> registerIds,
  }) async {
    print('here im !');
    List<String> tempLst = [];
    for (var element in registerIds) {
      tempLst.add(' "$element" ');
    }

    try{
      String dataNotifications = '{'
          '"operation": "create",'
          '"notification_key_name": "appUser-testUser",'
          '"registration_ids": $tempLst,'
          '"notification" : {'
          '"title":"${model.title}",'
          '"body":"${model.description}"'
          ' },'
          '"data": {'
          '"screen": "${model.toMap()}",'
          '}'
          '}';

print("sending notification");
      var response = await http.post(
        Uri.parse(Constants.BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key= ${Constants.KEY_SERVER}',
          'project_id': "${Constants.SENDER_ID}"
        },
        body: dataNotifications,
      );
      if(response.body.toString() == '"registration_ids" field cannot be empty'){
        print(response);
        return false;
      }else{
        return true;
      }

    }catch(e){
      print(e.toString());
      return false;
    }
  }



  Future<String> token() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }

  List<String> ids = [];

  getRegisterIds() async {
    try {
      QuerySnapshot<Map<String, dynamic>> listOfData =
          await store.collection('register_id').get();
      for (int i = 0; i < listOfData.docs.length; i++) {
        listOfData.docs[i].data()['register_id'];
        ids.add(listOfData.docs[i].data()['register_id'].toString());
        // print(ids);
        // print('Hola');
      }
    } catch (e) {
      print(e);
    }
  }
}

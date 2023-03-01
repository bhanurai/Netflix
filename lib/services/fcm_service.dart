import 'dart:convert';
import 'package:http/http.dart' as http;

class FCMService {
  static const String FCMAPI =
      "AAAAyP_5g2k:APA91bEN-BbnLHzXnyF9hat8fUoBfm5fMuLF4YbCCUS31gtHqjyaZIB1thyIsmFEQZcAU7RQgUoxkQv--Xto0le0YDqcB8oo5PWb_tiTy4oylZ75H0-ZMYnnR9M0n2Qdg2y_UrxfxOkw";
  static String makePayLoadWithToken(String? token, Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'to': token,
      'data': data,
      'notification': notification,
    });
  }

  static String makePayLoadWithTopic(String? topic, Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'topic': topic,
      'data': data,
      'notification': notification,
    });
  }

  static Future<void> sendPushMessage(String? token, Map<String, dynamic> data,
      Map<String, dynamic> notification) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$FCMAPI'
        },
        body: makePayLoadWithToken(token, data, notification),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}

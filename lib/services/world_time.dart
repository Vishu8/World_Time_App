import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String hourOffset = data['utc_offset'].substring(1,3);
      String minuteOffset = data['utc_offset'].substring(4,6);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hourOffset), minutes: int.parse(minuteOffset)));
      isDaytime = now.hour > 5 && now.hour < 17 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('Caught error: $e');
      time = 'Could not Print Time';
    }
  }
}
import 'package:http/http.dart';

import '../constants/urls.dart';

class OfferApi {
  static getOffer() async {
    try {
      print('calling api');
      // var request = Request('GET', Uri.parse('http://10.0.2.2:5000/'));
      var request = Request('GET', Uri.parse(baseUrl));

      StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print('api called');
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}

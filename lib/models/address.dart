import 'dart:convert'; // For jsonDecode
import 'package:http/http.dart' as http; // For HTTP requests

class Address {
  String digitalAddress;
  String region;
  String city;
  String district;
  String landmark;
  String phoneNumber;
  String additionalInfo;

  Address({
    required this.digitalAddress,
    required this.region,
    required this.city,
    required this.district,
    required this.landmark,
    this.phoneNumber = '',
    this.additionalInfo = '',
  });

  // Factory constructor to create Address from API JSON data
  factory Address.fromJson(Map<String, dynamic> json) {
    print('gps name is ${json['GPSName']}');
    return Address(
      digitalAddress: json['GPSName'] ?? '',
      region: json['Region'] ?? '',
      city: json['Area'] ?? json['District'] ?? '', // Choose Area or District
      district: json['District'] ?? '',
      landmark: json['Street'] ?? '',
      additionalInfo: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GPSName': digitalAddress,
      'Region': region,
      'Area': city,
      'District': district,
      'Street': landmark,
      'PhoneNumber': phoneNumber,
      'additionalInfo': additionalInfo
    };
  }
}

Future<Address?> fetchAddress(String digitalAddress) async {
  String url = "https://ghanapostgps.sperixlabs.org/get-location";
  String payload = 'address=$digitalAddress';
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  try {
    final response =
        await http.post(Uri.parse(url), headers: headers, body: payload);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['Table'] != null) {
        final data = jsonResponse['data']['Table'][0];
        print('Address Acquired');
        return Address.fromJson(data);
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
  return null;
}

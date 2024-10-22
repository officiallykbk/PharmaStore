import 'package:http/http.dart' as http;
import 'dart:convert';

List Postz = [];

class Posts {
  int id;
  String title;

  Posts({
    required this.id,
    required this.title,
  });

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

// for fetching api file data
Future<void> fetchData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  print(url);

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // print('Data fetched successfully: ${data}');
      for (var item in data) {
        Postz.add(Posts(id: item['id'], title: item['title']));
      }
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

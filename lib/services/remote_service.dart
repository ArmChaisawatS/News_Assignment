import 'package:news_assignment/models/news_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);
    try {
      response.statusCode == 200;
      return postFromJson(response.body);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

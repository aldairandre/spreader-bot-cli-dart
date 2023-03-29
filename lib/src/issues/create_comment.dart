import 'dart:convert';

import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:http/http.dart' as http;

createComment(String owner,String repo,int issue_number) async {

  final dotEnv = DotEnv(filePath:'.env');
  
  final GH_TOKEN = dotEnv.getDotEnv()["GH_TOKEN"];

  final requestBody = {
    "body" : "Dart Cli says, Hello World"
  };
  
  try {

    final url = Uri.https('api.github.com','/repos/$owner/$repo/issues/$issue_number/comments');
    
    http.Response response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $GH_TOKEN'
      }
    );

    if(response.statusCode == 201){
      print('Response status: ${response.statusCode}');
    }else {
      print('Response body: ${response.body}');
    }
  } catch (err) {
    print(err);
  }

}
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  Future<List<dynamic>> getUsers() async {
    final res = await http.get(Uri.parse('$baseUrl/users'));
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getClasses() async {
    final res = await http.get(Uri.parse('$baseUrl/classes'));
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getAnnouncements() async {
    final res = await http.get(Uri.parse('$baseUrl/announcements'));
    return jsonDecode(res.body);
  }

  Future<List<dynamic>> getMenu() async {
    final res = await http.get(Uri.parse('$baseUrl/menu'));
    return jsonDecode(res.body);
  }

  Future<dynamic> createClass(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/classes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> createAnnouncement(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/announcements'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> createOrder(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> createChat(Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chats'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> addChatMessage(String chatId, Map<String, dynamic> data) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chats/$chatId/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(res.body);
  }
}
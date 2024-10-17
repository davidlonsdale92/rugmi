import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ImgurAPI {
  ImgurAPI(this._client);
  final http.Client _client;
  final String baseUrl = 'https://api.imgur.com/3/';

  Future<Map<String, dynamic>?> fetchGallery({
    required String section,
    required String sort,
    required String window,
    required int page,
    required bool showViral,
    required bool showMature,
    required bool albumPreviews,
  }) async {
    final apiUrl = '$baseUrl/gallery/$section/$sort/$window/$page?'
        'showViral=$showViral&mature=$showMature&album_previews=$albumPreviews';

    final clientId = dotenv.env['IMGUR_CLIENT_ID'] ?? '';
    if (clientId.isEmpty) {
      log('Client ID is not set!');
      return null;
    }

    try {
      final response = await _client.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Client-ID $clientId'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Failed to fetch gallery: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching gallery: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> searchImages(String query) async {
    final apiUrl = '$baseUrl/gallery/search?q=$query';

    final clientId = dotenv.env['IMGUR_CLIENT_ID'] ?? '';
    if (clientId.isEmpty) {
      log('Client ID is not set!');
      return null;
    }

    try {
      final response = await _client.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Client-ID $clientId'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        log('Failed to search images: ${response.statusCode}');
      }
    } catch (e) {
      log('Error searching images: $e');
    }
    return null;
  }
}

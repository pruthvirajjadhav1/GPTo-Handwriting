import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class TextRecognitionService {
  final String _apiKey = 'YOUR_GOOGLE_CLOUD_VISION_API_KEY';

  Future<String> detectText(String imagePath) async {
    final imageBytes = await File(imagePath).readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final response = await http.post(
      Uri.parse('https://vision.googleapis.com/v1/images:annotate?key=$_apiKey'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'requests': [
          {
            'image': {'content': base64Image},
            'features': [{'type': 'TEXT_DETECTION'}]
          }
        ]
      }),
    );

    final jsonResponse = jsonDecode(response.body);
    return jsonResponse['responses'][0]['textAnnotations'][0]['description'];
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'add_receipt_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
      imageQuality: 100, 
      maxWidth: 1920,    
      maxHeight: 1080,   
    );

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendImageToApi() async {
    if (_image == null) {
      print('No image selected.');
      return;
    }

    final url = Uri.parse('https://api.mindee.net/v1/products/mindee/expense_receipts/v5/predict');
    final headers = {
      'Authorization': '****',
      'Content-Type': 'multipart/form-data'
    };

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('document', _image!.path));

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> parsedJson = jsonDecode(responseBody);

        double totalAmount = parsedJson['document']['inference']['prediction']['total_amount']['value'];

        print('Total Amount: $totalAmount');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddReceiptPage(totalAmount: totalAmount),
          ),
        );

      } else {
        print('Error: ${response.statusCode} - $responseBody');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddReceiptPage(totalAmount: 195.00),
          ),
        );
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showImageSourceActionSheet(context),
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendImageToApi,
                child: const Text('Send Image to API'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
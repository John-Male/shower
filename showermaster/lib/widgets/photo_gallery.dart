import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoGallery extends StatefulWidget {
  final String entityType;
  final String entityId;

  const PhotoGallery({super.key, required this.entityType, required this.entityId});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  final List<String> _photos = [];

  Future<void> _addPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _photos.add(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _photos.map((path) {
            return Image.file(
              File(path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          icon: const Icon(Icons.camera_alt),
          label: const Text('Add Photo'),
          onPressed: _addPhoto,
        ),
      ],
    );
  }
}

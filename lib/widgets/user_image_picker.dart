import 'package:flutter/material.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: null, // Placeholder for the image
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () {
            // Logic to pick an image will go here
          },
          icon: const Icon(Icons.image),
          label: Text('Add Image',style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),),
        ),
      ],
    );
  }
}
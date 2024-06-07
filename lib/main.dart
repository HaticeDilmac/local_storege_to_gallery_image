import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/image_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SaveImage(),
    );
  }
}

class SaveImage extends StatefulWidget {
  const SaveImage({super.key});

  @override
  State<SaveImage> createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  final ImageController _controller = Get.put(ImageController());

  @override
  void initState() {
    super.initState();
    _controller.getData(); //kaydedilen resmi getir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: const Text('Image Saver To Gallery')),
      backgroundColor: const Color.fromARGB(255, 231, 231, 231),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Obx(
              () => ClipOval(
                  child: Image.file(
                File(_controller.imgPath!
                    .value), //controller içersindeki resim yolunun değerini geti
                cacheWidth: 90,
                cacheHeight: 90,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI='));
                },
              )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.pickImage(); //resmi galeriden çek ve kaydet
                });
              },
              child: const Text('Resim Seç'))
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/HomeController.dart';

Widget buildAddPersonDialog() {
  final HomeController controller = Get.find();

  return Obx(() => AlertDialog(
        title: const Text('Add Details of Lost Person'),
        content: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children: [
            SizedBox(
              height: 60,
              width: 100,
              child: TextButton(
                child: (controller.isImageSelected.value == false)
                    ? const Icon(Icons.add_a_photo_outlined, size: 50)
                    : Image.file(
                        controller.selectedImage!,
                      ),
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    controller.selectImage(File(pickedFile.path));
                  }
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) => controller.name.value = value,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) => controller.address.value = value,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Contact Details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) => controller.contactDetails.value = value,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Details',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) => controller.details.value = value,
            ),
            // Repeat the above TextField for Address, Contact Details, and Details
          ],
        ),
        actions: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: const Color.fromARGB(255, 109, 64, 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Cancel'),
            ),
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
                onPressed: () {
                  controller.submitData();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: const Color(0xffF5AA41),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: (controller.isLoading.value)
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.black,
                      ))
                    : const Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      )),
          ),
        ],
      ));
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../const/style.dart';
import '../env.dart';

class HomeController extends GetxController {
  String baseUrl = Keys.apiBase;

  File? selectedImage;
  RxBool isLoading = false.obs;
  RxBool isfinding = false.obs;
  RxString name = ''.obs;
  RxString address = ''.obs;
  RxString contactDetails = ''.obs;
  RxString details = ''.obs;
  RxBool isImageSelected = false.obs;

  void selectImage(File image) {
    selectedImage = image;
    isImageSelected.value = true;

    update();
  }

  void submitData() async {
    // Validate the image
    if (selectedImage == null) {
      // Handle error, image not selected
      Get.snackbar("No Image", "Please select Image");
      return;
    } else {}

    // Validate the form fields
    if (name.value.isEmpty ||
        address.value.isEmpty ||
        contactDetails.value.isEmpty ||
        details.value.isEmpty) {
      // Handle error, form fields not filled
      print(address.value);
      Get.snackbar("Data empty", "Fill all details please");
      return;
    }

    isLoading.value = true;

    try {
      // Perform the API request and handle the response
      // Replace this with your _uploadImage logic
      await _uploadImage();
    } catch (e) {
      Get.snackbar("Error", "Facing error:$e");
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _uploadImage() async {
    isLoading.value = true;

    try {
      String url = "$baseUrl/save_data";

      // Create the request body
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields['name'] = name.value;
      request.fields['address'] = address.value;
      request.fields['contact_details'] = contactDetails.value;
      request.fields['details'] = details.value;

      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage!.path));

      // Send the request and wait for the response
      var response = await request.send();
      Get.back();
      var responseBody = await response.stream.bytesToString();
      print(responseBody.toString());
      // Handle the response
      if (response.statusCode == 200) {
        if (responseBody.toString().contains("Data saved successfully")) {
          Get.snackbar("Success", "Data added successfully");
        }
      } else {
        Get.snackbar("Error", "Facing error. Status: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void findData() async {
    File? selectedImage;
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      isfinding.value = true;
      var url = Uri.parse('baseUrl/find');

      var request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image', selectedImage.path));

      var response = await request.send();
      print("response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var userData = json.decode(responseBody);

        // Show the GetX dialog with the user data
        Get.defaultDialog(
          title: 'User Details',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextWidget(
                text: 'Name: ${userData['name']}',
              ),
              TextWidget(
                text: 'Address: ${userData['address']}',
              ),
              TextWidget(
                text: 'Contact Details: ${userData['contact_details']}',
              ),
              TextWidget(
                text: 'Details: ${userData['details']}',
              ),
              Card(
                  child: Image.memory(
                base64Decode(userData['image']),
                fit: BoxFit.fill,
                height: 200,
                width: 200,
              )),
            ],
          ),
        );
      } else {
        // Handle error cases
      }
    }
    isfinding.value = false;
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
  });

  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: mediumFont,
      ).paddingAll(5),
    ).paddingAll(3);
  }
}

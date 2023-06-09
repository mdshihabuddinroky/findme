import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/style.dart';
import '../../controller/HomeController.dart';
import '../../widgets/addDialouge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Lost and Found',
          style: bigFontBlack,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => buildAddPersonDialog(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: const Color(0xffF5AA41),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Obx(
                  () => controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Text(
                            'Add Details of Lost Person',
                            style: bigFont,
                          ),
                        ),
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.findData();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: const Color(0xffF5AA41),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Obx(() => Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: controller.isfinding.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Find Details of Lost Person', style: bigFont),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

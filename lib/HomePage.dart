import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prompt = TextEditingController();

  Dio dio = new Dio();

  // postData() async {
  Future postData() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    print("called");
    final String urlPath = "http://10.0.2.2:5000/openai/generateimage";

    dynamic data = {"prompt": prompt.text};

    var response = await dio.post(urlPath, data: data);

    return response.data;
  }

  String imageUrl =
      "https://e1.pxfuel.com/desktop-wallpaper/188/66/desktop-wallpaper-plain-white-backgrounds-full-full-white-thumbnail.jpg";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("OPENAI Image Generator")),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Enter The Image Description",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 0, 5),
                      child: TextField(
                        showCursor: true,
                        controller: prompt,
                        decoration: InputDecoration(
                            // labelText: "Enter the image Description",
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await postData().then((value) {
                        setState(() {
                          imageUrl = value["data"].toString();
                          Navigator.of(context).pop();
                        });
                      });
                    },
                    child: const Text("Submit")),
                SizedBox(
                  height: 20,
                ),
                SafeArea(
                    child: Image.network(
                  imageUrl,
                  scale: 3.6,
                )),
              ],
            ),
          )),
    );
  }
}

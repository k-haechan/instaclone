import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePopUp extends StatelessWidget {
  final String? title;
  final String? message;
  final Function()? okCallback;
  final Function()? cancelCallback;

  MessagePopUp(
      {super.key,
      required this.title,
      required this.message,
      required this.okCallback,
      this.cancelCallback});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 투명도를 줌
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.white,
              width: Get.width * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
                  Text(
                    title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black),
                  ),
                  Text(
                    message!,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: okCallback, child: Text('OK')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: cancelCallback,
                        child: Text('Cancel'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

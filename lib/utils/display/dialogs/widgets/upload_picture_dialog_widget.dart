
import 'package:flutter/material.dart';

class UploadPictureDialogWidget extends StatelessWidget {
  const UploadPictureDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: Colors.transparent,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    const Text(
                      'Choose',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context, 'camera');
                              },
                              tooltip: 'Camera',
                              icon: const SizedBox(
                                height: 34,
                                width: 34,
                                child: Icon(Icons.camera),
                              ),
                            ),
                            const Text('Camera'),
                          ],
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context, 'gallery');
                              },
                              tooltip: 'Gallery',
                              icon: const SizedBox(
                                height: 34,
                                width: 34,
                                child: Icon(Icons.photo),
                              ),
                            ),
                            const Text('Gallery'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Positioned(
                  top: -70,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 90,
                    width: 90,
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'assets/images/png/upload.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:client/core/theme/app_pallate.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  TextEditingController songNameController = TextEditingController();
  TextEditingController artistNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    songNameController.dispose();
    artistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                // https://blog.wavezoo.com/wp-content/uploads/2022/03/top_female_djs_world.webp
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : DottedBorder(
                        color: Pallete.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        child: const SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select the thumbnail for your song',
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio!.path)
                  : CustomField(
                      hintText: 'Pick Song',
                      controller: null,
                      readOnly: true,
                      onTap: selectAudio,
                      suffixIcon: Icon(Icons.music_note),
                    ),
              const SizedBox(
                height: 20,
              ),
              const CustomField(
                hintText: 'Artist',
                controller: null,
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomField(
                hintText: 'Song Name',
                controller: null,
              ),
              const SizedBox(
                height: 20,
              ),
              ColorPicker(
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                color: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

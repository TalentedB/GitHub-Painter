import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_painter/cubit/grid_cubit.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:time/time.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:file_picker/file_picker.dart';

class GreenIntensity {
  int _val;

  GreenIntensity(this._val) : assert(_val >= 0 && _val <= 4);

  void increment() {
    if (_val < 4) {
      _val++;
    } else {
      throw Exception("Green intensity cannot be greater than 4");
    }
  }

  int value() => _val;

  Color color() {
    switch (_val) {
      case 0:
        return const Color.fromARGB(255, 22, 27, 34);
      case 1:
        return const Color.fromARGB(255, 14, 68, 41);
      case 2:
        return const Color.fromARGB(255, 0, 109, 50);
      case 3:
        return const Color.fromARGB(255, 38, 166, 65);
      case 4:
        return const Color.fromARGB(255, 57, 211, 83);
      default:
        throw Exception("Green intensity must be between 0 and 4");
    }
  }

  void setValue(int newValue) {
    if (newValue >= 0 && newValue <= 4) {
      _val = newValue;
    } else {
      throw Exception("Green intensity must be between 0 and 4");
    }
  }

  void decrement() {
    if (_val > 0) {
      _val--;
    } else {
      throw Exception("Green intensity cannot be less than 0");
    }
  }
}

class ConvertService {
  int convertColor(int color) {
    if (color < 51) {
      return 0;
    } else if (color < 102) {
      return 1;
    } else if (color < 153) {
      return 2;
    } else if (color < 204) {
      return 3;
    } else {
      return 4;
    }
  }

  Future<FilePickerResult?> pickImg() async {
    return await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image, allowMultiple: false);
  }

  List<List<GreenIntensity>> imageToContributionGrid(
      img.Image image, int year) {
    final temp = List.generate(
        7,
        (j) => List.generate(
            52,
            (i) =>
                GreenIntensity(convertColor(image.getPixel(i, j).r as int))));
    convertContributionGridToShell(temp, year);
    return temp;
  }

  // Future<ui.Image> createProccessedImage(
  //     BuildContext context, XFile? path) async {
  //   print(path!.path.toString());
  //   return rootBundle.load(path!.path).then((value) async {
  //     ByteData bytes = value;
  //     img.Image? image = img.decodePng(bytes.buffer.asUint8List());
  //     image = img.grayscale(image!);

  //     image = img.pixelate(image, size: image.width ~/ 53);
  //     image = img.copyResize(image, width: 53, height: 7);

  //     context.read<GridCubit>().setGrid(imageToContributionGrid(image), "...");
  //     return await convertImageToFlutterUi(
  //         img.copyResize(image, width: 53 * 100, height: 7 * 100));
  //   });
  // }

  void createProccessedImage(
      BuildContext context, FilePickerResult? path, int year) async {
    Uint8List? bytes = path!.files.first.bytes;
    img.Image? image = img.decodePng(bytes!);
    image = img.grayscale(image!);

    image = img.pixelate(image, size: image.width ~/ 53);
    image = img.copyResize(image, width: 53, height: 7);

    context
        .read<GridCubit>()
        .setGrid(imageToContributionGrid(image, year), "...");
  }

  Future<ui.Image> convertImageToFlutterUi(img.Image image) async {
    if (image.format != img.Format.uint8 || image.numChannels != 4) {
      final cmd = img.Command()
        ..image(image)
        ..convert(format: img.Format.uint8, numChannels: 4);
      final rgba8 = await cmd.getImageThread();
      if (rgba8 != null) {
        image = rgba8;
      }
    }

    ui.ImmutableBuffer buffer =
        await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
        height: image.height,
        width: image.width,
        pixelFormat: ui.PixelFormat.rgba8888);

    ui.Codec codec = await id.instantiateCodec(
        targetHeight: image.height, targetWidth: image.width);

    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;

    return uiImage;
  }

  String convertContributionGridToShell(
      List<List<GreenIntensity>> grid, int year) {
    String shell = "";
    final currentInjectionDayStart = DateTime(year, 01, 01);

    int counter = 0;
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[0].length; j++) {
        int commits = grid[i][j].value();
        for (int k = 0; k < commits; k++) {
          final TimeOfDay = DateTime.now() - 1.days;
          shell += "touch commitChange.txt\n";
          shell += "echo \"$TimeOfDay\" >> commitChange.txt\n";
          shell += "git add .\n";
          final currentInjectionDay =
              currentInjectionDayStart + counter.days + i.seconds + j.seconds;
          shell +=
              "git commit --amend --date=\"$currentInjectionDay\" -m \"$currentInjectionDay\"\n";
          shell += "git push\n";
        }
        counter++;
        shell += "\n";
      }
      // shell += "\n";
    }
    // print(shell);
    // File('assets/images/temptest.sh').writeAsString(shell);
    return shell;
  }
}

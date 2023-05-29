import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_painter/cubit/grid_cubit.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:time/time.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

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
        return const Color.fromARGB(255, 7, 7, 7);
      case 1:
        return Colors.green[100]!;
      case 2:
        return Colors.green[300]!;
      case 3:
        return Colors.green[500]!;
      case 4:
        return Colors.green[700]!;
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
    if (color < 63.75) {
      return 4;
    } else if (color < 127.5) {
      return 3;
    } else if (color < 191.25) {
      return 2;
    } else if (color < 255) {
      return 1;
    } else {
      return 0;
    }
  }

  List<List<GreenIntensity>> imageToContributionGrid(img.Image image) {
    final temp = List.generate(
        7,
        (j) => List.generate(
            52,
            (i) =>
                GreenIntensity(convertColor(image.getPixel(i, j).r as int))));
    convertContributionGridToShell(temp);
    return temp;
  }

  Future<ui.Image> createProccessedImage(
      BuildContext context, String path) async {
    ByteData bytes = await rootBundle.load('assets/images/image5.png');
    // img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    image = img.grayscale(image!);

    image = img.pixelate(image, size: image.width ~/ 53);
    image = img.copyResize(image, width: 53, height: 7);

    context.read<GridCubit>().setGrid(imageToContributionGrid(image));
    return await convertImageToFlutterUi(
        img.copyResize(image, width: 53 * 100, height: 7 * 100));
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

  /*
  touch commitChange.txt
  echo "Exact Current Time" >> commitChange.txt
  git add .
  git commit --amend --date="2023-04-26 20:12:20" -m "committing"
  git push
  */

  void convertContributionGridToShell(List<List<GreenIntensity>> grid) {
    String shell = "";
    final currentInjectionDayStart = DateTime(2019, 01, 01);

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
              "git commit --amend --date=\"$currentInjectionDay\" -m \"committing\"\n";
          shell += "git push\n";
        }
        counter++;
        shell += "\n";
      }
      // shell += "\n";
    }
    print(shell);
  }
}

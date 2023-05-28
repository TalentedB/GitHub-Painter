import 'package:flutter/services.dart' show ByteData, rootBundle;

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
  List<List<int>> imageToContributionGrid() {
    // throw UnimplementedError();
    testimage();
    return [[]];
  }

  Future<void> testimage() async {
    // Read a jpeg image from file.
    // final image = img.decodePng(File('assets/images/image1.png').readAsBytesSync());
    // final image = img.decodePng(html.File('assets/images/image1.png'.codeUnits, 'assets/images/image1.png'));
    // print(image);
    ByteData bytes = await rootBundle.load('assets/images/image1.png');
    // print(bytes);
    img.Image? image = img.decodePng(bytes.buffer.asUint8List());
    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
    print("test?");
    // final thumbnail = img.copyResize(image!, width: 120);
    // // Save the thumbnail to a jpeg file.
    print(image?.getPixel(0, 0));
    final pngBytes = img.encodePng(image!);
    // print(pngBytes);
    // final file = File('thumbnail.png')..writeAsBytesSync(pngBytes);

    // print("tried encoding as png");
    // // Encode the thumbnail to a png.
    // img.encodePngFile("assets/images/test.png", image);
    print("tried encoding as png");
    img.encodeImageFile("assets/images/test.png", image);
    print("tasdjaiusdaoisdja");

    // // print(thumbnail);R
    // // final output = img.encodePng(image!);
    // // final output = img.encodePngFile(image!);
    // print("about to write");
    // img.encodeImageFile('assets/images/test.png', image!);
    // print("testidk");
  }
}

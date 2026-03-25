import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DrawPage(),
    );
  }
}

class DrawPage extends StatefulWidget {
  const DrawPage({super.key});

  @override
  State<DrawPage> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final imageData = await rootBundle.load('assets/DESKTOP3.png');
    final codec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
    );
    final frame = await codec.getNextFrame();
    setState(() {
      image = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Graphics')),
      body: CustomPaint(painter: ShapePainter(image), child: Container()),
    );
  }
}

class ShapePainter extends CustomPainter {
  final ui.Image? image;

  ShapePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(150, 150), 50, paint);
    canvas.drawRect(const Rect.fromLTWH(50, 250, 200, 100), paint);

    // Draw image from assets
    if (image != null) {
      canvas.drawImage(image!, const Offset(50, 50), Paint());
    }

    final path = Path();
    path.moveTo(150, 400);
    path.lineTo(200, 450);
    path.lineTo(100, 450);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

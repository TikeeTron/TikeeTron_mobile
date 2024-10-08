import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../common/utils/extensions/size_extension.dart';
import '../../../core/routes/app_route.dart';

class ScanQrBottomSheet extends StatefulWidget {
  const ScanQrBottomSheet({super.key});

  @override
  State<ScanQrBottomSheet> createState() => _ScanQrBottomSheetState();
}

class _ScanQrBottomSheetState extends State<ScanQrBottomSheet> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  StreamSubscription<Object?>? _subscription;
  MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );
  bool readyScan = true;
  bool isPopup = false;
  bool _isProcessing = false;

  void _handleBarcode(BarcodeCapture barcodeCapture) async {
    if (_isProcessing) return;

    final barcode = barcodeCapture.barcodes.firstOrNull;

    if (barcode?.rawValue != null) {
      _isProcessing = true;
      WidgetsBinding.instance.addObserver(this);
      try {
        readyScan = false;

        Navigator.of(context).pop(barcode?.rawValue);
      } catch (e) {
        readyScan = true;
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  Widget _buildScanWindow(Rect scanWindowRect) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        if (!value.isInitialized || !value.isRunning || value.error != null || value.size.isEmpty) {
          return const SizedBox();
        }

        return CustomPaint(
          painter: ScannerOverlay(
            scanWindowRect,
            borderRadius: 16.0,
            borderSide: const BorderSide(
              color: Colors.white,
              width: 4.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(const Offset(0, -100)),
      width: 200,
      height: 200,
    );

    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: controller,
              scanWindow: scanWindow,
              errorBuilder: (context, error, child) {
                return const SizedBox();
              },
            ),
          ),
          _buildScanWindow(scanWindow),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              if (!value.isInitialized || !value.isRunning || value.error != null) {
                return const SizedBox();
              }

              return CustomPaint(
                painter: _ScannerOverlay(
                  scanWindow: scanWindow,
                  borderRadius: 16,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  double get cutOutSize {
    if ((context.width ?? 0) < 400 || (context.height ?? 0) < 400) {
      return 220.0;
    }

    return 280.0;
  }
}

class _ScannerOverlay extends CustomPainter {
  const _ScannerOverlay({
    required this.scanWindow,
    required this.borderRadius,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(_ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow || borderRadius != oldDelegate.borderRadius;
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(
    this.scanWindow, {
    this.borderRadius = 12.0,
    this.borderSide = BorderSide.none,
    this.backgroundColor = Colors.black,
    this.backgroundOpacity = 0.3,
  });

  final Rect scanWindow;
  final double borderRadius;
  final BorderSide borderSide;
  final Color backgroundColor;
  final double backgroundOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    // Create a rounded rectangle for the cutout
    final cutoutRRect = RRect.fromRectAndRadius(
      scanWindow,
      Radius.circular(borderRadius),
    );

    // Background Path (the full canvas area)
    final backgroundPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Path for the scan window (transparent area)
    final cutoutPath = Path()..addRRect(cutoutRRect);

    // Combine the two paths to make the scan window area transparent
    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    // Paint background with color (only outside scan window)
    final backgroundPaint = Paint()
      ..color = backgroundColor.withOpacity(backgroundOpacity)
      ..style = PaintingStyle.fill;

    // Draw background (only outside scan window)
    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    // Draw border in all four corners with border radius
    if (borderSide.style != BorderStyle.none) {
      final borderPaint = Paint()
        ..color = borderSide.color
        ..strokeWidth = 6
        ..style = PaintingStyle.stroke;

      const double cornerLength = 20.0;
      final topLeftArcRect = Rect.fromCircle(
        center: Offset(scanWindow.left + borderRadius, scanWindow.top + borderRadius),
        radius: borderRadius,
      );
      canvas.drawArc(
        topLeftArcRect,
        -3.14, // Starting angle (left side)
        3.14 / 2, // Sweep angle (90 degrees for corner)
        false,
        borderPaint,
      );

      // Border in top-left corner
      canvas.drawLine(
        Offset(scanWindow.left + borderRadius, scanWindow.top),
        Offset(scanWindow.left + borderRadius + cornerLength, scanWindow.top),
        borderPaint,
      );
      canvas.drawLine(
        Offset(scanWindow.left, scanWindow.top + borderRadius),
        Offset(scanWindow.left, scanWindow.top + borderRadius + cornerLength),
        borderPaint,
      );

      // Border in top-right corner with radius
      final topRightArcRect = Rect.fromCircle(
        center: Offset(scanWindow.right - borderRadius, scanWindow.top + borderRadius),
        radius: borderRadius,
      );
      canvas.drawArc(
        topRightArcRect,
        -3.14 / 2, // Starting angle (top side)
        3.14 / 2, // Sweep angle (90 degrees for corner)
        false,
        borderPaint,
      );
      // Border in top-right corner
      canvas.drawLine(
        Offset(scanWindow.right - borderRadius, scanWindow.top),
        Offset(scanWindow.right - borderRadius - cornerLength, scanWindow.top),
        borderPaint,
      );
      canvas.drawLine(
        Offset(scanWindow.right, scanWindow.top + borderRadius),
        Offset(scanWindow.right, scanWindow.top + borderRadius + cornerLength),
        borderPaint,
      );

      // Border in bottom-left corner with radius
      final bottomLeftArcRect = Rect.fromCircle(
        center: Offset(scanWindow.left + borderRadius, scanWindow.bottom - borderRadius),
        radius: borderRadius,
      );
      canvas.drawArc(
        bottomLeftArcRect,
        3.14 / 2,
        3.14 / 2,
        false,
        borderPaint,
      );
      // Border in bottom-left corner
      canvas.drawLine(
        Offset(scanWindow.left, scanWindow.bottom - borderRadius),
        Offset(scanWindow.left, scanWindow.bottom - borderRadius - cornerLength),
        borderPaint,
      );
      canvas.drawLine(
        Offset(scanWindow.left + borderRadius, scanWindow.bottom),
        Offset(scanWindow.left + borderRadius + cornerLength, scanWindow.bottom),
        borderPaint,
      );

      // Border in bottom-right corner with radius
      final bottomRightArcRect = Rect.fromCircle(
        center: Offset(scanWindow.right - borderRadius, scanWindow.bottom - borderRadius),
        radius: borderRadius,
      );
      canvas.drawArc(
        bottomRightArcRect,
        0, // Starting angle (right side)
        3.14 / 2, // Sweep angle (90 degrees for corner)
        false,
        borderPaint,
      );
      // Border in bottom-right corner
      canvas.drawLine(
        Offset(scanWindow.right - borderRadius, scanWindow.bottom),
        Offset(scanWindow.right - borderRadius - cornerLength, scanWindow.bottom),
        borderPaint,
      );
      canvas.drawLine(
        Offset(scanWindow.right, scanWindow.bottom - borderRadius),
        Offset(scanWindow.right, scanWindow.bottom - borderRadius - cornerLength),
        borderPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

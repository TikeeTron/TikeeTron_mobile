import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common.dart';

enum UIDividerVariant {
  solid,
  dash,
}

class UIDivider extends StatelessWidget {
  const UIDivider({
    Key? key,
    this.thickness = 1,
    this.color,
    this.length = double.infinity,
    this.direction = Axis.horizontal,
    this.margin,
    this.variant = UIDividerVariant.solid,
  })  : text = null,
        super(key: key);

  const UIDivider.text(
    this.text, {
    Key? key,
    this.thickness = 1,
    this.color,
    this.margin,
    this.variant = UIDividerVariant.solid,
  })  : length = double.infinity,
        direction = Axis.horizontal,
        super(key: key);

  final double thickness;
  final Color? color;
  final double length;
  final Axis direction;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final UIDividerVariant variant;

  bool get isTextType => text != null;

  @override
  Widget build(BuildContext context) {
    if (!isTextType) return _lineWidget(context);

    return Container(
      margin: margin,
      child: Row(
        children: [
          Expanded(
            child: _lineWidget(context),
          ),
          UIGap.w8,
          _textWidget(context),
          UIGap.w8,
          Expanded(
            child: _lineWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _lineWidget(BuildContext context) {
    if (variant == UIDividerVariant.dash) {
      return Container(
        margin: isTextType ? null : margin,
        child: CustomPaint(
          painter: _DashedLinePainter(
            direction: direction,
            lineLength: direction == Axis.horizontal ? length : thickness,
            dashLength: 4.r,
            dashGap: 2.r,
            thickness: thickness,
            rounded: false,
            color: color ?? context.theme.colors.borderSoft,
          ),
          size: Size(
            direction == Axis.horizontal ? length : thickness,
            direction == Axis.vertical ? length : thickness,
          ),
        ),
      );
    } else {
      return Container(
        width: direction == Axis.horizontal ? length : thickness,
        height: direction == Axis.vertical ? length : thickness,
        margin: isTextType ? null : margin,
        decoration: BoxDecoration(
          color: color ?? context.theme.colors.borderSoft,
        ),
      );
    }
  }

  Widget _textWidget(BuildContext context) {
    return Text(
      text!,
      style: UITypographies.labelSmall(context).copyWith(
        color: context.theme.colors.textTertiary,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({
    required this.direction,
    required this.lineLength,
    required this.dashLength,
    required this.dashGap,
    required this.thickness,
    required this.rounded,
    required this.color,
  });

  final Axis direction;
  double lineLength;
  final double dashLength;
  final double dashGap;
  final double thickness;
  final bool rounded;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (lineLength > size.width && direction == Axis.horizontal) {
      lineLength = size.width;
    } else if (lineLength > size.height && direction == Axis.vertical) {
      lineLength = size.height;
    }

    final isHorizontal = direction == Axis.horizontal;
    final paint = Paint()..color = color;

    final totalDashLength = dashLength + dashGap;
    var numDashes = (lineLength / totalDashLength).floor();
    final remainingSpace =
        lineLength - (dashLength * numDashes + dashGap * (numDashes - 1));

    var firstLastDashLength = 0.0;

    if (remainingSpace == (dashLength + dashGap)) {
      firstLastDashLength = dashLength;
    } else if (remainingSpace > dashLength + dashGap / 2) {
      firstLastDashLength = dashLength / 2;
    } else {
      numDashes--;
      firstLastDashLength = (dashLength + remainingSpace - dashGap) / 2;
    }

    var currentPosition =
        firstLastDashLength > 0 ? firstLastDashLength + dashGap : 0.0;

    if (lineLength >= dashLength * 1.33) {
      _drawDash(canvas, size, 0, isHorizontal, paint, firstLastDashLength);
      _drawDash(
        canvas,
        size,
        lineLength - firstLastDashLength,
        isHorizontal,
        paint,
        firstLastDashLength,
      );

      for (var i = 0; i < numDashes; i++) {
        _drawDash(
          canvas,
          size,
          currentPosition,
          isHorizontal,
          paint,
          dashLength > lineLength - currentPosition
              ? lineLength - currentPosition
              : dashLength,
        );
        currentPosition += totalDashLength;
      }
    } else {
      _drawDash(canvas, size, 0, isHorizontal, paint, lineLength);
    }
  }

  void _drawDash(
    Canvas canvas,
    Size size,
    double position,
    bool isHorizontal,
    Paint paint,
    double length,
  ) {
    final dashRect = isHorizontal
        ? Rect.fromLTWH(position, 0, length, thickness)
        : Rect.fromLTWH(0, position, thickness, length);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        dashRect,
        rounded ? Radius.circular(thickness) : Radius.zero,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.lineLength != lineLength ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.thickness != thickness ||
        oldDelegate.color != color;
  }
}

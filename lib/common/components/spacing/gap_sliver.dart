import 'package:flutter/widgets.dart';

class UIGapSliver {
  /// Constant gap widths
  static const w2 = SliverToBoxAdapter(child: SizedBox(width: 2));
  static const w4 = SliverToBoxAdapter(child: SizedBox(width: 4));
  static const w8 = SliverToBoxAdapter(child: SizedBox(width: 8));
  static const w12 = SliverToBoxAdapter(child: SizedBox(width: 12));
  static const w16 = SliverToBoxAdapter(child: SizedBox(width: 16));
  static const w20 = SliverToBoxAdapter(child: SizedBox(width: 20));
  static const w24 = SliverToBoxAdapter(child: SizedBox(width: 24));
  static const w28 = SliverToBoxAdapter(child: SizedBox(width: 28));
  static const w32 = SliverToBoxAdapter(child: SizedBox(width: 32));
  static const w36 = SliverToBoxAdapter(child: SizedBox(width: 36));
  static const w40 = SliverToBoxAdapter(child: SizedBox(width: 40));
  static const w48 = SliverToBoxAdapter(child: SizedBox(width: 48));
  static const w56 = SliverToBoxAdapter(child: SizedBox(width: 56));
  static const w64 = SliverToBoxAdapter(child: SizedBox(width: 64));
  static const w72 = SliverToBoxAdapter(child: SizedBox(width: 72));
  static const w80 = SliverToBoxAdapter(child: SizedBox(width: 80));

  /// Constant gap heights
  static const h2 = SliverToBoxAdapter(child: SizedBox(height: 2));
  static const h4 = SliverToBoxAdapter(child: SizedBox(height: 4));
  static const h8 = SliverToBoxAdapter(child: SizedBox(height: 8));
  static const h12 = SliverToBoxAdapter(child: SizedBox(height: 12));
  static const h16 = SliverToBoxAdapter(child: SizedBox(height: 16));
  static const h20 = SliverToBoxAdapter(child: SizedBox(height: 20));
  static const h24 = SliverToBoxAdapter(child: SizedBox(height: 24));
  static const h28 = SliverToBoxAdapter(child: SizedBox(height: 28));
  static const h32 = SliverToBoxAdapter(child: SizedBox(height: 32));
  static const h36 = SliverToBoxAdapter(child: SizedBox(height: 36));
  static const h40 = SliverToBoxAdapter(child: SizedBox(height: 40));
  static const h48 = SliverToBoxAdapter(child: SizedBox(height: 48));
  static const h56 = SliverToBoxAdapter(child: SizedBox(height: 56));
  static const h64 = SliverToBoxAdapter(child: SizedBox(height: 64));
  static const h72 = SliverToBoxAdapter(child: SizedBox(height: 72));
  static const h80 = SliverToBoxAdapter(child: SizedBox(height: 80));

  static SliverToBoxAdapter size({double? h, double? w}) => SliverToBoxAdapter(
        child: SizedBox(
          height: h,
          width: w,
        ),
      );
}

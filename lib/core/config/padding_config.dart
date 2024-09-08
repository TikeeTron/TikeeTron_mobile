import 'package:flutter/material.dart';

class Paddings {
  const Paddings(this.value, {Key? key, this.child});
  final double value;
  final Widget? child;

  static const EdgeInsets defaultPadding = EdgeInsets.all(
    24,
  );
  static const EdgeInsets defaultPaddingH = EdgeInsets.symmetric(
    horizontal: 24,
  );
  static const EdgeInsets defaultPaddingV = EdgeInsets.symmetric(
    vertical: 24,
  );
  static const EdgeInsets p0 = EdgeInsets.all(0);
  static const EdgeInsets p1 = EdgeInsets.all(1);
  static const EdgeInsets p2 = EdgeInsets.all(2);
  static const EdgeInsets p4 = EdgeInsets.all(4);
  static const EdgeInsets p6 = EdgeInsets.all(6);
  static const EdgeInsets p8 = EdgeInsets.all(8);
  static const EdgeInsets p10 = EdgeInsets.all(10);
  static const EdgeInsets p11 = EdgeInsets.all(11);
  static const EdgeInsets p12 = EdgeInsets.all(12);
  static const EdgeInsets p14 = EdgeInsets.all(14);
  static const EdgeInsets p16 = EdgeInsets.all(16);
  static const EdgeInsets p18 = EdgeInsets.all(18);
  static const EdgeInsets p20 = EdgeInsets.all(20);
  static const EdgeInsets p22 = EdgeInsets.all(22);
  static const EdgeInsets p24 = EdgeInsets.all(24);
  static const EdgeInsets p26 = EdgeInsets.all(26);
  static const EdgeInsets p28 = EdgeInsets.all(28);
  static const EdgeInsets p30 = EdgeInsets.all(30);
  static const EdgeInsets p32 = EdgeInsets.all(32);
  static const EdgeInsets p40 = EdgeInsets.all(40);
  static const EdgeInsets p44 = EdgeInsets.all(44);
  static const EdgeInsets p48 = EdgeInsets.all(48);
  static const EdgeInsets p52 = EdgeInsets.all(52);
  static const EdgeInsets p56 = EdgeInsets.all(56);
  static const EdgeInsets p60 = EdgeInsets.all(60);
  static const EdgeInsets p64 = EdgeInsets.all(64);
  static const EdgeInsets p72 = EdgeInsets.all(72);
  static const EdgeInsets p80 = EdgeInsets.all(80);
  static const EdgeInsets p96 = EdgeInsets.all(96);

  // Vertical
  static const EdgeInsets v1 = EdgeInsets.symmetric(vertical: 1);
  static const EdgeInsets v2 = EdgeInsets.symmetric(vertical: 2);
  static const EdgeInsets v4 = EdgeInsets.symmetric(vertical: 4);
  static const EdgeInsets v6 = EdgeInsets.symmetric(vertical: 6);
  static const EdgeInsets v8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets v10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets v11 = EdgeInsets.symmetric(vertical: 11);
  static const EdgeInsets v12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets v14 = EdgeInsets.symmetric(vertical: 14);
  static const EdgeInsets v16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets v18 = EdgeInsets.symmetric(vertical: 18);
  static const EdgeInsets v20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets v22 = EdgeInsets.symmetric(vertical: 22);
  static const EdgeInsets v24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets v26 = EdgeInsets.symmetric(vertical: 26);
  static const EdgeInsets v28 = EdgeInsets.symmetric(vertical: 28);
  static const EdgeInsets v30 = EdgeInsets.symmetric(vertical: 30);
  static const EdgeInsets v32 = EdgeInsets.symmetric(vertical: 32);
  static const EdgeInsets v40 = EdgeInsets.symmetric(vertical: 40);
  static const EdgeInsets v44 = EdgeInsets.symmetric(vertical: 44);
  static const EdgeInsets v48 = EdgeInsets.symmetric(vertical: 48);
  static const EdgeInsets v52 = EdgeInsets.symmetric(vertical: 52);
  static const EdgeInsets v56 = EdgeInsets.symmetric(vertical: 56);
  static const EdgeInsets v60 = EdgeInsets.symmetric(vertical: 60);
  static const EdgeInsets v64 = EdgeInsets.symmetric(vertical: 64);
  static const EdgeInsets v72 = EdgeInsets.symmetric(vertical: 72);
  static const EdgeInsets v80 = EdgeInsets.symmetric(vertical: 80);
  static const EdgeInsets v96 = EdgeInsets.symmetric(vertical: 96);

  // Horizontal
  static const EdgeInsets h1 = EdgeInsets.symmetric(horizontal: 1);
  static const EdgeInsets h2 = EdgeInsets.symmetric(horizontal: 2);
  static const EdgeInsets h4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets h6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets h8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets h10 = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets h11 = EdgeInsets.symmetric(horizontal: 11);
  static const EdgeInsets h12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets h14 = EdgeInsets.symmetric(horizontal: 14);
  static const EdgeInsets h16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets h18 = EdgeInsets.symmetric(horizontal: 18);
  static const EdgeInsets h20 = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets h22 = EdgeInsets.symmetric(horizontal: 22);
  static const EdgeInsets h24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets h26 = EdgeInsets.symmetric(horizontal: 26);
  static const EdgeInsets h28 = EdgeInsets.symmetric(horizontal: 28);
  static const EdgeInsets h30 = EdgeInsets.symmetric(horizontal: 30);
  static const EdgeInsets h32 = EdgeInsets.symmetric(horizontal: 32);
  static const EdgeInsets h40 = EdgeInsets.symmetric(horizontal: 40);
  static const EdgeInsets h44 = EdgeInsets.symmetric(horizontal: 44);
  static const EdgeInsets h48 = EdgeInsets.symmetric(horizontal: 48);
  static const EdgeInsets h52 = EdgeInsets.symmetric(horizontal: 52);
  static const EdgeInsets h56 = EdgeInsets.symmetric(horizontal: 56);
  static const EdgeInsets h60 = EdgeInsets.symmetric(horizontal: 60);
  static const EdgeInsets h64 = EdgeInsets.symmetric(horizontal: 64);
  static const EdgeInsets h72 = EdgeInsets.symmetric(horizontal: 72);
  static const EdgeInsets h80 = EdgeInsets.symmetric(horizontal: 80);
  static const EdgeInsets h96 = EdgeInsets.symmetric(horizontal: 96);

  // Bottom Constants
  static const EdgeInsets b0 = EdgeInsets.only(bottom: 1);
  static const EdgeInsets b1 = EdgeInsets.only(bottom: 1);
  static const EdgeInsets b2 = EdgeInsets.only(bottom: 2);
  static const EdgeInsets b4 = EdgeInsets.only(bottom: 4);
  static const EdgeInsets b6 = EdgeInsets.only(bottom: 6);
  static const EdgeInsets b8 = EdgeInsets.only(bottom: 8);
  static const EdgeInsets b10 = EdgeInsets.only(bottom: 10);
  static const EdgeInsets b11 = EdgeInsets.only(bottom: 11);
  static const EdgeInsets b12 = EdgeInsets.only(bottom: 12);
  static const EdgeInsets b14 = EdgeInsets.only(bottom: 14);
  static const EdgeInsets b16 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets b18 = EdgeInsets.only(bottom: 18);
  static const EdgeInsets b20 = EdgeInsets.only(bottom: 20);
  static const EdgeInsets b22 = EdgeInsets.only(bottom: 22);
  static const EdgeInsets b24 = EdgeInsets.only(bottom: 24);
  static const EdgeInsets b26 = EdgeInsets.only(bottom: 26);
  static const EdgeInsets b28 = EdgeInsets.only(bottom: 28);
  static const EdgeInsets b30 = EdgeInsets.only(bottom: 30);
  static const EdgeInsets b32 = EdgeInsets.only(bottom: 32);
  static const EdgeInsets b40 = EdgeInsets.only(bottom: 40);
  static const EdgeInsets b44 = EdgeInsets.only(bottom: 44);
  static const EdgeInsets b48 = EdgeInsets.only(bottom: 48);
  static const EdgeInsets b52 = EdgeInsets.only(bottom: 52);
  static const EdgeInsets b56 = EdgeInsets.only(bottom: 56);
  static const EdgeInsets b60 = EdgeInsets.only(bottom: 60);
  static const EdgeInsets b64 = EdgeInsets.only(bottom: 64);
  static const EdgeInsets b72 = EdgeInsets.only(bottom: 72);
  static const EdgeInsets b80 = EdgeInsets.only(bottom: 80);
  static const EdgeInsets b96 = EdgeInsets.only(bottom: 96);

  // Top Constant
  static const EdgeInsets t1 = EdgeInsets.only(top: 1);
  static const EdgeInsets t2 = EdgeInsets.only(top: 2);
  static const EdgeInsets t4 = EdgeInsets.only(top: 4);
  static const EdgeInsets t5 = EdgeInsets.only(top: 5);
  static const EdgeInsets t6 = EdgeInsets.only(top: 6);
  static const EdgeInsets t8 = EdgeInsets.only(top: 8);
  static const EdgeInsets t10 = EdgeInsets.only(top: 10);
  static const EdgeInsets t11 = EdgeInsets.only(top: 11);
  static const EdgeInsets t12 = EdgeInsets.only(top: 12);
  static const EdgeInsets t14 = EdgeInsets.only(top: 14);
  static const EdgeInsets t16 = EdgeInsets.only(top: 16);
  static const EdgeInsets t18 = EdgeInsets.only(top: 18);
  static const EdgeInsets t20 = EdgeInsets.only(top: 20);
  static const EdgeInsets t22 = EdgeInsets.only(top: 22);
  static const EdgeInsets t24 = EdgeInsets.only(top: 24);
  static const EdgeInsets t26 = EdgeInsets.only(top: 26);
  static const EdgeInsets t28 = EdgeInsets.only(top: 28);
  static const EdgeInsets t30 = EdgeInsets.only(top: 30);
  static const EdgeInsets t32 = EdgeInsets.only(top: 32);
  static const EdgeInsets t40 = EdgeInsets.only(top: 40);
  static const EdgeInsets t44 = EdgeInsets.only(top: 44);
  static const EdgeInsets t48 = EdgeInsets.only(top: 48);
  static const EdgeInsets t52 = EdgeInsets.only(top: 52);
  static const EdgeInsets t56 = EdgeInsets.only(top: 56);
  static const EdgeInsets t60 = EdgeInsets.only(top: 60);
  static const EdgeInsets t64 = EdgeInsets.only(top: 64);
  static const EdgeInsets t72 = EdgeInsets.only(top: 72);
  static const EdgeInsets t80 = EdgeInsets.only(top: 80);
  static const EdgeInsets t96 = EdgeInsets.only(top: 96);

  // Left Constant
  static const EdgeInsets l1 = EdgeInsets.only(left: 1);
  static const EdgeInsets l2 = EdgeInsets.only(left: 2);
  static const EdgeInsets l4 = EdgeInsets.only(left: 4);
  static const EdgeInsets l6 = EdgeInsets.only(left: 6);
  static const EdgeInsets l8 = EdgeInsets.only(left: 8);
  static const EdgeInsets l10 = EdgeInsets.only(left: 10);
  static const EdgeInsets l11 = EdgeInsets.only(left: 11);
  static const EdgeInsets l12 = EdgeInsets.only(left: 12);
  static const EdgeInsets l14 = EdgeInsets.only(left: 14);
  static const EdgeInsets l16 = EdgeInsets.only(left: 16);
  static const EdgeInsets l18 = EdgeInsets.only(left: 18);
  static const EdgeInsets l20 = EdgeInsets.only(left: 20);
  static const EdgeInsets l22 = EdgeInsets.only(left: 22);
  static const EdgeInsets l24 = EdgeInsets.only(left: 24);
  static const EdgeInsets l26 = EdgeInsets.only(left: 26);
  static const EdgeInsets l28 = EdgeInsets.only(left: 28);
  static const EdgeInsets l30 = EdgeInsets.only(left: 30);
  static const EdgeInsets l32 = EdgeInsets.only(left: 32);
  static const EdgeInsets l40 = EdgeInsets.only(left: 40);
  static const EdgeInsets l44 = EdgeInsets.only(left: 44);
  static const EdgeInsets l48 = EdgeInsets.only(left: 48);
  static const EdgeInsets l52 = EdgeInsets.only(left: 52);
  static const EdgeInsets l56 = EdgeInsets.only(left: 56);
  static const EdgeInsets l60 = EdgeInsets.only(left: 60);
  static const EdgeInsets l64 = EdgeInsets.only(left: 64);
  static const EdgeInsets l72 = EdgeInsets.only(left: 72);
  static const EdgeInsets l80 = EdgeInsets.only(left: 80);
  static const EdgeInsets l96 = EdgeInsets.only(left: 96);

  // Rigth Constant
  static const EdgeInsets r0 = EdgeInsets.only(right: 0);
  static const EdgeInsets r1 = EdgeInsets.only(right: 1);
  static const EdgeInsets r2 = EdgeInsets.only(right: 2);
  static const EdgeInsets r4 = EdgeInsets.only(right: 4);
  static const EdgeInsets r6 = EdgeInsets.only(right: 6);
  static const EdgeInsets r8 = EdgeInsets.only(right: 8);
  static const EdgeInsets r10 = EdgeInsets.only(right: 10);
  static const EdgeInsets r11 = EdgeInsets.only(right: 11);
  static const EdgeInsets r12 = EdgeInsets.only(right: 12);
  static const EdgeInsets r14 = EdgeInsets.only(right: 14);
  static const EdgeInsets r16 = EdgeInsets.only(right: 16);
  static const EdgeInsets r18 = EdgeInsets.only(right: 18);
  static const EdgeInsets r20 = EdgeInsets.only(right: 20);
  static const EdgeInsets r22 = EdgeInsets.only(right: 22);
  static const EdgeInsets r24 = EdgeInsets.only(right: 24);
  static const EdgeInsets r26 = EdgeInsets.only(right: 26);
  static const EdgeInsets r28 = EdgeInsets.only(right: 28);
  static const EdgeInsets r30 = EdgeInsets.only(right: 30);
  static const EdgeInsets r32 = EdgeInsets.only(right: 32);
  static const EdgeInsets r40 = EdgeInsets.only(right: 40);
  static const EdgeInsets r44 = EdgeInsets.only(right: 44);
  static const EdgeInsets r48 = EdgeInsets.only(right: 48);
  static const EdgeInsets r52 = EdgeInsets.only(right: 52);
  static const EdgeInsets r56 = EdgeInsets.only(right: 56);
  static const EdgeInsets r60 = EdgeInsets.only(right: 60);
  static const EdgeInsets r64 = EdgeInsets.only(right: 64);
  static const EdgeInsets r72 = EdgeInsets.only(right: 72);
  static const EdgeInsets r80 = EdgeInsets.only(right: 80);
  static const EdgeInsets r96 = EdgeInsets.only(right: 96);
}

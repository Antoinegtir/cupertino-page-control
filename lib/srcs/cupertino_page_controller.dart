import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CupertinoPageControl extends StatelessWidget {
  const CupertinoPageControl({
    super.key,
    this.icon,
    this.name,
    this.function,
    this.brightness,
    required this.isSelect,
    required this.length,
    required this.timer,
    required this.current,
  });

  final Timer? timer;
  final int length;
  final int current;
  final String? name;
  final bool isSelect;
  final IconData? icon;
  final Function()? function;
  final Brightness? brightness;

  static const int kSizeNormalDot = 7;
  static const int kSizeLittleDot = 5;

  static const int kMaxVisibleDot = 5;
  static const int kFirstDot = 0;

  static const Color kDarkBackgroundColor = const Color(0xff3d3d4a);
  static const Color kDarkDotColor = const Color(0xff929398);
  static const Color kLightBackgroundColor = const Color(0xffbebfc4);
  static const Color kLightDotColor = Colors.white;

  double size(int i) {
    if (length <= kMaxVisibleDot) {
      return kSizeNormalDot.toDouble();
    } else {
      if (i == kMaxVisibleDot - 1 && current != length - 1) {
        return kSizeLittleDot.toDouble();
      }
      if (current >= kMaxVisibleDot - 1 && i == kFirstDot) {
        return kSizeLittleDot.toDouble();
      }
      return kSizeNormalDot.toDouble();
    }
  }

  Color color(int i) {
    if (Brightness.dark == brightness) {
      if (length <= kMaxVisibleDot) {
        if (i == current) {
          return kLightDotColor;
        } else {
          return kDarkDotColor;
        }
      } else {
        if (current >= kMaxVisibleDot - 2) {
          if (current == length - 1 && i == kMaxVisibleDot - 1) {
            return kLightDotColor;
          } else {
            if (i == kMaxVisibleDot - 2 && current != length - 1) {
              return kLightDotColor;
            } else {
              return kDarkDotColor;
            }
          }
        } else {
          if (i == current) {
            return kLightDotColor;
          } else {
            return kDarkDotColor;
          }
        }
      }
    } else {
      if (length <= kMaxVisibleDot) {
        if (i == current) {
          return kLightDotColor;
        } else {
          return kLightBackgroundColor;
        }
      } else {
        if (current >= kMaxVisibleDot - 2) {
          if (current == length - 1 && i == kMaxVisibleDot - 1) {
            return kLightDotColor;
          } else {
            if (i == kMaxVisibleDot - 2 && current != length - 1) {
              return kLightDotColor;
            } else {
              return kLightBackgroundColor;
            }
          }
        } else {
          if (i == current) {
            return kLightDotColor;
          } else {
            return kLightBackgroundColor;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: function,
        onLongPress: () {
          HapticFeedback.heavyImpact();
        },
        child: Hero(
          tag: name ?? "",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Brightness.dark == brightness
                    ? kDarkBackgroundColor
                    : kLightBackgroundColor,
                height: 30,
                width: 100,
                alignment: Alignment.center,
                child: Stack(children: [
                  if (!(name == null || icon == null))
                    AnimatedOpacity(
                        opacity: !isSelect ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              size: 12,
                              color: kLightDotColor,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              name!,
                              style: TextStyle(
                                fontSize: 12,
                                color: kLightDotColor,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = kFirstDot;
                          i < length && i < kMaxVisibleDot;
                          i++)
                        Padding(
                          padding: EdgeInsets.only(
                              top: ((name == null || icon == null)) ? 1 : 3.5),
                          child: AnimatedOpacity(
                            opacity: ((name == null || icon == null))
                                ? 1
                                : isSelect
                                    ? 1
                                    : 0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: size(i),
                                  width: size(i),
                                  color: color(i),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ])),
          ),
        ));
  }
}

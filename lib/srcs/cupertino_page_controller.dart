import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CupertinoPageControl extends StatefulWidget {
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
  @override
  _CupertinoPageControlState createState() => _CupertinoPageControlState();
}

class _CupertinoPageControlState extends State<CupertinoPageControl> {
  double size(int i) {
    if (widget.length <= 5) {
      return 7;
    } else {
      if (i == 4 && widget.current != widget.length - 1) {
        return 4;
      }
      if (widget.current >= 4 && i == 0) {
        return 4;
      }
      return 7;
    }
  }

  Color color(int i) {
    if (Brightness.dark == widget.brightness) {
      if (widget.length <= 5) {
        if (i == widget.current) {
          return Colors.white;
        } else {
          return const Color(0xff929398);
        }
      } else {
        if (widget.current >= 3) {
          if (widget.current == widget.length - 1 && i == 4) {
            return Colors.white;
          } else {
            if (i == 3 && widget.current != widget.length - 1) {
              return Colors.white;
            } else {
              return const Color(0xff929398);
            }
          }
        } else {
          if (i == widget.current) {
            return Colors.white;
          } else {
            return const Color(0xff929398);
          }
        }
      }
    } else {
      if (widget.length <= 5) {
        if (i == widget.current) {
          return Colors.white;
        } else {
          return const Color(0xffbebfc4);
        }
      } else {
        if (widget.current >= 3) {
          if (widget.current == widget.length - 1 && i == 4) {
            return Colors.white;
          } else {
            if (i == 3 && widget.current != widget.length - 1) {
              return Colors.white;
            } else {
              return const Color(0xffbebfc4);
            }
          }
        } else {
          if (i == widget.current) {
            return Colors.white;
          } else {
            return const Color(0xffbebfc4);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.function,
        onLongPress: () {
          HapticFeedback.heavyImpact();
        },
        child: Hero(
          tag: widget.name ?? "",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Brightness.dark == widget.brightness
                    ? const Color(0xff3d3d4a)
                    : const Color(0xff929398),
                height: 30,
                width: 100,
                alignment: Alignment.center,
                child: Stack(children: [
                  if (!(widget.name == null || widget.icon == null))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: !widget.isSelect ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Padding(
                            padding: EdgeInsets.only(right: 2),
                            child: Icon(
                              widget.icon,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: !widget.isSelect ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Text(
                            widget.name!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < widget.length && i < 5; i++)
                        Padding(
                          padding: EdgeInsets.only(
                              top:
                                  ((widget.name == null || widget.icon == null))
                                      ? 1
                                      : 3.5),
                          child: AnimatedOpacity(
                            opacity:
                                ((widget.name == null || widget.icon == null))
                                    ? 1
                                    : widget.isSelect
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

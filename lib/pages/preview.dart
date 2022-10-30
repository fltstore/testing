import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';

import '../extensions/string.dart';

class PreviewPageView extends StatefulWidget {
  const PreviewPageView({Key? key}) : super(key: key);

  @override
  State<PreviewPageView> createState() => _PreviewPageViewState();
}

class _PreviewPageViewState extends State<PreviewPageView> {
  bool _rebuild = false;

  late Timer timer;
  late Timer nowTimer;

  int timeNum = 760;

  String nowTimeWithFormat = '';

  @override
  void initState() {
    super.initState();
    rebuildLoop();
    rebuildTime();
  }

  @override
  dispose() {
    super.dispose();
    timer.cancel();
    nowTimer.cancel();
  }

  rebuildLoop() {
    timer = Timer.periodic(
      Duration(milliseconds: timeNum),
      (timer) {
        _rebuild = !_rebuild;
        setState(() {});
      },
    );
  }

  rebuildTime() {
    updateNowTimeWithFormat();
    nowTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateNowTimeWithFormat();
    });
  }

  updateNowTimeWithFormat() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    nowTimeWithFormat = formattedDate;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                ).copyWith(top: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "周立齐",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.2),
                    const Text(
                      "证件号码: 11423423",
                      style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "手机号码: ${'16677777777'.formatPhone}",
                      style: const TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 221, 144, 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: AnimatedScale(
                        scale: _rebuild ? 1 : .88,
                        duration: Duration(
                          milliseconds: timeNum,
                        ),
                        child: AnimatedContainer(
                          duration: Duration(
                            milliseconds: timeNum,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(_rebuild ? 0 : 12),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: QrImage(
                            data: "https://github.com/d1y",
                            padding: const EdgeInsets.all(2.4),
                            backgroundColor: Colors.white,
                            foregroundColor:
                                const Color.fromRGBO(57, 105, 31, 1),
                            version: QrVersions.auto,
                            embeddedImage: Image.asset('assets/nrhc.png').image,
                            size: MediaQuery.of(context).size.width * .6,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "湖南",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          TextSpan(
                            text: "绿码",
                            style: TextStyle(
                              color: Color.fromRGBO(57, 105, 31, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          TextSpan(
                            text: "外省",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          TextSpan(
                            text: "未查验",
                            style: TextStyle(
                              color: Color.fromRGBO(122, 134, 181, 1),
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        context.pop();
                      },
                      child: Text(
                        nowTimeWithFormat,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(72, 110, 246, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 3.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "核酸检测",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        Image.asset(
                          'assets/stay/see.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                        const Text("点击获取数据"),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 3.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "新冠疫苗",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        Image.asset(
                          'assets/stay/see.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                        const Text("点击获取数据"),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

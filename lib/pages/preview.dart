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
              StayItem(
                title: '核酸检测',
                onFetchNew: () {},
                onFetch: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 249, 242, 1),
                    borderRadius: BorderRadius.circular(4.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DefaultTextStyle(
                              style: const TextStyle(
                                color: Color.fromRGBO(67, 151, 78, 1),
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    '24',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4.2),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("阴性"),
                                      Text("小时内"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            DefaultTextStyle(
                              style: const TextStyle(
                                color: Color.fromRGBO(128, 130, 129, 1),
                              ),
                              child: Column(
                                children: const [Text("湘西"), Text("湘西")],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Flutter文本组件添加下划线、删除线",
                              style: TextStyle(
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(67, 151, 78, 1),
                                borderRadius: BorderRadius.circular(2.4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              child: const Text(
                                "更多",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(),
              StayItem(
                title: '新冠疫苗',
                onFetchNew: () {},
                onFetch: () {},
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class StayItem extends StatelessWidget {
  const StayItem({
    Key? key,
    required this.title,
    required this.onFetchNew,
    required this.onFetch,
    this.child,
  }) : super(key: key);

  final String title;
  final VoidCallback onFetchNew;
  final VoidCallback onFetch;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 3.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onFetchNew,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/stay/download.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 2.4),
                    const Text(
                      "点击获取最新数据",
                      style: TextStyle(
                        fontSize: 12.0,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Builder(builder: (context) {
            if (child != null) return child as Widget;
            return GestureDetector(
              onTap: onFetch,
              child: Row(
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
            );
          }),
        ],
      ),
    );
  }
}

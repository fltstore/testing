import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/shared/local_storage.dart';

import '../extensions/string.dart';
import '../config/keys.dart' as keys;
import '../types/index.dart';

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
  String detectDate = '';

  String _name = '';
  String _card = '';
  String _phone = '';
  String _h = ''; // 医院
  String _hName = ''; // 疫苗名称
  CodeType codeType = CodeType.green;
  List<DateTime> pull = [];

  SamplingStatus _samplingStatus = SamplingStatus.last;

  SamplingStatus get samplingStatus => _samplingStatus;

  set samplingStatus(SamplingStatus newVal) {
    _samplingStatus = newVal;
    detectDate = genDetectDate(newVal);
    setState(() {});
  }

  int next(int min, int max) {
    int res = min + Random().nextInt(max - min);
    return res;
  }

  String genDetectDate(SamplingStatus date) {
    DateTime now = DateTime.now();
    if (date == SamplingStatus.last) {
      now = now.subtract(const Duration(minutes: 30));
    } else if (date == SamplingStatus.lD7) {
      now = now.subtract(const Duration(days: 6));
    } else {
      int h = int.tryParse(date.payloadText) ?? 0;
      now = now.subtract(Duration(hours: h));
    }
    int s = next(12, 59);
    now = now.add(Duration(seconds: s));
    return DateFormat('MM月dd日kk时mm分ss秒采样').format(now);
  }

  bool get samplingStatusIsLast {
    return samplingStatus == SamplingStatus.last;
  }

  @override
  void initState() {
    super.initState();
    beforeHook();
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

  syncLocalData() {
    ////////////////////////////
    _name = localStorage.getItem(keys.kName, '周立齐');
    _card = localStorage.getItem(keys.kCard, '');
    _phone = localStorage.getItem(keys.kPhone, '');
    _h = localStorage.getItem(keys.kHospital, '');
    _hName = localStorage.getItem(keys.kHospitalName, '');
    ////////////////////////////

    ////////////////////////////
    int codeTypeIndex = int.tryParse(
          localStorage.getItem(
            keys.kCodeType,
            CodeType.green.index.toString(),
          ),
        ) ??
        0;
    codeType = CodeType.values[codeTypeIndex];
    ////////////////////////////

    ////////////////////////////
    String pullCacheData = localStorage.getItem(keys.kPull1, '');
    var list = pullCacheData
        .split("||")
        .where((element) => element.isNotEmpty)
        .toList();
    List<DateTime> puller = list.map((e) => DateTime.parse(e)).toList();
    pull = puller;
    ////////////////////////////

    setState(() {});
  }

  beforeHook() {
    detectDate = genDetectDate(samplingStatus);
    setState(() {});
    syncLocalData();
    rebuildLoop();
    rebuildTime();
  }

  pickerStatus() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: 42,
            onSelectedItemChanged: (int selectedItem) {
              samplingStatus = SamplingStatus.values[selectedItem];
              setState(() {});
            },
            children: SamplingStatus.values
                .map(
                  (e) => Center(
                    child: Text(
                      e.payloadHumanText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: e.transColor,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(1.2, 1.2),
                            blurRadius: 2.4,
                            color: e.transColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
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
                    Text(
                      _name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 4.2),
                    Text(
                      "证件号码: ${_card.formatToIDCard}",
                      style: const TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "手机号码: ${_phone.formatPhone}",
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
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(253, 254, 189, 1),
                            Color.fromRGBO(239, 206, 106, 1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                        ),
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
                            borderRadius: BorderRadius.circular(
                              _rebuild ? 0 : 12,
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: QrImage(
                            data: "https://github.com/d1y",
                            padding: const EdgeInsets.all(2.4),
                            backgroundColor: Colors.white,
                            foregroundColor: codeType.transColor,
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
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "湖南",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          TextSpan(
                            text: codeType.humanString,
                            style: TextStyle(
                              color: codeType.transColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          const TextSpan(
                            text: "外省",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                            ),
                          ),
                          const TextSpan(
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
                      vertical: 12.0,
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
                                  GestureDetector(
                                    onTap: pickerStatus,
                                    child: Text(
                                      samplingStatus.payloadText,
                                      style: TextStyle(
                                        fontSize:
                                            samplingStatusIsLast ? 24 : 42,
                                        fontWeight: samplingStatusIsLast
                                            ? FontWeight.w300
                                            : FontWeight.bold,
                                        color: samplingStatus.transColor,
                                      ),
                                    ),
                                  ),
                                  if (!samplingStatusIsLast)
                                    const SizedBox(width: 4.2),
                                  if (!samplingStatusIsLast)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Builder(builder: (context) {
                                          var text = '阴性';
                                          if (codeType == CodeType.red) {
                                            text = '阳性';
                                          }
                                          return Text(text);
                                        }),
                                        Builder(builder: (context) {
                                          var msg = '小时内';
                                          if (samplingStatus.payloadText ==
                                              '7') {
                                            msg = '天内';
                                          }
                                          return Text(msg);
                                        }),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(_h),
                                  Text(detectDate),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: !samplingStatusIsLast ? 1 : 0,
                              child: Text(
                                "$_h采样点（10混）采样",
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Color.fromRGBO(51, 51, 51, 1),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: samplingStatus.transColor,
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
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: Color.fromRGBO(173, 173, 173, 1),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: pull
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.4,
                              ),
                              child: Row(
                                children: [
                                  Builder(builder: (context) {
                                    String now =
                                        DateFormat('yyyy年MM月dd日').format(e);
                                    return SizedBox(
                                      width: 140,
                                      child: Text(now),
                                    );
                                  }),
                                  const SizedBox(width: 42, child: Text("完成")),
                                  Builder(builder: (context) {
                                    int index = pull.indexOf(e);
                                    var msg = '首针';
                                    var map = ['一', '二', '三', '四'];
                                    if (index >= 1) {
                                      var key = map[index];
                                      msg = '第$key针';
                                    }
                                    return SizedBox(
                                      width: 50,
                                      child: Text(msg),
                                    );
                                  }),
                                  Expanded(
                                    child: Text("($_hName)"),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
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

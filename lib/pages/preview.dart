import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';

class PreviewPageView extends StatefulWidget {
  const PreviewPageView({Key? key}) : super(key: key);

  @override
  State<PreviewPageView> createState() => _PreviewPageViewState();
}

class _PreviewPageViewState extends State<PreviewPageView> {
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
                  children: const [
                    Text(
                      "周立齐",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 4.2,
                    ),
                    Text(
                      "证件号码: 11423423",
                      style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1),
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "手机号码: 18432424235",
                      style: TextStyle(
                        color: Color.fromRGBO(101, 101, 101, 1),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QrImage(
                      data: "https://github.com/d1y",
                      padding: const EdgeInsets.all(2.4),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color.fromRGBO(57, 105, 31, 1),
                      version: QrVersions.auto,
                      embeddedImage: Image.asset('assets/nrhc.png').image,
                      size: MediaQuery.of(context).size.width * .5,
                    ),
                    const SizedBox(
                      height: 12.0,
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
                      child: const Text(
                        '2022-10-30 13:27:38',
                        style: TextStyle(
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

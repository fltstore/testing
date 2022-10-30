import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';
import '../extensions/string.dart';

class PointerPageView extends StatefulWidget {
  const PointerPageView({Key? key}) : super(key: key);

  @override
  State<PointerPageView> createState() => _PointerPageViewState();
}

class _PointerPageViewState extends State<PointerPageView> {
  List<String> tabs = [
    "预约挂号",
    "检验报告",
    "处方服务",
    "疫苗接种",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 248, 249, 1),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 148,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stay/changsha-back.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                const Opacity(
                  opacity: .0,
                  child: CupertinoNavigationBarBackButton(),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("103,331,209人"),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "正在使用湖南电子健康卡，就医通信一码通",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50 / 2),
                                border: Border.all(
                                  color: const Color.fromRGBO(91, 135, 247, 1),
                                ),
                              ),
                              child: Image.asset(
                                'assets/stay/man.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 18.0,
                            ),
                            Opacity(
                              opacity: .42,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(42 / 2),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(223, 234, 207, 1),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 18.0,
                              ),
                              child: const Text(
                                '家庭成员管理',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            const Icon(
                              CupertinoIcons.right_chevron,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "本人",
                            style: TextStyle(
                              fontSize: 9.0,
                              color: Color.fromRGBO(91, 135, 247, 1),
                            ),
                          ),
                          Icon(
                            CupertinoIcons.chevron_down,
                            size: 8.0,
                            color: Color.fromRGBO(91, 135, 247, 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4.2,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/preview');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/stay/swiper-hunan.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                            vertical: 36.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: SizedBox.shrink()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "周立齐",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "4245203432487435".formatToIDCard,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  QrImage(
                                    data: "https://github.com/d1y",
                                    padding: const EdgeInsets.all(2.4),
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        const Color.fromRGBO(57, 105, 31, 1),
                                    version: QrVersions.auto,
                                    embeddedImage:
                                        Image.asset('assets/nrhc.png').image,
                                    size: 90.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: GridView.builder(
                itemCount: tabs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  // childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  var curr = tabs[index];
                  return Column(
                    children: [
                      Image.asset(
                        "assets/stay/logo/$curr.png",
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 4.2),
                      Text(
                        curr,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

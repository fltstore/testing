import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestingHomePageView extends StatefulWidget {
  const TestingHomePageView({Key? key}) : super(key: key);

  @override
  State<TestingHomePageView> createState() => _TestingHomePageViewState();
}

class _TestingHomePageViewState extends State<TestingHomePageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: .66,
          child: Image.asset(
            'assets/bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.black45,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "最近",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            actions: [
              Opacity(
                opacity: 0,
                child: CupertinoButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  padding: EdgeInsets.zero,
                  child: const Text("设置"),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.black12,
                height: 1.0,
              ),
            ),
            toolbarHeight: 38,
          ),
          bottomNavigationBar: Opacity(
            opacity: .66,
            child: Container(
              width: double.infinity,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12).copyWith(
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "微信(2)",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Icon(
                      CupertinoIcons.add_circled,
                      size: 19,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.search,
                          size: 16,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4.2,
                        ),
                        Text('搜索小程序'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Opacity(
                              opacity: .88,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('最近使用的小程序'),
                                  Row(
                                    children: const [
                                      Text('更多'),
                                      Icon(
                                        CupertinoIcons.right_chevron,
                                        size: 12,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/entry');
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                width: 66,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Image.asset(
                                      'assets/logo.jpg',
                                      width: 42,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              const SizedBox(
                                width: 66,
                                child: Text(
                                  "湖南居民健康卡",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

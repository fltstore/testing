import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../types/index.dart';
import '../shared/local_storage.dart';
import '../config/keys.dart' as keys;

class SettingsPageView extends StatefulWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  @override
  State<SettingsPageView> createState() => _SettingsPageViewState();
}

class _SettingsPageViewState extends State<SettingsPageView> {
  CodeType? _reCodeType;

  List<DateTime> pulls = [];

  Map<String, dynamic> map = {};

  List<String> controllerWithMap = [
    keys.kName,
    keys.kCard,
    keys.kPhone,
    keys.kHospital,
    keys.kHospitalName
  ];

  init() {
    for (var key in controllerWithMap) {
      String text = localStorage.getItem(key, '');
      map[key] = TextEditingController(text: text);
    }
    String codeType = localStorage.getItem(
      keys.kCodeType,
      CodeType.green.index.toString(),
    );
    map[keys.kCodeType] = CodeType.values[int.tryParse(codeType) ?? 0];
    String pullCacheData = localStorage.getItem(keys.kPull1, '');
    var list = pullCacheData
        .split("||")
        .where((element) => element.isNotEmpty)
        .toList();
    List<DateTime> puller = list.map((e) => DateTime.parse(e)).toList();
    if (puller.isNotEmpty) {
      pulls = puller;
      setState(() {});
    }
  }

  save() async {
    var success = false;
    var errorStack = '';
    try {
      for (var key in controllerWithMap) {
        TextEditingController controller = map[key] as TextEditingController;
        String text = controller.text;
        if (text.isNotEmpty) {
          localStorage.setItem(key, text);
        }
      }
      var data = map[keys.kCodeType] as CodeType;
      localStorage.setItem(keys.kCodeType, data.index.toString());
      String timeFormat = pulls.map((e) => e.toString()).join("||");
      localStorage.setItem(keys.kPull1, timeFormat);
      success = true;
    } catch (e) {
      errorStack = e.toString();
      debugPrint(errorStack);
    }
    var msg = success ? '保存缓存成功' : errorStack;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("提示"),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            msg,
            style: TextStyle(
              color: !success ? Colors.red : Colors.black,
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '我知道了',
              style: TextStyle(
                color: !success ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<CodeType> pickerCodeTypeList = [
    CodeType.green,
    CodeType.yellow,
    CodeType.red
  ];

  pickerWithCodeType() {
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
              var curr = CodeType.values[selectedItem];
              _reCodeType = curr;
              setState(() {});
              map[keys.kCodeType] = curr;
            },
            children: pickerCodeTypeList
                .map(
                  (e) => Center(
                    child: Text(
                      e.humanString,
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

  pickerDate(int index) async {
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
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              pulls[index] = newDate;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.blue,
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text("设置"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 0,
              ),
              onPressed: save,
              child: const Text(
                "保存配置",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Column(
            children: [
              const ListTile(
                title: Text('姓名'),
              ),
              TextField(
                controller: map[keys.kName],
              ),
              const ListTile(
                title: Text('身份证号'),
              ),
              TextField(
                controller: map[keys.kCard],
              ),
              const ListTile(
                title: Text('手机号'),
              ),
              TextField(
                controller: map[keys.kPhone],
              ),
              const ListTile(
                title: Text('医院名称'),
              ),
              TextField(
                controller: map[keys.kHospital],
              ),
              ListTile(
                title: const Text('健康码状态'),
                trailing: GestureDetector(
                  onTap: pickerWithCodeType,
                  child: Builder(builder: (context) {
                    var type = map[keys.kCodeType] as CodeType;
                    if (_reCodeType != null) {
                      type = _reCodeType as CodeType;
                    }
                    return Text(
                      type.humanString,
                      style: TextStyle(
                        color: type.transColor,
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(1.2, 1.2),
                            blurRadius: 2.4,
                            color: type.transColor,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Column(
                children: pulls.map((e) {
                  var name = '首针';
                  int index = pulls.indexOf(e);
                  if (index >= 1) {
                    name = '第${index + 1}针';
                  }
                  var childText = DateFormat('yyyy-MM-dd').format(e);
                  return ListTile(
                    title: Text(name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickerDate(index);
                          },
                          child: Text(
                            childText,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 12),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            pulls.removeAt(index);
                            setState(() {});
                          },
                          child: const Text(
                            "删除",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    pulls.add(DateTime.now());
                    setState(() {});
                  },
                  onDoubleTap: () {
                    pulls.insert(0, DateTime.now());
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Center(
                      child: Text(
                        "添加疫苗记录(双击添加到第一个)",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              const ListTile(
                title: Text('疫苗接种名称'),
              ),
              TextField(
                controller: map[keys.kHospitalName],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

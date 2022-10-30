extension StringsFormat on String {
  String get formatToIDCard {
    if (length <= 8) return this;
    var tabs = List.generate(length, (index) => '*');
    for (var i = 0; i < 4; i++) {
      tabs[i] = this[i];
      int offset = i + (tabs.length - 4);
      tabs[offset] = this[offset];
    }
    return tabs.join('');
  }

  String get formatPeople {
    var data = split('').reversed.toList();
    String result = '';
    for (var i = 0; i < data.length; i++) {
      String output = data[i];
      if (i % 3 == 0 && i != 0) {
        output = '$output,';
      }
      result = output + result;
    }
    return result;
  }
}

class RowData {
  final int bac;
  late final int donGia;
  final int sanLuong;
  late final int thanhTien;

  RowData(this.bac, this.sanLuong) {
    switch (bac) {
      case 1:
        donGia = EvnRule.donGiaB1;
      case 2:
        donGia = EvnRule.donGiaB2;
      case 3:
        donGia = EvnRule.donGiaB3;
      case 4:
        donGia = EvnRule.donGiaB4;
      case 5:
        donGia = EvnRule.donGiaB5;
      case 6:
        donGia = EvnRule.donGiaB6;
      default:
        donGia = 0;
    }
    thanhTien = donGia * sanLuong;
  }
  @override
  String toString() {
    return "\ndonGia: $donGia, sanLuong: $sanLuong, thanhTien: $thanhTien";
  }

  get bacStr {
    return "Bac $bac";
  }

  get sanLuongStr {
    return sanLuong.toString();
  }

  get thanhTienStr {
    return thanhTien.toString();
  }

  get donGiaStr {
    return donGia.toString();
  }
}

class EvnRule {
  static final donGiaB1 = 1984;
  static final int maxSanluongB1 = 52;
  static final donGiaB2 = 2050;
  static final int maxSanluongB2 = 52;
  static final donGiaB3 = 2380;
  static final int maxSanluongB3 = 103;
  static final donGiaB4 = 2998;
  static final int maxSanluongB4 = 103;
  static final donGiaB5 = 3350;
  static final int maxSanluongB5 = 103;
  static final donGiaB6 = 3460;
  static final double thueGtgt = 0.08;
}

class Data {
  final int totalkWh;
  RowData row1 = RowData(1, 0);
  RowData row2 = RowData(2, 0);
  RowData row3 = RowData(3, 0);
  RowData row4 = RowData(4, 0);
  RowData row5 = RowData(5, 0);
  RowData row6 = RowData(6, 0);
  Data({required this.totalkWh}) {
    var count = totalkWh;
    count = count - EvnRule.maxSanluongB1;
    if (totalkWh > EvnRule.maxSanluongB1) {
      row1 = RowData(1, EvnRule.maxSanluongB1);
    } else {
      row1 = RowData(1, totalkWh);
      return;
    }
    count = count - EvnRule.maxSanluongB2;
    if (count > 0) {
      row2 = RowData(2, EvnRule.maxSanluongB2);
    } else {
      row2 = RowData(2, count.abs());
      return;
    }

    count = count - EvnRule.maxSanluongB3;
    if (count > 0) {
      row3 = RowData(3, EvnRule.maxSanluongB3);
    } else {
      row3 = RowData(3, count.abs());
      return;
    }

    count = count - EvnRule.maxSanluongB4;
    if (count > 0) {
      row4 = RowData(4, EvnRule.maxSanluongB4);
    } else {
      row4 = RowData(4, count.abs());
      return;
    }

    count = count - EvnRule.maxSanluongB5;
    if (count > 0) {
      row5 = RowData(5, EvnRule.maxSanluongB5);
    } else {
      row5 = RowData(5, count.abs());
      return;
    }

    row6 = RowData(6, count);
  }
  List<RowData> get _rows {
    return [row1, row2, row3, row4, row5, row6].toList();
  }

  double? _tienDienChuaThue;
  double get tienDienChuaThue {
    _tienDienChuaThue ??= _rows.map((e) => e.thanhTien.toDouble()).reduce((
      a,
      b,
    ) {
      return a + b;
    });
    return _tienDienChuaThue!;
  }

  double? _tienThueGtgt;
  double get tienThueGtgt {
    _tienThueGtgt ??= tienDienChuaThue * EvnRule.thueGtgt;
    return _tienThueGtgt!;
  }

  double? _tongCong;
  double get tongCong {
    _tongCong ??= tienDienChuaThue + tienThueGtgt;
    return _tongCong!;
  }

  @override
  String toString() {
    return [row1, row2, row3, row4, row5, row6].toString();
  }
}

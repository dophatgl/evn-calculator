import 'package:evn_calculator_app/app_text_style.dart';
import 'package:evn_calculator_app/data.dart';
import 'package:evn_calculator_app/strings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: Strings.appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _data = Data(totalkWh: 0);
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(Strings.resultLabel, style: AppTextStyle.header),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Item("Bac", textStyle: AppTextStyle.boldLabel),
                _Item("Don Gia\n(dong/k)", textStyle: AppTextStyle.boldLabel),
                _Item("San luong\n(kWh)", textStyle: AppTextStyle.boldLabel),
                _Item("Thanh Tien\n(dong)", textStyle: AppTextStyle.boldLabel),
              ],
            ),
            Divider(height: 10),
            _Row(data: _data.row1),
            Divider(height: 10),
            _Row(data: _data.row2),
            Divider(height: 10),
            _Row(data: _data.row3),
            Divider(height: 10),
            _Row(data: _data.row4),
            Divider(height: 10),
            _Row(data: _data.row5),
            Divider(height: 10),
            _Row(data: _data.row6),
            Divider(height: 10),
            Text("Thanh Tien", style: AppTextStyle.header),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                children: [
                  _Item(
                    "Tien Dien Chua Thue:",
                    textAlign: TextAlign.left,
                    textStyle: AppTextStyle.boldLabel,
                  ),
                  _Item(
                    _data.tienDienChuaThue.round().toString(),
                    textAlign: TextAlign.right,
                    textStyle: AppTextStyle.boldLabel,
                  ),
                ],
              ),
            ),
            Divider(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Row(
                children: [
                  _Item(
                    "Thue GTGT (8%) tien dien:",
                    textAlign: TextAlign.left,
                    textStyle: AppTextStyle.boldLabel,
                  ),
                  _Item(
                    _data.tienThueGtgt.round().toString(),
                    textAlign: TextAlign.right,
                    textStyle: AppTextStyle.boldLabel,
                  ),
                ],
              ),
            ),
            Divider(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),

              child: Row(
                children: [
                  _Item(
                    "Tong cong tien thanh toan:",
                    textAlign: TextAlign.left,
                    textStyle: AppTextStyle.redBoldLabel,
                  ),
                  _Item(
                    _data.tongCong.round().toString(),
                    textAlign: TextAlign.right,
                    textStyle: AppTextStyle.redBoldLabel,
                  ),
                ],
              ),
            ),
            Divider(height: 30),
            Text(
              Strings.totalPower,
              textAlign: TextAlign.left,
              style: AppTextStyle.header,
            ),
            Container(height: 10),
            SizedBox(
              width: screenWidth - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'kWh',
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  VerticalDivider(width: 20),
                  Expanded(
                    child: FloatingActionButton(
                      onPressed: _handleButtonClick,
                      child: Text(Strings.buttonCalculator),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleButtonClick() {
    final raw = _controller.text;
    if (raw.isEmpty) return;
    final value = int.parse(raw);
    setState(() {
      _data = Data(totalkWh: value);
    });
  }
}

class _Item extends StatelessWidget {
  final String data;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  const _Item(this.data, {this.textAlign = TextAlign.center, this.textStyle});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(data, textAlign: textAlign, style: textStyle),
    );
  }
}

class _Row extends StatelessWidget {
  final RowData _data;

  const _Row({required RowData data}) : _data = data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Item(_data.bacStr),
        _Item(_data.donGiaStr),
        _Item(_data.sanLuongStr),
        _Item(_data.thanhTienStr),
      ],
    );
  }
}

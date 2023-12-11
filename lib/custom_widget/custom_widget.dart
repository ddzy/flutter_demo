import 'package:flutter/material.dart';
import 'custom_button.dart' show CustomButton;
import 'custom_paint_chess.dart' show CustomPaintChess;
import 'custom_paint_circular_progress.dart' show CustomPaintCircularProgress;
import 'custom_checkbox.dart' show CustomCheckbox;

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomWidgetState();
  }
}

class _CustomWidgetState extends State<CustomWidget> {
  bool _checkboxValue1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("自定义widget"),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  child: const Text("Custom Button"),
                  onTap: () {},
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: const CustomPaintChess(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      CustomPaintCircularProgress(
                        percent: 25,
                        radius: 50,
                        trackWidth: 10,
                      ),
                      CustomPaintCircularProgress(
                        percent: 41,
                        isGradient: true,
                        radius: 50,
                        trackWidth: 10,
                      ),
                      CustomPaintCircularProgress(
                        percent: 80,
                        isGradient: true,
                        radius: 50,
                        trackWidth: 10,
                        gradientColorList: const [
                          Colors.red,
                          Colors.orange,
                          Colors.yellow,
                          Colors.cyan,
                        ],
                        gradientStopList: const [0, 0.25, 0.5, 1],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Checkbox(
                          value: _checkboxValue1,
                          onChanged: (value) {
                            setState(() {
                              _checkboxValue1 = value ?? false;
                            });
                          }),
                      CustomCheckbox(
                        radius: 20,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

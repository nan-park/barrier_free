import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    //가로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    //변수들(이따 build 위로 옮기기)
    String music = "♬ 잔잔한 음악";
    String effect = "[지직거리는 레코드 소리]";
    String dialogue = "(재즈싱어) 우린 우린 왜 사랑했을까\n테스트1\n테스트2";
    Color colorDialogue = Colors.blueAccent;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
              child: Column(
            children: [
              Spacer(flex: 1),
              // 음악 설명(music)
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(music, style: TextStyle(fontSize: 25, color: Colors.white))]),
                  )),
              // 소리 설명(effect)
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(effect, style: TextStyle(fontSize: 25, color: Colors.white))],
                    ),
                  )),
              // 대사/가사(dialogue)
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                dialogue,
                                style: TextStyle(fontSize: 25, color: colorDialogue, height: 1.4, letterSpacing: 1.0),
                                textAlign: TextAlign.center,
                              )
                            ]),
                          ],
                        )
                      ],
                    ),
                  )),
              Spacer(flex: 1),
            ],
          )),
        ),
      ),
    );
  }
}

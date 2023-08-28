import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

// 채팅 스트림
Stream getDataStream() async* {
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshot =
      FirebaseFirestore.instance.collection("LiveStreamData").doc("data").snapshots();
  yield* snapshot;
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    //가로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // Color colorDialogue = Colors.blueAccent;
    List<Color> colorList = [];
    Color colorD;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: StreamBuilder(
              stream: getDataStream(),
              builder: (context, AsyncSnapshot streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("로딩중...", style: TextStyle(fontSize: 25, color: Colors.white)));
                } else {
                  //Map snapshotList = streamSnapshot.data.docs;
                  colorList = [];
                  String colorString = streamSnapshot.data["color"];
                  colorD = Colors.white;
                  for (int i = 0; i < 5; i = i + 2) {
                    //rg
                    // print(colorString.length);
                    if (i < colorString.length) {
                      if (colorString[i] == "r") {
                        colorD = const Color.fromARGB(255, 243, 203, 204);
                      } else if (colorString[i] == "g") {
                        colorD = const Color.fromARGB(255, 167, 200, 157);
                      } else if (colorString[i] == "b") {
                        colorD = const Color.fromARGB(255, 160, 192, 242);
                      } else if (colorString[i] == "w") {
                        colorD = Colors.white;
                      } else if (colorString[i] == "y") {
                        colorD = const Color.fromARGB(255, 255, 228, 0);
                      } else if (colorString[i] == "p") {
                        colorD = const Color.fromARGB(255, 255, 190, 216);
                      }
                    }
                    colorList.add(colorD);
                  }
                  // print(colorList);
                  // ColorString = "rg";
                  // colorList = [Colors.red, Colors.green, Colors.green];
                  // String dialogueEx = "올리버)안녕안녕\n클레어)호이호이\n제임스)헬로헬로";
                  // List dialogueList = dialogueEx.split("\n");
                  List dialogueList = streamSnapshot.data["dialogue"].split("\n"); // 개수 1~3개

                  // if (streamSnapshot.data["color"] == "") {
                  //   colorDialogue = Colors.white;
                  // } else if (streamSnapshot.data["color"] == "r") {
                  //   colorDialogue = Color.fromARGB(255, 234, 209, 220);
                  // } else if (streamSnapshot.data["color"] == "g") {
                  //   colorDialogue = Color.fromARGB(255, 217, 234, 211);
                  // } else if (streamSnapshot.data["color"] == "b") {
                  //   colorDialogue = Color.fromARGB(255, 201, 218, 248);
                  // }

                  return Column(
                    children: [
                      const Spacer(flex: 1),
                      // 음악 설명(music)
                      Expanded(
                          flex: 1,
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(streamSnapshot.data["music"],
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: "RIDIBatang",
                                ))
                          ])),
                      // 소리 설명(effect)
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(streamSnapshot.data["effect"],
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "RIDIBatang",
                                  ))
                            ],
                          )),
                      // 대사/가사(dialogue)
                      Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Column(
                                      children: [
                                        for (int i = 0; i < dialogueList.length; i++)
                                          (Text(
                                            dialogueList[i],
                                            style: TextStyle(
                                                fontFamily: "RIDIBatang",
                                                fontSize: 25,
                                                color: colorList[i],
                                                height: 1.4,
                                                letterSpacing: 1.0),
                                            textAlign: TextAlign.center,
                                          ))
                                      ],
                                    )
                                  ]),
                                ],
                              )
                            ],
                          )),
                      const Spacer(flex: 1),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}

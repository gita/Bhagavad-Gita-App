import 'dart:async';
import 'dart:convert';

import 'package:bhagavad_gita/Constant/app_size_config.dart';
import 'package:bhagavad_gita/localization/demo_localization.dart';
import 'package:bhagavad_gita/models/color_selection_model.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatAIScreen extends StatefulWidget {
  ChatAIScreen({Key? key}) : super(key: key);

  @override
  State<ChatAIScreen> createState() => _ChatAIScreenState();
}

class _ChatAIScreenState extends State<ChatAIScreen>
    with SingleTickerProviderStateMixin {
  var chatData = <ChatResponseModel>[];

  @override
  void initState() {
    setState(() {
      chatData.add(ChatResponseModel(
          isDone: true,
          message:
              "Radhey Radhey, I am Gita AI, a repository of knowledge and wisdom. Allow me to assist you by answering any inquiries you may have. Ask me anything.",
          messageType: MessageType.reciver));
    });

    super.initState();
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

  http.Client? _client;
  TextEditingController searchText = TextEditingController();
  StreamController<String> streamController =
      StreamController<String>.broadcast();

  var currentSSEModel = SSEModel(data: '', id: '', event: '');
  var lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');

  ScrollController scrollController = ScrollController();

  bool isLoading = false;

  int? selectedIndex;
  String? selectedList;

  String note =
      'Note: The answer may not be factually correct. Please do your own research before taking any action.';
  List<String> suggestionList = [
    "What is life's purpose?",
    'How to attain peace?',
    'What is the path to enlightenment?',
    'How to stay positive?',
    'Please explain Chapter 12 Verse 13.',
    'What is Karma Yoga?'
  ];

  addList() {
    chatData.add(ChatResponseModel(
        message: searchText.value.text,
        messageType: MessageType.sender,
        isDone: true));
  }

  subscribe() {
    setState(() {
      isLoading = true;
    });

    try {
      _client = http.Client();

      var request = new http.Request(
          "POST", Uri.parse("https://api.sanskriti.ai/v1/sse-content/stream"));

      request.headers["accept"] = "application/json";
      request.headers['Content-Type'] = 'application/json';

      request.headers["X-API-KEY"] = 'cff54320-2433-4b10-b2a8-f579ad359cfd';
      request.body = jsonEncode({
        'question': '${searchText.text}',
        'chat_history': [],
      });

      Future<http.StreamedResponse> response = _client!.send(request);

      response.asStream().listen((data) {
        data.stream
          ..transform(Utf8Decoder()).transform(LineSplitter()).listen(
              (dataLine) {
            if (dataLine.isEmpty) {
              streamController.sink
                  .add(currentSSEModel.data.toString().replaceAll(']', ''));

              return;
            }

            Match match = lineRegex.firstMatch(dataLine)!;
            var field = match.group(1);

            // if (field!.isEmpty) {
            //   return;
            // }
            var value = '';
            if (field == 'data') {
              value = dataLine.substring(5);
            } else {
              value = match.group(2) ?? '';
            }

            switch (field) {
              case 'event':
                currentSSEModel.event = value;
                debugPrint('Event call');
                if (isLoading) {
                  setState(() {
                    isLoading = false;
                  });
                }
                break;
              case 'data':
                currentSSEModel.data = (currentSSEModel.data!
                            .replaceAll("  ", " ")
                            .replaceAll(" ,", ",")
                            .replaceAll(" !", "!")
                            .replaceAll('..', '.')
                            .replaceAll(" . .", ".")
                            .replaceAll('.,. ', '')
                            .replaceAll(" .", ".")
                            .replaceAll(',,,', '')
                            .replaceAll('sur rends ers', 'surrendsers')
                            .replaceAll('VERS ES', 'VERSES')
                            .replaceAll('K rish na', 'Krishna')
                            .replaceAll('Y og', 'Yog')
                            .replaceAll('K unt i', 'Kunti')
                            .replaceAll('real ization', 'realization')
                            .replaceAll('Ar j una', 'Arjuna')
                            .replaceAll('Y ud h ish th ira', 'Yudhishthira')
                            .replaceAll('K uru ks het ra', 'Kurukshetra')
                            .replaceAll('Dh rit ar ashtra', 'Dhritarashtra')
                            .replaceAll('Mah ab har ata', 'Mahabharata')
                            .replaceAll('Nam aste', 'Namaste')
                            .replaceAll('Rad hey', 'Radhey'))
                        .replaceAll('D hy ana', 'Dhyana')
                        .replaceAll('dh arma', 'dharma')
                        .replaceAll('K sh atri ya', 'Kshatriya')
                        .replaceAll('Bh ag av ad', 'Bhagavad')
                        .replaceAll('G ita', 'Gita')
                        .replaceAll('Hindu ism', 'Hinduism')
                        .replaceAll('Bh ima', 'Bhima')
                        .replaceAll('Y ud h ishth ira', 'Yudhishthira')
                        .replaceAll('Nak ula', 'Nakula')
                        .replaceAll('Sah adeva', 'Sahadeva')
                        .replaceAll('Pand u', 'Pandu')
                        .replaceAll('Pand av', 'Pandav')
                        .replaceAll('K aur av as', 'Kauravas')
                        .replaceAll('Dh rit ashtra', 'Dhritashtra')
                        .replaceAll('Ved as', 'Vedas')
                        .replaceAll('D ury od h ana', 'Duryodhana')
                        .replaceAll('K uru', 'Kuru')
                        .replaceAll(RegExp('[^A-Za-z,.?!]'), " ")
                        .trim() +
                    value +
                    '\n';

                ChatResponseModel model = chatData.last;
                if (model.isDone) {
                  ChatResponseModel temp = ChatResponseModel(
                      message: currentSSEModel.data
                          .toString()
                          .replaceAll(']', '')
                          .replaceAll('[', '')
                          .replaceAll('4', ''),
                      messageType: MessageType.reciver,
                      isDone: false);
                  setState(() {
                    chatData.add(temp);
                  });
                } else {
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    curve: Curves.ease,
                    duration: const Duration(milliseconds: 1),
                  );
                  ChatResponseModel temp = ChatResponseModel(
                      message: currentSSEModel.data
                          .toString()
                          .replaceAll(']', '')
                          .replaceAll('[', '')
                          .replaceAll('4', ''),
                      messageType: MessageType.reciver,
                      isDone: false);
                  setState(() {
                    chatData.last = temp;
                  });
                }
                break;
              case 'id':
                currentSSEModel.id = value;

                break;
              case 'retry':
                break;
            }
          }, onError: (e, s) {
            streamController.addError(e, s);
          }, onDone: () {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 1),
            );
            setState(() {
              ChatResponseModel temp = ChatResponseModel(
                  message: currentSSEModel.data
                      .toString()
                      .replaceAll(']', '')
                      .replaceAll('[', '')
                      .replaceAll('4', ''),
                  messageType: MessageType.reciver,
                  isDone: true);
              setState(() {
                chatData.last = temp;
              });
            });
            currentSSEModel.data = '';
          });
      });
    } catch (e) {}

    return streamController.stream.asBroadcastStream();
  }

  unsubscribe() {
    _client!.close();
  }

  @override
  Widget build(BuildContext context) {
    FormatingColor formatingColor = whiteFormatingColor;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: formatingColor.bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Center(
            child: SvgPicture.asset("assets/icons/icon_back_arrow.svg",
                width: 20, color: formatingColor.naviagationIconColor),
          ),
        ),
        title: Text(
          DemoLocalization.of(context)!
              .getTranslatedValue('bhagvad_gita_chat')
              .toString(),
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: chatData.length,
                controller: scrollController,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var data = chatData[index];

                  return data.messageType == MessageType.sender
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Arjuna',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://bhagavadgita.ai/_next/image?url=%2FAvatars%2Farjuna.png&w=64&q=75'),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(7.5),
                                      topLeft: Radius.circular(7.5),
                                      bottomRight: Radius.circular(7.5)),
                                  color: Color.fromRGBO(255, 193, 7, 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(data.message),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      'https://bhagavadgita.ai/_next/image?url=%2FAvatars%2Fkrishna.png&w=64&q=75'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text('Gita AI',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(7.5),
                                        topRight: Radius.circular(7.5),
                                        bottomRight: Radius.circular(7.5)),
                                    color: Color.fromRGBO(255, 237, 194, 1),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.message),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              note,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          )
                                        ],
                                      ))),
                            ),
                          ],
                        );
                },
              ),
            ),
            suggestionList.isEmpty
                ? SizedBox()
                : Container(
                    height: height * 0.38,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.5),
                            topRight: Radius.circular(7.5)),
                        color: Color.fromRGBO(255, 244, 219, 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Suggestion:',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                color: Color.fromRGBO(75, 85, 99, 1)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: suggestionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: UnconstrainedBox(
                                    alignment: Alignment.bottomLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          selectedList = suggestionList[index];
                                          searchText.text =
                                              selectedList.toString();
                                        });
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 193, 7, 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 4),
                                            child: Text(
                                              suggestionList[index],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.normal,
                                                  color: Color.fromRGBO(
                                                      17, 24, 39, 1)),
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            TextField(
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.text,
              onChanged: (v) {
                setState(() {
                  searchText.text;
                });
              },
              style: TextStyle(
                fontSize: 16,
              ),
              controller: searchText,
              onSubmitted: searchText.text.isEmpty
                  ? null
                  : (v) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 100),
                      );
                      addList();
                      suggestionList.clear();

                      subscribe();

                      Future.delayed(Duration(seconds: 2), () {
                        searchText.clear();
                      });
                    },
              maxLines: null,
              cursorColor: Colors.orange,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(7.5),
                        bottomRight: Radius.circular(7.5)),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300), //<-- SEE HERE
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(0.50),
                        bottomRight: Radius.circular(7.5)),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  contentPadding:
                      EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 20, minWidth: 20),
                  suffixIcon: Container(
                    child: IconButton(
                        onPressed: searchText.text.isEmpty
                            ? null
                            : () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 100),
                                );
                                addList();
                                suggestionList.clear();

                                subscribe();

                                Future.delayed(Duration(seconds: 2), () {
                                  searchText.clear();
                                });
                              },
                        icon: isLoading
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 244, 219, 1),
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  color: Colors.orange,
                                  backgroundColor:
                                      Color.fromRGBO(255, 244, 219, 1),
                                ),
                              )
                            : Image.asset(
                                'assets/icons/sendIcon.png',
                                color: searchText.text.isEmpty
                                    ? Colors.orange.shade100
                                    : Colors.orange,
                              )),
                  ),
                  border: InputBorder.none,
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(color: Colors.grey.shade400)),
            ),
          ],
        ),
      )),
    );
  }
}

class ChatResponseModel {
  var message = '';
  MessageType messageType = MessageType.sender;
  bool isDone;

  ChatResponseModel(
      {required this.message, required this.messageType, this.isDone = false});
}

enum MessageType { sender, reciver }

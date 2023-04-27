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
                            .replaceAll('.. ', '.')
                            .replaceAll(" . .", ".")
                            .replaceAll('.,. ', '')
                            .replaceAll(" .", ".")
                            .replaceAll(',,,', '')
                            .replaceAll(',,.,', '')
                            .replaceAll(',,', '')
                            .replaceAll(',.,', '.')
                            .replaceAll('sur rends ers', 'surrendsers')
                            .replaceAll('VERS ES', 'Verses')
                            .replaceAll('VERS E', 'Verse')
                            .replaceAll('desire r', 'desirer')
                            .replaceAll('K rish na', 'Krishna')
                            .replaceAll('Y og', 'Yog')
                            .replaceAll('K unt i', 'Kunti')
                            .replaceAll('real ization', 'realization')
                            .replaceAll('Ar j una', 'Arjuna')
                            .replaceAll('Y ud h ish th ira', 'Yudhishthira')
                            .replaceAll('K uru ks het ra', 'Kurukshetra')
                            .replaceAll('Kuru ks het ra', 'Kurukshetra')
                            .replaceAll('Dh rit ar ashtra', 'Dhritarashtra')
                            .replaceAll('Mah ab har ata', 'Mahabharata')
                            .replaceAll('Nam aste', 'Namaste')
                            .replaceAll('Rad hey', 'Radhey'))
                        .replaceAll('. Radhey', ' Radhey')
                        .replaceAll('D hy ana', 'Dhyana')
                        .replaceAll('dh arma', 'dharma')
                        .replaceAll('K sh atri ya', 'Kshatriya')
                        .replaceAll('Bh ag av ad', 'Bhagavad')
                        .replaceAll('B h ag av ad', 'Bhagavad')
                        .replaceAll('G ita', 'Gita')
                        .replaceAll('Hindu ism', 'Hinduism')
                        .replaceAll('Bh ima', 'Bhima')
                        .replaceAll('Y ud h ishth ira', 'Yudhishthira')
                        .replaceAll('Nak ula', 'Nakula')
                        .replaceAll('Sah adeva', 'Sahadeva')
                        .replaceAll('Pand u', 'Pandu')
                        .replaceAll('Pand av', 'Pandav')
                        .replaceAll('Pandav as', 'Pandavas')
                        .replaceAll('K aur av', 'Kaurav')
                        .replaceAll('Kaurav as', 'Kauravas')
                        .replaceAll('Dh rit ashtra', 'Dhritashtra')
                        .replaceAll('Ved as', 'Vedas')
                        .replaceAll('D ury od h ana', 'Duryodhana')
                        .replaceAll('K uru', 'Kuru')
                        .replaceAll('pious men', 'piousmen')
                        .replaceAll('inqu is itive', 'inquisitive')
                        .replaceAll('dev otional', 'devotional')
                        .replaceAll('. O', 'O')
                        .replaceAll('ded icating', 'dedicating')
                        .replaceAll('ren unciation', 'renunciation')
                        .replaceAll('fru itive', 'fruitive')
                        .replaceAll('att ains', 'attains')
                        .replaceAll('ind est ruct ible', 'indestructible')
                        .replaceAll('equ anim', 'equanim')
                        .replaceAll('equanim ity', 'equanimity')
                        .replaceAll('und ist urbed', 'undisturbed')
                        .replaceAll('dual ities', 'dualities')
                        .replaceAll('ego ism', 'egoism')
                        .replaceAll('del uded', 'deluded')
                        .replaceAll('pur ifying', 'purifying')
                        .replaceAll('pur ification', 'purification')
                        .replaceAll('se rene', 'serene')
                        .replaceAll('S eren ity', 'Serenity')
                        .replaceAll('c ravings', 'cravings')
                        .replaceAll('att ains', 'attains.')
                        .replaceAll('imper ishable', 'imperishable')
                        .replaceAll('sust ains', 'sustains')
                        .replaceAll('d iscovery', 'discovery')
                        .replaceAll('wa ver', 'waver')
                        .replaceAll('G ud akes ha', 'Gudakesha')
                        .replaceAll('Gand hari', 'Gandhari')
                        .replaceAll('ad h arma', 'adharma')
                        .replaceAll('Hast in ap ura', 'Hastinapura')
                        .replaceAll('V ich it rav ir ya', 'Vichitravirya')
                        .replaceAll('Amb ika', 'Ambika')
                        .replaceAll('Sah dev a', 'Sahdeva')
                        .replaceAll('Sah ade va', 'Sahadeva')
                        .replaceAll('Mad ri', 'Madri')
                        .replaceAll('Ash v ins', 'Ashvins')
                        .replaceAll('eman ates', 'emanates')
                        .replaceAll('eman ate', 'emanate')
                        .replaceAll('val or', 'valor')
                        .replaceAll('V ay u', 'Vayu')
                        .replaceAll('V rik od ara', 'Vrikodara')
                        .replaceAll('Bh ish ma Pit am ah', 'Bhishma Pitamah')
                        .replaceAll('Dev av r ata', 'Devavrata')
                        .replaceAll('Shant anu', 'Shantanu')
                        .replaceAll('G anga', 'Ganga')
                        .replaceAll('Vish nu', 'Vishnu')
                        .replaceAll('K arna', 'Karna')
                        .replaceAll('S ury a', 'Surya')
                        .replaceAll('char i ote er', 'charioteer')
                        .replaceAll('ar cher', 'archer')
                        .replaceAll('ar tha', 'artha')
                        .replaceAll('k ama', 'karma')
                        .replaceAll('des ires', 'desires')
                        .replaceAll('m ok sha', 'moksha')
                        .replaceAll("M ok sha", 'Moksha')
                        .replaceAll('S anya as', 'Sanyaas')
                        .replaceAll('s anya as', 'sanyaas')
                        .replaceAll('V y asa', 'Vyasa')
                        .replaceAll('V ais amp ay ana', 'Vaisampayana')
                        .replaceAll('liber ation', 'liberation')
                        .replaceAll('Cont rolling', 'Controlling')
                        .replaceAll('real ized', 'realized')
                        .replaceAll('dis cipl ined', 'disciplined')
                        .replaceAll('endeav oring', 'endeavoring')
                        .replaceAll('surrender ing', 'surrendering')
                        .replaceAll('Ved ic', 'Vedic')
                        .replaceAll('syll able', 'syllable')
                        .replaceAll('mant ras', 'mantras')
                        .replaceAll('Viv as van', 'Vivasvan')
                        .replaceAll('Man u', 'Manu')
                        .replaceAll('I ksh v aku', "Ikshvaku")
                        .replaceAll('perv ades', 'pervades')
                        .replaceAll('S ank hya', 'Sankhya')
                        .replaceAll('Dh arm as', 'Dharmas')
                        .replaceAll('d harm as', 'dharmas')
                        .replaceAll('bra h man', 'brahman')
                        .replaceAll('Brahman as', 'Brahmanas')
                        .replaceAll('Brahman a', 'Brahmana')
                        .replaceAll('B rah man a', 'Brahmana')
                        .replaceAll('Sh ud ra', 'Shudra')
                        .replaceAll('var na', 'varna')
                        .replaceAll('Gun as', 'Gunas')
                        .replaceAll('K sh atri y as', 'Kshatriyas')
                        .replaceAll('Va ishy as', 'Vaishyas')
                        .replaceAll('Va ish ya', 'Vaishya')
                        .replaceAll('V ais ya', 'Vaisya')
                        .replaceAll('va ishy as', 'vaishyas')
                        .replaceAll('va isy as', 'vaisyas')
                        .replaceAll('mer ch ants', 'merchants')
                        .replaceAll('su dr as', 'sudras')
                        .replaceAll('Sud ra', 'Sudra')
                        .replaceAll('Sh ud ras', 'Shudras')
                        .replaceAll('sh ud ras', 'shudras')
                        .replaceAll('g rieve', 'grieve')
                        .replaceAll('O sc ion', 'Oscion')
                        .replaceAll('Bhar ata', 'Bharata')
                        .replaceAll('Gy ana', 'Gyana')
                        .replaceAll('Raj a', 'Raja')
                        .replaceAll('Vid ya', 'Vidya')
                        .replaceAll('pure st', 'purest')
                        .replaceAll('V ib h uti', 'Vibhuti')
                        .replaceAll('Bh ak ti', 'Bhakti')
                        .replaceAll('Vis ada', 'Visada')
                        .replaceAll('anx ieties', 'anxieties')
                        .replaceAll('gun as', 'gunas')
                        .replaceAll('s att va', 'sattava')
                        .replaceAll('r aj as', 'rajas')
                        .replaceAll('Raj o', 'Rajo')
                        .replaceAll('gun a', 'guna')
                        .replaceAll('t amas', 'tamas')
                        .replaceAll('k les has', 'kleshas')
                        .replaceAll('ign or ance', 'ignorance')
                        .replaceAll('pur ush arth', 'purusharth')
                        .replaceAll('J n ana', 'Jnana')
                        .replaceAll('S any asa', 'Sanyasa')
                        .replaceAll('A ksh ara', 'Akshara')
                        .replaceAll('Bra hma', 'Brahma')
                        .replaceAll('V ib h oot i', 'Vibhooti')
                        .replaceAll('Vish war oop a', 'Vishwaroopa')
                        .replaceAll('D arsh ana', 'Darshana')
                        .replaceAll('K set ra ', 'Ksetra')
                        .replaceAll('K set ra j ana', 'Ksetrajana')
                        .replaceAll('vib ha aga', 'vibhaaga')
                        .replaceAll('Gun at ray a', 'Gunatraya')
                        .replaceAll('V ib h aga', 'Vibhaga')
                        .replaceAll('Pur ush ott ama', 'Purushottama')
                        .replaceAll('Da ivas ura', 'Daivasura')
                        .replaceAll('Samp ad', 'Sampad')
                        .replaceAll('tamas ic', 'tamasic')
                        .replaceAll('Sr add hat ray a', 'Sraddhatraya')
                        .replaceAll('S att va', 'Sattva')
                        .replaceAll('S att v ika', 'Sattvika')
                        .replaceAll('s att v ika', 'sattvika')
                        .replaceAll('Rajas ika', 'Rajasika')
                        .replaceAll('rajas ika', 'rajasika')
                        .replaceAll('Tam as ika', 'Tamasika')
                        .replaceAll('gu a', 'guna')
                        .replaceAll('r ajo', 'rajo')
                        .replaceAll('t amo', 'tamo')
                        .replaceAll('pur ifier', 'purifier')
                        .replaceAll('D ron a', 'Drona')
                        .replaceAll('Brah min', 'Brahmin')
                        .replaceAll('bra h min', 'brahmin')
                        .replaceAll('Brah man', 'Brahman')
                        .replaceAll('Bhar ad w aja', 'Bharadwaja')
                        .replaceAll('devote e', 'devotee')
                        .replaceAll('D rup ada', 'Drupada')
                        .replaceAll('Ash wat th ama', 'Ashwatthama')
                        .replaceAll('sustain er', 'sustauiner')
                        .replaceAll('se ren ity', 'serenity')
                        .replaceAll('unt rou bled', 'untroubled')
                        .replaceAll('cl ump', 'clump')
                        .replaceAll('mis eries', 'miseries')
                        .replaceAll('Yug a', 'Yuga')
                        .replaceAll('y uga', 'yuga')
                        .replaceAll('y ug as', 'yugas')
                        .replaceAll('Sat ya', 'Satya')
                        .replaceAll('T ret a', 'Treta')
                        .replaceAll('t ret', 'tret')
                        .replaceAll('D v ap ara', 'Dvapara')
                        .replaceAll('d v par a', 'dvpara')
                        .replaceAll('ritual ism', 'ritualism')
                        .replaceAll('med itate', 'meditate')
                        .replaceAll('meditate s', 'meditates')
                        .replaceAll('Att raction', 'Attraction')
                        .replaceAll('Bec oming', 'Becoming')
                        .replaceAll('unch anging', 'unchanging')
                        .replaceAll('st ealing', 'stealing')
                        .replaceAll('e ater', 'eater')
                        .replaceAll('content ed', 'contented')
                        .replaceAll('Comp assion', 'Compassion')
                        .replaceAll('harmon ious', 'harmonious')
                        .replaceAll('inex haust ible', 'inexhaustible')
                        .replaceAll('Se va', 'Seva')
                        .replaceAll('One', '. One')
                        .replaceAll('f ickle', 'fickle')
                        .replaceAll('K ail ash', 'Kailash')
                        .replaceAll('yog i', 'yogi')
                        .replaceAll('Sha ivism', 'Shaivism')
                        .replaceAll('cycl ical', 'cyclical')
                        .replaceAll('Rad ha', 'Radha')
                        .replaceAll('Rad h ika', 'Radhika')
                        .replaceAll('Rad har ani', 'Radharani')
                        .replaceAll('Rad h ik ar ani', 'Radhikarani')
                        .replaceAll("Ruk mini's", "Rukmini's")
                        .replaceAll('Ruk mini', 'Rukmini')
                        .replaceAll('Laksh mi', 'Lakshmi')
                        .replaceAll('Bh ish m aka', 'Bhishmaka')
                        .replaceAll('Vid arb ha', 'Vidarbha')
                        .replaceAll('Div ine', 'Divine')
                        .replaceAll('ausp icious', 'auspicious')
                        .replaceAll('Th ir um ag al', 'Thirumagal')
                        .replaceAll('ab ode', 'abode')
                        .replaceAll('per v ading', 'pervading')
                        .replaceAll('V eda', 'Veda')
                        .replaceAll('Y aj ur', 'Yajur')
                        .replaceAll('S ama', 'Sama')
                        .replaceAll('Ath ar va', "Atharva")
                        .replaceAll('hy m ns', 'hymns')
                        .replaceAll('ved a', 'veda')
                        .replaceAll('Up anish ads', 'Upanishads')
                        .replaceAll('Ved anta', 'Vedanta')
                        .replaceAll('aph or isms', 'aphorisms')
                        .replaceAll('Ath ar v aveda', 'Atharvaveda')
                        .replaceAll('inc ant ations', 'incantations')
                        .replaceAll('disc ards', 'discards')
                        .replaceAll('script ural', 'scriptural')
                        .replaceAll('inj unctions', 'injunctions')
                        .replaceAll('arg y', 'argy')
                        .replaceAll('leth argy', 'lethargy')
                        .replaceAll('Pr ith a', 'Pritha')
                        .replaceAll('Abandon ing', 'Abandoning')
                        .replaceAll('oppos ites', 'opposites')
                        .replaceAll('im me as urable', 'immeasurable')
                        .replaceAll('Pur usha', 'Purusha')
                        .replaceAll('pur usha', 'purusha')
                        .replaceAll('Ab ode', 'Abode')
                        .replaceAll('trascend ental', 'trascendental')
                        .replaceAll('un righteous', 'unrighteous')
                        .replaceAll('partial ity', 'partiality')
                        .replaceAll('favor itism', 'favoritism')
                        .replaceAll('impart ially', 'impartially')
                        .replaceAll('omnip res ence', 'omnipresence')
                        .replaceAll('rad iance', 'radiance')
                        .replaceAll('demon iac', 'demoniac')
                        .replaceAll('enjoy er', 'enjoyer')
                        .replaceAll('uster ities', 'usterities')
                        .replaceAll('en m ity', 'enmity')
                        .replaceAll('asc etics', 'ascetics')
                        .replaceAll('pen ances', 'penances')
                        .replaceAll('ill umin ates', 'illuminates')
                        .replaceAll('att aining', 'attaining')
                        .replaceAll('prog en itors', 'progenitors')
                        .replaceAll('royal s', 'royals')
                        .replaceAll('great s', 'greats')
                        .replaceAll('rejo ices', 'rejoices')
                        .replaceAll('undert akings', 'undertakings')
                        .replaceAll('sol ace', 'solace')
                        .replaceAll('per manent', 'permanent')
                        .replaceAll('worsh ipping', 'worshipping')
                        .replaceAll('religious rites', 'religiousrites')
                        .replaceAll('cast e', 'caste')
                        .replaceAll('humble s', 'humbles')
                        .replaceAll('res pl end ent', 'resplendent')
                        .replaceAll('en vious', 'envious')
                        .replaceAll('imper man ence', 'impermanence')
                        .replaceAll('transit ory', 'transitory')
                        .replaceAll('content ment', 'contentment')
                        .replaceAll('dual ity', 'duality')
                        .replaceAll('agric ult ur ists', 'agriculturists')
                        .replaceAll('art isans', 'artisans')
                        .replaceAll('material istic', 'materialistic')
                        .replaceAll('laz iness', 'laziness')
                        .replaceAll('ar ise', 'arise')
                        .replaceAll('pra krit i', 'prakriti')
                        .replaceAll('yog as', 'yogas')
                        .replaceAll('ep ics', 'epics')
                        .replaceAll('tranqu ility', 'tranquility')
                        .replaceAll('mah ayuga', 'mahayuga')
                        .replaceAll('dem ig ods', 'demigods')
                        .replaceAll('sacr ificial', 'sacrificial')
                        .replaceAll('prog en itor', 'progenitor')
                        .replaceAll('array ed', 'arrayed')
                        .replaceAll('disc arding', 'discarding')
                        .replaceAll(RegExp("[^A-Za-z,.?!']"), " ")
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
                          .replaceAll(" '", "'")
                          .replaceAll("' ", " ")
                          .replaceAll(RegExp("[^A-Za-z,.?!']"), " "),
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
                          .replaceAll(" '", "'")
                          .replaceAll("' ", " ")
                          .replaceAll(RegExp("[^A-Za-z,.?!']"), " "),
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
                      .replaceAll(" '", "'")
                      .replaceAll("' ", " ")
                      .replaceAll(RegExp("[^A-Za-z,.?!']"), " "),
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
                                  child: Text(data.message,
                                      style: TextStyle(
                                          color: Color.fromRGBO(17, 24, 39, 1),
                                          fontSize: 16,
                                          fontFamily: 'Inter')),
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
                                          color: Color.fromRGBO(17, 24, 39, 1),
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
                                          Text(
                                            data.message,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    17, 24, 39, 1),
                                                fontSize: 16,
                                                fontFamily: 'Inter'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              note,
                                              style: TextStyle(fontSize: 12),
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
                ? SizedBox(
                    height: 5,
                  )
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
                                color: Color.fromRGBO(17, 24, 39, 1),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold),
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
              cursorColor: Color.fromRGBO(255, 193, 7, 1),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: suggestionList.isEmpty
                            ? Radius.circular(5)
                            : Radius.circular(0),
                        topRight: suggestionList.isEmpty
                            ? Radius.circular(5)
                            : Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300), //<-- SEE HERE
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: suggestionList.isEmpty
                            ? Radius.circular(5)
                            : Radius.circular(0),
                        topRight: suggestionList.isEmpty
                            ? Radius.circular(5)
                            : Radius.circular(0),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(255, 193, 7, 1), width: 1.5),
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

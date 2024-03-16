import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  TextEditingController _userInput = TextEditingController();

  static const apiKey = "AIzaSyDiWaCOr-hqvR95YL7NalbjUtaR1pElrKU";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String words = "";
  final List<Message> _messages = [];
  var isLoading = false.obs();
  bool isListening = false;
  

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
    });
  }
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _userInput.text = result.recognizedWords;
    });
  }



  Future<void> sendMessage() async {
    final message = _userInput.text;
    print(message);

    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }
  String message = "Enter you Text here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
           Positioned(
              bottom: 60,
              right: 3,
              child: GestureDetector(
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.getColor(77)
                  ),
                  child: Center(
                    child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic,color: Colors.white,),
                  ),
                ),
                 onTap: (){
                setState(() {
                  print("Callked");
                  message = "Listening your voice...";
                  _speechToText.isNotListening ? _startListening() : _stopListening();
                  _userInput.text = "";
                });
              },
                
              ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Breeze ",style: TextStyle(fontFamily: 'man-sb',fontSize: 18),),
      ),
      body: Container(


        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                          isUser: message.isUser,
                          message: message.message,
                          date: DateFormat('HH:mm').format(message.date));
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: TextFormField(
                      controller: _userInput,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: Text(message),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: IconButton(
                        padding: EdgeInsets.all(12),
                        iconSize: 30,
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(CircleBorder())),
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(Icons.send)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15)
          .copyWith(left: isUser ? 100 : 10, right: isUser ? 10 : 100),
      decoration: BoxDecoration(
          color: isUser ? Color.fromARGB(255, 97, 255, 142) : Colors.blueAccent ,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
              topRight: Radius.circular(10),
              bottomRight: isUser ? Radius.zero : Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
                fontSize: 16, color: isUser ? Colors.white : Colors.white),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 10,
              color: isUser ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
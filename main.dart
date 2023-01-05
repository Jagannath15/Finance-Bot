import 'package:chatbot_app/message.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chatbot() ,
    );
  }
}


class Chatbot extends StatefulWidget {
   Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
   late DialogFlowtter dialogFlowtter;
  final TextEditingController controller=TextEditingController();

 void initState() {
    
    

    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }
    List<Map<String, dynamic>> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finance Bot"),
        backgroundColor: Color.fromARGB(255, 65, 118, 197)
      ),

      body: Container(
        child: Column(
          children: [
            Expanded(child: Messagescreen(messages: messages)),
            

            Row(
              children: [
                SizedBox(width: 5,),
                Expanded(
                  child: Material(
                    elevation: 40,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(    
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5), 
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                         controller: controller,

                         cursorColor: Color.fromARGB(255, 65, 118, 197) ,
                         decoration: InputDecoration(
                          hintText: "Type message here",
                          hintStyle: TextStyle(fontSize: 20),
                          focusColor:  Color.fromARGB(255, 65, 118, 197),
                         border: InputBorder.none
                         ),
                      ),
                      
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                IconButton(
                      onPressed: () {
                        sendMessage(controller.text);
                        controller.clear();
                      },
                      icon: Icon(Icons.send,color:  Color.fromARGB(255, 65, 118, 197),)),
              ],
            ),

            SizedBox(height: 7,)
          ],
        ),
      ),
    );
  }

  void sendMessage(String text) async {
  if(text.isEmpty){
    print("Wow so empty");
  }
  else{
    setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
    });
    DetectIntentResponse response=await  dialogFlowtter.detectIntent(queryInput: QueryInput(text: TextInput(text: text)));
    if(response==null)return;
    setState(() {
         addMessage(response.message!);
      });
      }
}

void addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
}

}




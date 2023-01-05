
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Messagescreen extends StatefulWidget {
  final List messages;
  const Messagescreen({super.key,required this.messages});
  @override
  State<Messagescreen> createState() => _MessagescreenState();
}
class _MessagescreenState extends State<Messagescreen> {
  @override
   
  Widget build(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
    return ListView.separated(itemBuilder: (context,index){
      return Container(
        margin: EdgeInsets.all(10),
        child: Row(
           mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          
          children: [
             Material(
              elevation: 20,
              borderRadius:BorderRadius.only(
                            bottomLeft: Radius.circular(
                              20,
                            ),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 0 : 20),
                            topLeft: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 20 : 0),
                          ), 
               child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              20,
                            ),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 0 : 20),
                            topLeft: Radius.circular(
                                widget.messages[index]['isUserMessage'] ? 20 : 0),
                          ),
                          color: widget.messages[index]['isUserMessage']
                              ?  Color.fromARGB(255, 65, 118, 197)
                              : Colors.white70),
                      constraints: BoxConstraints(maxWidth: w * 2 / 3),
                      child:
                          Text(widget.messages[index]['message'].text.text[0])),
             ),
          ],
        ),
      );
    }, separatorBuilder: (_,i)=>Padding(padding: EdgeInsets.only(top: 10)), itemCount: widget.messages.length);
  }
}
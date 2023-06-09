import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_cafes/main.dart';
import 'package:internet_cafes/models/computer.dart';

class ComputerChat extends StatefulWidget {
  final Computer computer;
  const ComputerChat({required this.computer,super.key});

  @override
  State<ComputerChat> createState() => _ComputerChatState();
}

class _ComputerChatState extends State<ComputerChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Khách máy ${widget.computer.id}",style: const TextStyle(color: Colors.white, fontSize: 23),),
      ),
      body:Container(
        color:Colors.grey[350],
        child: Column(
          children: [
            Container(height: 40,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                //color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: () {},
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Tin nhắn',
                          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.black26),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                   const  SizedBox(width: 10),
                    MaterialButton(
                      onPressed: () {},
                      minWidth: 0,
                      padding: const EdgeInsets.all(10),
                      color: Colors.blue,
                      shape: const  CircleBorder(),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));

      /*Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Row(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              color: Colors.white60,
              child: Row(
                children: [
                  Container(
                    width: mq.width * 0.74,
                    child: TextField(
                      onTap: () {},
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Colors.white60,
                            fontSize: 18),
                        hintText: 'Tin nhắn',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30.0),
                          //borderSide: BorderSide(color: Colors.white70),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30.0),
                          //borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {},
              //minWidth: 0,
              padding: const EdgeInsets.fromLTRB(10, 15, 5, 15),
              color: Colors.blue,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
      ),*/
  }
}

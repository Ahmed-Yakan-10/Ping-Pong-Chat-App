import 'package:flutter/material.dart';
import 'package:pingpong/constants.dart';
import 'package:pingpong/models/message.dart';
import 'package:pingpong/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  ChatView({super.key});

  static String id = 'ChatView';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessageCollections);

  TextEditingController controller = TextEditingController();
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for(int i=0; i< snapshot.data!.docs.length; i++){
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kIcon,
                      height: 50,
                    ),
                    Text(
                      ' Ping-Pong',
                      style: TextStyle(
                        fontFamily: kFont,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email? ChatBubble(
                          message: messageList[index],
                        ): ChatBubbleForFriend(message: messageList[index],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data){
                        messages.add({
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          kId : email,
                        });
                        controller.clear();
                        scrollController.animateTo(
                            0,
                            duration: Duration(seconds: 1,),
                            curve: Curves.easeIn,
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Send Message',
                        hintStyle: TextStyle(
                          fontFamily: kFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          }

        }
    );
  }
}

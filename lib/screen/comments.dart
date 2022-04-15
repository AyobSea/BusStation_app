import 'package:flutter/material.dart';
import 'package:busproject/Register/register_styles.dart';
import 'package:styled_text/styled_text.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(color: busclay),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 45, left: 15),
                child: Column(
                  children: const [
                    
                    TopWidget(mainText: 'Send Us Your Comment', subText:'\n what do you think of our service?\n let us know by fill this form'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(color: busbottom),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: StyledText(
                      text:
                          '<bold><size><black>How was your experince?</size></black></bold>',
                      tags: {
                        'bold': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold,),),
                        'white': StyledTextTag(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: busblackBlue)),
                        'size': StyledTextTag(style: TextStyle(fontSize: 26))
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 3)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    maxLines: 9,
                    maxLength: 520,
                    
                    
                    ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({
    Key? key,
    required this.mainText,
    required this.subText,
  }) : super(key: key);

  final String mainText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: StyledText(
            text: '<bold><size><white>$mainText</size></white></bold>',
            tags: {
              'white': StyledTextTag(
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              'size': StyledTextTag(style: TextStyle(fontSize: 26))
            },
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: StyledText(
            text: '<white><size>$subText</size></white>',
            tags: {
              'white': StyledTextTag(
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              'size': StyledTextTag(style: TextStyle(fontSize: 14))
            },
          ),
        ),
      ],
    );
  }
}

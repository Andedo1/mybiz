import 'package:flutter/material.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimension.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(height: 1.8, size: Dimension.font16, text: firstHalf,) : Column(
        children: [
          SmallText(height: 1.8, size: Dimension.font16, text: hiddenText? (firstHalf+"..."): (firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText? "Show more..": "Show less", color: Colors.lightBlueAccent,),
                Icon(hiddenText? Icons.arrow_drop_down: Icons.arrow_drop_up, color: Colors.lightBlueAccent,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

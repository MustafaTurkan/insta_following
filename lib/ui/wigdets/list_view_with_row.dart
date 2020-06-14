import 'package:flutter/material.dart';
import 'package:insta_following/ui/wigdets/delayed_animation.dart';

class ListViewWithRow<T> extends StatefulWidget {
  
  ListViewWithRow({Key key,@required this.items,@required this.rowCount,@required this.itemBuilder}) : super(key: key);
  final List<T> items;
  final int rowCount;
  final Widget Function(T) itemBuilder;

  @override
  _ListViewWithRowState<T> createState() => _ListViewWithRowState<T>();
}

class _ListViewWithRowState<T> extends State<ListViewWithRow<T>> {
  int _delayAmount=0;

  @override
  Widget build(BuildContext context){
     List<T> rowList; 
     int currentRowCount=1; 
     return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, i) {
        if (currentRowCount<widget.rowCount) {
          rowList=<T>[];
          rowList.add(widget.items[i]);
          currentRowCount++;
           return SizedBox.shrink();
        } 
       else {
          currentRowCount=1;
          rowList.add(widget.items[i]);
          _delayAmount=_delayAmount+750;
          return Row(
              children: List<Widget>.generate(
                  rowList.length,
                  (i) =>Expanded(child: DelayedAnimation(delay:_delayAmount , child: widget.itemBuilder(rowList[i]))) ));
        }
      },
    );
  }
}



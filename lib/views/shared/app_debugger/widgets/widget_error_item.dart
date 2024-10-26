import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDebuggerErrorItem extends StatefulWidget {
  final int index;
  final Map data;
  const AppDebuggerErrorItem({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  State<AppDebuggerErrorItem> createState() => _AppDebuggerErrorItemState();
}

class _AppDebuggerErrorItemState extends State<AppDebuggerErrorItem> {
  bool isShowDetail = false;
  List<Map<String, dynamic>> jsonMapList = [];

  @override
  void initState() {
    super.initState();
  }

  handleCopyResponse() {
    Clipboard.setData(ClipboardData(text: jsonEncode(widget.data)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        isShowDetail = !isShowDetail;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(
          color:
              isShowDetail ? Colors.white.withOpacity(0.2) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "${widget.data['timestamp']}",
                style: TextStyle(
                  color: widget.index == 0
                      ? Colors.amberAccent.withOpacity(1)
                      : Colors.grey.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Icon(
                isShowDetail ? Icons.arrow_drop_down : Icons.arrow_right,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: Text(
                        "${widget.data['error']}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (isShowDetail)
                      Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 2,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.only(top: 10, left: 2),
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "${widget.data['error']}",
                            style: TextStyle(
                              color: Colors.red.withOpacity(1),
                              fontSize: 12,
                            ),
                          )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

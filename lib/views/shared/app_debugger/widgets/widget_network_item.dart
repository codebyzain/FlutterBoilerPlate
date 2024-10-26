import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDebuggerNetworkItem extends StatefulWidget {
  final int index;
  final Map data;
  const AppDebuggerNetworkItem({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);

  @override
  State<AppDebuggerNetworkItem> createState() => _AppDebuggerNetworkItemState();
}

class _AppDebuggerNetworkItemState extends State<AppDebuggerNetworkItem> {
  bool isShowDetail = false;
  List<Map<String, dynamic>> jsonMapList = [];

  @override
  void initState() {
    super.initState();
    if (widget.data["body"] != "") {
      final mapDataResult = getJsonData(widget.data["body"]);
      setState(() {
        jsonMapList = mapDataResult;
      });
    }
  }

  getJsonData(jsonData) {
    try {
      List<Map<String, dynamic>> data = [];

      for (var jsonKey in jsonData.keys) {
        Map<String, dynamic> jsonMap = {
          "label": jsonKey,
          "value": jsonData[jsonKey]
        };
        data.add(jsonMap);
      }

      return data;
    } catch (e) {
      List<Map<String, dynamic>> data = [];
      return data;
    }
  }

  renderValue(value) {
    Type valueType = value.runtimeType;
    Color textColor = Colors.green;

    if (valueType == bool) {
      if (value == true) {
        textColor = Colors.blue;
      } else {
        textColor = Colors.red;
      }
    }
    if (valueType == Null) {
      textColor = Colors.amber;
    }

    return Text(
      valueType == String ? "\"$value\"" : "$value",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: textColor,
        fontSize: 12,
      ),
    );
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

        // color: (widget.index % 2 == 0)
        //     ? Colors.white.withOpacity(0.2)
        //     : Colors.transparent,
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
                        "${widget.data['method'] ?? "GET"} ${widget.data['path']}",
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
                        child: widget.data["body"] == ""
                            ? Text(
                                "No response returned from this request",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: jsonMapList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "\"${jsonMapList[index]['label']}\"",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 2,
                                        ),
                                        child: Icon(
                                          Icons.arrow_right,
                                          color: Colors.grey.withOpacity(0.5),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: renderValue(
                                          jsonMapList[index]['value'],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                      ),
                    if (isShowDetail)
                      TextButton.icon(
                        onPressed: handleCopyResponse,
                        icon: const Icon(
                          Icons.copy_outlined,
                          size: 13,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Copy Response",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "${widget.data['statusCode']}",
                style: TextStyle(
                  color: widget.data['statusCode'] == 200
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

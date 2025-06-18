import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/lib/services/extensions.dart';

import '../../services/constants.dart';
import '../../services/theme.dart';

///TODO: Define toString() method for the model or Pass a data as List of String.
class DropDownKiller<T> extends StatefulWidget {
  const DropDownKiller({super.key, required this.data, required this.onSelected, this.title = "Search"});
  final String? title;
  final List<T> data;
  final Function(T result) onSelected;

  @override
  State<DropDownKiller<T>> createState() => _DropDownKillerState<T>();
}

class _DropDownKillerState<T> extends State<DropDownKiller<T>> {
  List<T> searchedList = [];

  TextEditingController textEditingController = TextEditingController();

  onSearched(String key) {
    searchedList.clear();
    for (var element in widget.data) {
      if (element.toString().toLowerCase().contains(key.toLowerCase())) {
        searchedList.add(element);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    bool searched = textEditingController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(widget.title.getIfValid),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.padding),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: greyLight,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                controller: textEditingController,
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  suffixIconConstraints: const BoxConstraints(minWidth: 18, maxWidth: 18, minHeight: 18, maxHeight: 18),
                  contentPadding: EdgeInsets.zero,
                  hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: greyLight,
                      ),
                  suffix: textEditingController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            textEditingController.clear();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.cancel,
                          ),
                        )
                      : null,
                  hintText: 'Search',
                ),
                onChanged: onSearched,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: searched ? searchedList.length : widget.data.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      searched ? widget.onSelected(searchedList[index]) : widget.onSelected(widget.data[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(top: 14),
                      color: Colors.transparent,
                      child: Text(
                        searched ? searchedList[index].toString() : widget.data[index].toString(),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: textPrimary,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/instance_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/basic_controller.dart';
import 'package:village_wheels_delivery_boy/services/enums/settings_enum.dart';

import 'CustomEmptyDataWidget.dart';

class CustomHtmlScreen extends StatefulWidget {
  const CustomHtmlScreen({super.key, required this.title, this.htmlContent, this.businessSettingName});
  final String title;
  final String? htmlContent;
  final BusinessSettingName? businessSettingName;

  @override
  State<CustomHtmlScreen> createState() => _CustomHtmlScreenState();
}

class _CustomHtmlScreenState extends State<CustomHtmlScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? htmlContent = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.htmlContent != null) {
        htmlContent = widget.htmlContent;
      } else if (widget.businessSettingName != null) {
        htmlContent = Get.find<BasicController>().getHtmlContent(widget.businessSettingName!);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: htmlContent == ''
          ? const Center(
        child: EmptyWidget(),
      ) : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: SingleChildScrollView(
          child: Html(
            data: htmlContent!.replaceAll('<br>', ''),
          ),
        ),
      ),
    );
  }
}

import 'package:accordion/accordion_section.dart';
import 'package:flutter/cupertino.dart';

class CustomAccordionSection extends StatefulWidget{
  Widget header;
  Widget content;
  CustomAccordionSection({required this.header, required this.content});
  @override
  State<StatefulWidget> createState() => _CustomAccordionSection();
}

class _CustomAccordionSection extends State<CustomAccordionSection>{
  @override
  Widget build(BuildContext context) {
    return AccordionSection(header: widget.header, content: widget.content);
  }
}
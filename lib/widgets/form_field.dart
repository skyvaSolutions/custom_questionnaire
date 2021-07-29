import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../main.dart';

class CustomFormField extends StatefulWidget {
  final String type;
  final String title;
  final String labelText;
  final List<dynamic> multipleChoices;
  final List<dynamic> radioChoices;
  final List<dynamic> sliderChoices;
  final List<dynamic> dropDownChoices;
  final List<dynamic> chipChoices;
  final bool isOptional;
  const CustomFormField(
      {Key? key,
      required this.title,
      required this.type,
      required this.chipChoices,
      required this.dropDownChoices,
      required this.multipleChoices,
      required this.radioChoices,
      required this.sliderChoices,
      required this.labelText,
      required this.isOptional})
      : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

InputDecoration inputDecoration (String labelText , bool required){
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.grey[800],
    ),

    suffixText: !required ? '*' : '',
    suffixStyle: const TextStyle(
      color: Colors.red,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black87,
        width: 1.0
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: teal,
        width: 2.0,
      ),
    ),
  );
}

bool enabled = true;

class _CustomFormFieldState extends State<CustomFormField> {

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: teal,
                secondary: teal,
              ),
            ),
            child: child!,
          );
        },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type.toLowerCase().contains("name")) {
      return FormBuilderTextField(
        name: widget.title,
        enabled: enabled,
        cursorColor: teal,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        onChanged: (String? val) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.max(context, 70),
        ]),
        keyboardType: TextInputType.name,
      );
    }
    if (widget.type.toLowerCase().contains("email")) {
      return FormBuilderTextField(
        name: widget.title,
        enabled: enabled,
        cursorColor: teal,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        onChanged: (String? val) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        keyboardType: TextInputType.emailAddress,
      );
    }
    if (widget.type.toLowerCase().contains("phone")) {
      return FormBuilderTextField(
        name: widget.title,
        enabled: enabled,
        cursorColor: teal,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        onChanged: (String? val) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.numeric(context),
        ]),
        keyboardType: TextInputType.phone,
      );
    }
    if (widget.type.toLowerCase().contains("text")) {
      return FormBuilderTextField(
        name: widget.title,
        enabled: enabled,
        cursorColor: teal,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        onChanged: (String? val) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        keyboardType: TextInputType.text,
      );
    }
    if (widget.type.toLowerCase().contains("yes")) {
      return FormBuilderRadioGroup(
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        name: widget.title,
        enabled: enabled,
        wrapAlignment: WrapAlignment.spaceAround,
        activeColor: teal,
        validator: FormBuilderValidators.required(context),
        options: [
          'Yes',
          'No',
        ]
            .map((lang) => FormBuilderFieldOption(value: lang))
            .toList(growable: false),
      );
    }
    if (widget.type.toLowerCase().contains("multiple choice")) {
      return FormBuilderCheckboxGroup(
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        name: widget.title,
        enabled: enabled,
        activeColor: teal,
        onChanged: (List<Object?>? val) {},
        options: widget.multipleChoices.map((option) => FormBuilderFieldOption(value: option))
            .toList(growable: false),
      );
    }
    if (widget.type.toLowerCase().contains("radio")) {
      return FormBuilderRadioGroup(
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        name: widget.title,
        enabled: enabled,
        activeColor: teal,
        validator: FormBuilderValidators.required(context),
        options: widget.radioChoices.map((option) => FormBuilderFieldOption(value: option))
            .toList(growable: false),
      );
    }
    if (widget.type.toLowerCase().contains("slider")) {
      return FormBuilderSlider(
        name: widget.title,
        enabled: enabled,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.min(context, 6),
        ]),
        onChanged: (double? val) {},
        min: double.parse(widget.sliderChoices[0]),
        max: double.parse(widget.sliderChoices[widget.sliderChoices.length - 1]),
        initialValue: double.parse(widget.sliderChoices[0]),
        divisions:
            double.parse(widget.sliderChoices[widget.sliderChoices.length - 1]).round() -
                double.parse(widget.sliderChoices[0]).round(),
        activeColor: teal,
        inactiveColor: Colors.black87,
        decoration:inputDecoration(widget.labelText , widget.isOptional),
      );
    }
    if (widget.type.toLowerCase().contains("dropdown") || widget.type.toLowerCase().contains("select1of4")) {
      return FormBuilderDropdown(
        name: widget.title,
        enabled: enabled,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        allowClear: true,
        validator: FormBuilderValidators.compose(
            [FormBuilderValidators.required(context)]),
        items: widget.dropDownChoices
            .map(
              (option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ),
            )
            .toList(),
      );
    }
    if (widget.type.toLowerCase().contains("chip")) {
      return FormBuilderChoiceChip(
        name: widget.title,
        enabled: enabled,
        selectedColor: teal,
        alignment: WrapAlignment.spaceAround,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        options: widget.chipChoices
            .map((option) => FormBuilderFieldOption(value: option , child: Text(option , style: const TextStyle(color: Colors.black87),),))
            .toList(growable: false),
      );
    }
    if (widget.type.toLowerCase().contains("switch")) {
      return FormBuilderSwitch(
        name: widget.title,
        activeColor: teal,
        enabled: enabled,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        title: Text(widget.labelText),
      );
    }
    if (widget.type.toLowerCase().contains("date")) {
      return Builder(
        builder: (context) => TextField(
          onTap: ()=> _selectDate(context),
          cursorColor: teal,
          enabled: enabled,
          decoration: inputDecoration(widget.labelText , widget.isOptional),
        ),
      );
    }
    if (widget.type.toLowerCase().contains("banner") || widget.type.toLowerCase().contains("statement") ) {
      return Builder(
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          color: teal.withOpacity(0.2),
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 15.0,
              fontWeight: FontWeight.w300
            ),
          ),
        ),
      );
    }
    if (widget.type.toLowerCase().contains("comment")) {
      return FormBuilderTextField(
        name: widget.title,
        enabled: enabled,
        cursorColor: teal,
        maxLines: 5,
        decoration: inputDecoration(widget.labelText , widget.isOptional),
        onChanged: (String? val) {},
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
        keyboardType: TextInputType.text,
      );
    }

    return Container();
  }
}

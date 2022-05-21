import 'package:aluno_mobile_flutter/datasources/helpers/course_helper.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:flutter/material.dart';

class CadCoursePage extends StatefulWidget {
  const CadCoursePage({Key? key}) : super(key: key);

  @override
  State<CadCoursePage> createState() => _CadCoursePageState();
}

class _CadCoursePageState extends State<CadCoursePage> {
  AcademicDegree? _academicDegree;
  final TextEditingController _mecIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Curso',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WTextField(
            labelText: 'Mec id',
            textEditingController: _mecIdController,
            textInputType: TextInputType.number,
            paddingTop: 20,
          ),
          WTextField(
            labelText: 'Descrição',
            textEditingController: _descriptionController,
          ),
          _dropdownAcademicDegree(),
        ],
      ),
    );
  }

  void _save() {
    Course course = Course(
      mecId: int.parse(_mecIdController.text),
      description: _descriptionController.text,
      academicDegree: _academicDegree!.toInt()
    );

    CourseHelper courseHelper = CourseHelper();
    courseHelper.insert(course);

    Navigator.pop(context);
  }

  Widget _dropdownAcademicDegree() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 30,
          right: 30
      ),
      child: DropdownButtonFormField<AcademicDegree>(
        value: _academicDegree,
        decoration: const InputDecoration(
          label: WLabelInputDecoration(
            labelText: 'Grau Acadêmico',
          ),
          labelStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            _academicDegree = newValue;
          });
        },
        items: AcademicDegree.values.map((AcademicDegree academicDegree) {
          return DropdownMenuItem<AcademicDegree>(
            value: academicDegree,
            child: Text(academicDegree.getDescription()),
          );
        }).toList(),
      ),
    );
  }
}

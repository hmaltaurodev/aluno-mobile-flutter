import 'package:aluno_mobile_flutter/datasources/helpers/course_helper.dart';
import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class CadCoursePage extends StatefulWidget {
  final Course? course;

  const CadCoursePage({
    this.course,
    Key? key
  }) : super(key: key);

  @override
  State<CadCoursePage> createState() => _CadCoursePageState();
}

class _CadCoursePageState extends State<CadCoursePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mecIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  AcademicDegree? _academicDegree;
  Course? _course;

  @override
  void initState() {
    super.initState();
    _course = widget.course;
    _loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cadastro de Curso',
      onPressedFAB: _save,
      iconFAB: const Icon(Icons.save),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WTextField(
                labelText: 'MEC ID',
                textEditingController: _mecIdController,
                validator: _validateMecId,
                textInputType: TextInputType.number,
                paddingTop: 20,
              ),
              WTextField(
                labelText: 'Descrição',
                textEditingController: _descriptionController,
                validator: _validateDescription,
              ),
              _dropdownAcademicDegree(),
            ],
          ),
        ),
      ),
    );
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
        validator: _validateAcademicDegree,
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

  void _save() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      CourseHelper courseHelper = CourseHelper();

      if (_course == null) {
        Course course = Course(
          mecId: int.parse(_mecIdController.text),
          description: _descriptionController.text,
          academicDegree: _academicDegree!.toInt()
        );

        courseHelper.insert(course);
      }
      else {
        _course!.mecId = int.parse(_mecIdController.text);
        _course!.description = _descriptionController.text;
        _course!.academicDegree = _academicDegree!.toInt();

        courseHelper.update(_course!);
      }

      Navigator.pop(context);
    }
  }

  void _loadCourse() {
    if (_course != null) {
      _mecIdController.text = _course!.mecId.toString();
      _descriptionController.text = _course!.description;
      _academicDegree = Utils.academicDegreeByInt(_course!.academicDegree);
    }
  }

  String? _validateMecId(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe o MEC ID';
    }

    if (int.parse(string) == 0) {
      return 'Informe um MEC ID valido';
    }

    return null;
  }

  String? _validateDescription(String? string) {
    if (string == null || string.trim().isEmpty) {
      return 'Informe a Descrição';
    }

    return null;
  }

  String? _validateAcademicDegree(AcademicDegree? academicDegree) {
    if (academicDegree == null) {
      return 'Selecione um Grau Acadêmico';
    }

    return null;
  }
}

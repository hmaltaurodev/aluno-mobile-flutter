import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final StudentHelper _studentHelper = StudentHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Alunos',
      onPressedFAB: () {
        _openCadPage(null);
      },
      iconFAB: const Icon(Icons.add),
      body: FutureBuilder(
        future: _studentHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              return _createListViewBuilder(snapshot);
          }
        },
      ),
    );
  }

  void _openCadPage(Student? student) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadStudentPage(
          student: student
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(Student student) {

  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<Student> students = (snapshot.data as List<Student>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return WSlidable(
          title: students[index].toString(),
          slideableActions: _createSlidablesActions(students[index]),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(Student student) {
    return [
      SlidableAction(
        icon: Icons.edit,
        label: 'Editar',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: (context) {
          _openCadPage(student);
        },
      ),
      SlidableAction(
        icon: Utils.activeInactiveIcon(student.isActive == 1),
        label: Utils.activeInactiveLabel(student.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(student.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(student);
        },
      ),
    ];
  }
}

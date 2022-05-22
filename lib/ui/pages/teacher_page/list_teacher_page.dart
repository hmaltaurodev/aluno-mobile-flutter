import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  final TeacherHelper _teacherHelper = TeacherHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Professores',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openCadPage();
        },
      ),
      body: FutureBuilder(
        future: _teacherHelper.getAll(),
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

  void _openCadPage({Teacher? teacher}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadTeacherPage(
          teacher: teacher,
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(Teacher teacher) {
    setState(() {
      teacher.isActive = (teacher.isActive == 1) ? 0 : 1;
      _teacherHelper.update(teacher);
    });
  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<Teacher> teachers = (snapshot.data as List<Teacher>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return WSlidable(
          child: ListTile(
            title: Text(teachers[index].toString()),
          ),
          slideableActions: _createSlidablesActions(teachers[index]),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(Teacher teacher) {
    return [
      SlidableAction(
        icon: Icons.edit,
        label: 'Editar',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: (context) {
          _openCadPage(teacher: teacher);
        },
      ),
      SlidableAction(
        icon: Utils.activeInactiveIcon(teacher.isActive == 1),
        label: Utils.activeInactiveLabel(teacher.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(teacher.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(teacher);
        },
      ),
    ];
  }
}

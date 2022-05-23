import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ListClassroomPage extends StatefulWidget {
  const ListClassroomPage({Key? key}) : super(key: key);

  @override
  State<ListClassroomPage> createState() => _ListClassroomPageState();
}

class _ListClassroomPageState extends State<ListClassroomPage> {
  final ClassroomHelper _classroomHelper = ClassroomHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Turmas',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openCadPage(null);
        },
      ),
      body: FutureBuilder(
        future: _classroomHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
            default:
              return _listViewBuilder(snapshot);
          }
        },
      ),
    );
  }

  void _openCadPage(Classroom? classroom) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadClassroomPage(
          classroom: classroom,
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(Classroom classroom) {
    setState(() {
      classroom.isActive = (classroom.isActive == 1) ? 0 : 1;
      _classroomHelper.update(classroom);
    });
  }

  Widget _listViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<Classroom> classrooms = (snapshot.data as List<Classroom>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        return WSlidable(
          child: ListTile(
            title: Text(classrooms[index].toString()),
          ),
          slideableActions: _createSlidablesActions(classrooms[index]),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(Classroom classroom) {
    return [
      SlidableAction(
        icon: Utils.activeInactiveIcon(classroom.isActive == 1),
        label: Utils.activeInactiveLabel(classroom.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(classroom.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(classroom);
        },
      ),
    ];
  }
}

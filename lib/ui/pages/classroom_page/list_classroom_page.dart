import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turmas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _classroomHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<Classroom>);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _openCadPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const BottomAppBar(
        child: Padding(
          child: Icon(null),
          padding: EdgeInsets.all(8),
        ),
      ),
      extendBody: true,
    );
  }

  void _openCadPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CadClassroomPage()
        )
    );
  }

  Widget _listViewBuilder(List<Classroom> classrooms) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: classrooms.length,
      itemBuilder: (context, index) {
        return _slidable(classrooms[index]);
      },
    );
  }

  Widget _slidable(Classroom classroom) {
    return Slidable(
      child: ListTile(
        title: Text(classroom.currriculumGrideId.toString()),
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            icon: Icons.edit,
            label: 'Editar',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: (context) {
              _openCadPage();
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            icon: Icons.blur_off,
            label: 'Inativar',
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: (context) {},
          ),
        ],
      ),
    );
  }
}

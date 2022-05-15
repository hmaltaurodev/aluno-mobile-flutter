import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({Key? key}) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  final TeacherHelper _teacherHelper = TeacherHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Professores'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _teacherHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<Teacher>);
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
            builder: (context) => const CadTeacherPage()
        )
    );
  }

  Widget _listViewBuilder(List<Teacher> teachers) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        return _slidable(teachers[index]);
      },
    );
  }

  Widget _slidable(Teacher teacher) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.blueGrey.shade50,
          elevation: 0,
          child: Slidable(
            child: ListTile(
              title: Text(teacher.name),
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
                SlidableAction(
                  icon: Icons.blur_off,
                  label: 'Inativar',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  onPressed: (context) {
                    _openCadPage();
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}

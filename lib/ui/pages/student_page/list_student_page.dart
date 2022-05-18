import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

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
      onPressedFAB: _openCadPage,
      iconFAB: const Icon(Icons.add),
      body: FutureBuilder(
        future: _studentHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<Student>);
          }
        },
      ),
    );
  }

  void _openCadPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CadStudentPage()
        )
    );
  }

  Widget _listViewBuilder(List<Student> students) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return _slidable(students[index]);
      },
    );
  }

  Widget _slidable(Student student) {
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
            title: Text(student.name),
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

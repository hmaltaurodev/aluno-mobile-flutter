import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/discipline_page/cad_discipline_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ListDisciplinePage extends StatefulWidget {
  const ListDisciplinePage({Key? key}) : super(key: key);

  @override
  State<ListDisciplinePage> createState() => _ListDisciplinePageState();
}

class _ListDisciplinePageState extends State<ListDisciplinePage> {
  final DisciplineHelper _disciplineHelper = DisciplineHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Disciplinas',
      onPressedFAB: _openCadPage,
      iconFAB: const Icon(Icons.add),
      body: FutureBuilder(
        future: _disciplineHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<Discipline>);
          }
        },
      ),
    );
  }

  void _openCadPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CadDisciplinePage()
      )
    );
  }

  Widget _listViewBuilder(List<Discipline> disciplines) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: disciplines.length,
      itemBuilder: (context, index) {
        return _slidable(disciplines[index]);
      },
    );
  }

  Widget _slidable(Discipline discipline) {
    return Slidable(
      child: ListTile(
        title: Text(discipline.description),
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
    );
  }
}

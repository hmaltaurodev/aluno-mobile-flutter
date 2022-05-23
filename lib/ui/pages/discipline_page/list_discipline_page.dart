import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openCadPage(null);
        },
      ),
      body: FutureBuilder(
        future: _disciplineHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
            default:
              return _createListViewBuilder(snapshot);
          }
        },
      ),
    );
  }

  void _openCadPage(Discipline? discipline) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadDisciplinePage(
          discipline: discipline,
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(Discipline discipline) {
    setState(() {
      discipline.isActive = (discipline.isActive == 1) ? 0 : 1;
      _disciplineHelper.update(discipline);
    });
  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<Discipline> disciplines = (snapshot.data as List<Discipline>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: disciplines.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _openCadPage(disciplines[index]);
          },
          child: WSlidable(
            child: ListTile(
              title: Text(disciplines[index].toString()),
            ),
            slideableActions: _createSlidablesActions(disciplines[index]),
          ),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(Discipline discipline) {
    return [
      SlidableAction(
        icon: Icons.edit,
        label: 'Editar',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: (context) {
          _openCadPage(discipline);
        },
      ),
      SlidableAction(
        icon: Utils.activeInactiveIcon(discipline.isActive == 1),
        label: Utils.activeInactiveLabel(discipline.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(discipline.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(discipline);
        },
      ),
    ];
  }
}

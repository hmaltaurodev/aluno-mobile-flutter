import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/curriculum_gride_page/cad_curriculum_gride_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ListCurriculumGridePage extends StatefulWidget {
  const ListCurriculumGridePage({Key? key}) : super(key: key);

  @override
  State<ListCurriculumGridePage> createState() => _ListCurriculumGridePageState();
}

class _ListCurriculumGridePageState extends State<ListCurriculumGridePage> {
  final CurriculumGrideHelper _curriculumGrideHelper = CurriculumGrideHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Grades Curriculares',
      onPressedFAB: _openCadPage,
      iconFAB: const Icon(Icons.add),
      body: FutureBuilder(
        future: _curriculumGrideHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<CurriculumGride>);
          }
        },
      ),
    );
  }

  void _openCadPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CadCurriculumGridePage()
        )
    );
  }

  Widget _listViewBuilder(List<CurriculumGride> curriculumsGrides) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: curriculumsGrides.length,
      itemBuilder: (context, index) {
        return _slidable(curriculumsGrides[index]);
      },
    );
  }

  Widget _slidable(CurriculumGride curriculumGride) {
    return Slidable(
      child: ListTile(
        title: Text(curriculumGride.course.id.toString()),
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

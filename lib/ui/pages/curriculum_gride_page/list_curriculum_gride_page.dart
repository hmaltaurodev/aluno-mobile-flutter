import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/curriculum_gride_page/cad_curriculum_gride_page.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
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
      onPressedFAB: () {
        _openCadPage(null);
      },
      iconFAB: const Icon(Icons.add),
      body: FutureBuilder(
        future: _curriculumGrideHelper.getAll(),
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

  void _openCadPage(CurriculumGride? curriculumGride) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadCurriculumGridePage(
          curriculumGride: curriculumGride,
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(CurriculumGride curriculumGride) {
    setState(() {
      curriculumGride.isActive = (curriculumGride.isActive == 1) ? 0 : 1;
      _curriculumGrideHelper.update(curriculumGride);
    });
  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<CurriculumGride> curriculumGrides = (snapshot.data as List<CurriculumGride>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: curriculumGrides.length,
      itemBuilder: (context, index) {
        return WSlidable(
          title: curriculumGrides[index].toString(),
          slideableActions: _createSlidablesActions(curriculumGrides[index]),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(CurriculumGride curriculumGride) {
    return [
      SlidableAction(
        icon: Icons.edit,
        label: 'Editar',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: (context) {
          _openCadPage(curriculumGride);
        },
      ),
      SlidableAction(
        icon: Utils.activeInactiveIcon(curriculumGride.isActive == 1),
        label: Utils.activeInactiveLabel(curriculumGride.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(curriculumGride.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(curriculumGride);
        },
      ),
    ];
  }
}

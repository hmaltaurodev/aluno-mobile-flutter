import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:aluno_mobile_flutter/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({Key? key}) : super(key: key);

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  final CourseHelper _courseHelper = CourseHelper();

  @override
  Widget build(BuildContext context) {
    return WScaffold(
      title: 'Cursos',
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openCadPage(null);
        },
      ),
      body: FutureBuilder(
        future: _courseHelper.getAll(),
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

  void _openCadPage(Course? course) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadCoursePage(
          course: course,
        )
      )
    );

    setState(() {});
  }

  void _activateInactivate(Course course) {
    setState(() {
      course.isActive = (course.isActive == 1) ? 0 : 1;
      _courseHelper.update(course);
    });
  }

  Widget _createListViewBuilder(AsyncSnapshot snapshot) {
    if (snapshot.hasError) {
      return Text('Erro: ${snapshot.error}');
    }

    List<Course> courses = (snapshot.data as List<Course>);

    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _openCadPage(courses[index]);
          },
          child: WSlidable(
            child: ListTile(
              title: Text(courses[index].toString()),
            ),
            slideableActions: _createSlidablesActions(courses[index]),
          ),
        );
      },
    );
  }

  List<Widget> _createSlidablesActions(Course course) {
    return [
      SlidableAction(
        icon: Icons.edit,
        label: 'Editar',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: (context) {
          _openCadPage(course);
        },
      ),
      SlidableAction(
        icon: Utils.activeInactiveIcon(course.isActive == 1),
        label: Utils.activeInactiveLabel(course.isActive == 1),
        backgroundColor: Utils.activeInactiveColor(course.isActive == 1),
        foregroundColor: Colors.white,
        onPressed: (context) {
          _activateInactivate(course);
        },
      ),
    ];
  }
}

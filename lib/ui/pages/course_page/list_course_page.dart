import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _courseHelper.getAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              return _listViewBuilder(snapshot.data as List<Course>);
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
            builder: (context) => const CadCoursePage()
        )
    );
  }

  Widget _listViewBuilder(List<Course> courses) {
    return ListView.builder(
      padding: const EdgeInsets.all(4),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _slidable(courses[index]);
      },
    );
  }

  Widget _slidable(Course course) {
    return Slidable(
      child: ListTile(
        title: Text(course.description),
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

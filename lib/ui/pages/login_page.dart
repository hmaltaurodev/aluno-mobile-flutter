import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/w_elevated_button.dart';
import 'package:aluno_mobile_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    User.createDefaultUser();

    //SchedulerBinding.instance?.addPostFrameCallback((_) {
    //  Navigator.of(context).pushNamed("home_page");
    //});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 100,
                      bottom: 10
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        color: Theme.of(context).primaryColor,
                        size: 180,
                      ),
                      Text(
                        'Aluno Mobile',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                    left: 30,
                    right: 30
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.supervised_user_circle_outlined,
                    ),
                    labelText: 'Usuário',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 30,
                    right: 30
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              WElevatedButton(
                padding: const EdgeInsets.only(
                    top: 50,
                    left: 30,
                    right: 30
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: _login,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 30,
                ),
                child: Text(
                  'Acesse o README.md do projeto no GitHub para visualizar o login padrão!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    UserHelper userHelper = UserHelper();
    User? user = await userHelper.getByUsername('admin');
    /*await userHelper.getByLogin(
      _usernameController.text,
      _passwordController.text
    );*/

    //if (user != null) {
      //await (await SharedPreferences.getInstance()).setString('user_loged', user.username);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(user: user!)
          )
      );
    /*}
    else {
      const snackBar = SnackBar(
        content: Text('Usuário ou senha incorreta!')
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }*/
  }
}

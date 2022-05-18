import 'package:aluno_mobile_flutter/datasources/helpers/helpers.dart';
import 'package:aluno_mobile_flutter/models/models.dart';
import 'package:aluno_mobile_flutter/ui/components/components.dart';
import 'package:aluno_mobile_flutter/ui/pages/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showLoginPage = false;

  @override
  void initState() {
    super.initState();
    User.createDefaultUser();
    _validateUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Visibility(
          visible: _showLoginPage,
          child: SingleChildScrollView(
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
                WTextField(
                  textEditingController: _usernameController,
                  labelText: 'Usuário',
                  paddingTop: 50,
                  prefixIcon: const Icon(
                    Icons.supervised_user_circle_outlined,
                  ),
                ),
                WTextField(
                  textEditingController: _passwordController,
                  labelText: 'Senha',
                  prefixIcon: const Icon(
                    Icons.password,
                  ),
                  obscureText: true,
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
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Text(
                    'Acesse o README.md do projeto no GitHub para visualizar o login padrão!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    FocusScope.of(context).unfocus();
    UserHelper userHelper = UserHelper();
    User? user = await userHelper.getByLogin(
      _usernameController.text,
      _passwordController.text
    );

    if (user != null) {
      await (await SharedPreferences.getInstance()).setString('user_logged_in', user.username);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(user: user)
          )
      );
    }
    else {
      const snackBar = SnackBar(
        content: Text('Usuário ou senha incorreta!')
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _validateUserLoggedIn() async {
    String? userLoggedIn = (await SharedPreferences.getInstance()).getString('user_logged_in');

    if (userLoggedIn == null) {
      setState(() {
        _showLoginPage = true;
      });
    }
    else {
      UserHelper userHelper = UserHelper();
      User? user = await userHelper.getByUsername(userLoggedIn);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(user: user!)
          )
      );
    }
  }
}

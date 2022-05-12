import 'package:aluno_mobile_flutter/ui/components/w_elevated_button.dart';
import 'package:aluno_mobile_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const Padding(
                padding: EdgeInsets.only(
                    top: 50,
                    bottom: 10,
                    left: 30,
                    right: 30
                ),
                child: TextField(
                  decoration: InputDecoration(
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
              const Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 30,
                    right: 30
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()
                      )
                  );
                },
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
}

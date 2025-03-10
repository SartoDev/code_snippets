import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;
import 'package:code_snippets/command/command.dart';
import 'package:code_snippets/command/command_view.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searchCommand = false;
  final _gitCommands = [
    Command(
      expandedValue: "Inicializa um repositório Git",
      headerValue: "git init",
    ),
    Command(
      expandedValue: "Clona um repositório remoto",
      headerValue: "git clone <url>",
    ),
    Command(
      expandedValue: "Adiciona todos os arquivos ao staging",
      headerValue: "git add .",
    ),
    Command(
      expandedValue:
          'Exibe o histórico de commits (Pressione Enter para pular a linha. Digite "q" para sair do log e voltar ao terminal)',
      headerValue: "git log",
    ),
    Command(
      expandedValue: "Mostra o status atual do repositório",
      headerValue: "git status",
    ),
    Command(
      expandedValue: "Salva as alterações no repositório local",
      headerValue: 'git commit -m "Mensagem"',
    ),
    Command(
      expandedValue: "Modifica a mensagem do último commit",
      headerValue: 'git commit --amend -m "Nova Mensagem"',
    ),
    Command(
      expandedValue: "Define o nome do usuário nos commits globalmente",
      headerValue: 'git config --global user.name "Seu Nome"',
    ),
    Command(
      expandedValue: "Define o email do usuário nos commits globalmente",
      headerValue: 'git config --global user.email "seuemail@example.com"',
    ),
  ];
  final _pythonCommands = [
    Command(
      expandedValue: "Instala os pacotes que estão no requirements.txt",
      headerValue: "pip install -r requirements.txt",
    ),
    Command(
      expandedValue: "Lista os pacotes instalados",
      headerValue: "pip freeze",
    ),
    Command(
      expandedValue: "Inicia o servidor de desenvolvimento Django",
      headerValue: "python manage.py runserver",
    ),
    Command(
      expandedValue: "Cria um super usuário",
      headerValue: "python manage.py createsuperuser",
    ),
    Command(
      expandedValue:
          "Cria arquivos de migração para refletir alterações nos modelos do Django para as entidades do banco de dados",
      headerValue: "python manage.py makemigrations",
    ),
    Command(
      expandedValue: "Aplica os arquivos de migração",
      headerValue: "python manage.py migrate",
    ),
    Command(
      expandedValue: "Cadastrar registros iniciais no banco de dados",
      headerValue: 'python manage.py loaddata "fixtures\\data.json"',
    ),
    Command(
      expandedValue: "Cria um novo ambiente virtual Python",
      headerValue: "python -m venv venv",
    ),
    Command(
      expandedValue: "Sai do ambiente virtual atual",
      headerValue: "deactivate",
    ),
    Command(
      expandedValue: "Ativa o ambiente virtual Python",
      headerValue: 'workon "nome_do_ambiente"',
    ),
  ];
  final _nodeCommands = [
    Command(
      expandedValue: "Executa um arquivo Javascript com Node.js",
      headerValue: 'node <arquivo.js>',
    ),
    Command(
      expandedValue: "Mostra a versão do Node.js",
      headerValue: 'node -v',
    ),
  ];
  final _npmCommands = [
    Command(
      expandedValue: "Inicializa um projeto node, criando um package.json",
      headerValue: 'npm init',
    ),
    Command(
      expandedValue: "Instala pacotes do package.json",
      headerValue: 'npm install',
    ),
    Command(
      expandedValue: "Instala um pacote no projeto",
      headerValue: 'npm install <pacote>',
    ),
    Command(
      expandedValue: "Instala um pacote globalmente",
      headerValue: 'npm install -g <pacote>',
    ),
    Command(
      expandedValue: "Atualiza os pacotes do projeto",
      headerValue: 'npm update',
    ),
    Command(
      expandedValue: "Remove um pacote",
      headerValue: 'npm uninstall <pacote>',
    ),
    Command(
      expandedValue: "Executa um script definido no package.json",
      headerValue: 'npm run <script>',
    ),
    Command(
      expandedValue: "Lista os pacotes instalados no projeto",
      headerValue: 'npm list',
    ),
  ];
  final _flutterCommands = [
    Command(
      expandedValue: "Verifica o ambiente de desenvolvimento e dependências",
      headerValue: 'flutter doctor',
    ),
    Command(
      expandedValue: "Cria um novo projeto Flutter",
      headerValue: 'flutter create <nome_do_projeto>',
    ),
    Command(
      expandedValue: "Baixa as dependências do projeto",
      headerValue: 'flutter pub get',
    ),
    Command(
      expandedValue: "Atualiza as dependências para a versão mais recente",
      headerValue: 'flutter pub upgrade',
    ),
    Command(
      expandedValue: "Executa o aplicativo em um dispositivo/emulador conectado",
      headerValue: 'flutter run',
    ),
    Command(
      expandedValue: "Executa testes automatizados do projeto",
      headerValue: 'flutter test',
    ),
    Command(
      expandedValue: "Remove arquivos temporários e recompila o projeto",
      headerValue: 'flutter clean',
    ),
    Command(
      expandedValue: "Adiciona um pacote ao projeto",
      headerValue: 'flutter pub add <pacote>',
    ),
    Command(
      expandedValue: "Remove um pacote do projeto",
      headerValue: 'flutter pub remove <pacote>',
    ),
    Command(
      expandedValue: "Gera um APK para Android",
      headerValue: 'flutter build apk',
    ),
    Command(
      expandedValue: "Gera um App Bundle para Android",
      headerValue: 'flutter build appbundle',
    ),
    Command(
      expandedValue: "Compila o app para iOS",
      headerValue: 'flutter build ios',
    ),
    Command(
      expandedValue: "Gera a versão para web",
      headerValue: 'flutter build web',
    ),
    Command(
      expandedValue: "Gera a versão para windows",
      headerValue: 'flutter build windows',
    ),
    Command(
      expandedValue: "Lista dispositivos/emuladores disponíveis",
      headerValue: 'flutter devices',
    ),
    Command(
      expandedValue: "Lista os emuladores disponíveis",
      headerValue: 'flutter emulators',
    ),
  ];
  List<Command> _searchedCommands = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return shadcn.Scaffold(
          headers: [
            Center(
              child: SizedBox(
                width: kIsWeb ? 600 : constraints.maxWidth,
                child: shadcn.AppBar(
                  title:
                      searchCommand
                          ? shadcn.TextField(
                            placeholder: Text("Procure por um comando..."),
                            onChanged: (value) {
                              final allCommands = [
                                ..._gitCommands,
                                ..._npmCommands,
                                ..._nodeCommands,
                                ..._pythonCommands,
                                ..._flutterCommands,
                              ];
                              setState(() {
                                _searchedCommands =
                                    allCommands
                                        .where(
                                          (element) => element.headerValue
                                              .contains(value),
                                        )
                                        .toList();
                              });
                            },
                          )
                          : Text("Principais comandos"),
                  trailing: [
                    shadcn.IconButton(
                      onPressed:
                          () => setState(() {
                            final allCommands = [
                              ..._gitCommands,
                              ..._npmCommands,
                              ..._nodeCommands,
                              ..._pythonCommands,
                              ..._flutterCommands,
                            ];
                            searchCommand = !searchCommand;
                            _searchedCommands = allCommands;
                          }),
                      icon: Icon(searchCommand ? Icons.close : Icons.search),
                      variance: shadcn.ButtonVariance.outline,
                    ),
                    if (!kIsWeb)
                      shadcn.IconButton(
                        onPressed: () async {
                          final isDocked = await windowManager.isDocked();
                          if (isDocked != null) {
                            await windowManager.setSize(Size(500, 900));
                            await windowManager.setTitleBarStyle(
                              TitleBarStyle.normal,
                            );
                            await windowManager.setResizable(true);
                            await windowManager.undock();
                            await windowManager.center();
                          } else {
                            await windowManager.setTitleBarStyle(
                              TitleBarStyle.hidden,
                            );
                            await windowManager.setResizable(false);
                            await windowManager.dock(
                              side: DockSide.right,
                              width: 400,
                            );
                          }
                        },
                        icon: Icon(Icons.dock),
                        variance: shadcn.ButtonVariance.outline,
                      ),
                  ],
                ),
              ),
            ),
          ],
          child: Center(
            child: SizedBox(
              width: kIsWeb ? 600 : constraints.maxWidth,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.05,
                  vertical: constraints.maxHeight * 0.02,
                ),
                children:
                    searchCommand
                        ? [
                          Text("Comandos encontrados"),
                          SizedBox(height: 10),
                          _searchedCommands.isEmpty
                              ? Center(child: Text("Nenhum comando encontrado"))
                              : ListView.separated(
                                shrinkWrap: true,
                                itemCount: _searchedCommands.length,
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 20),
                                itemBuilder: (context, index) {
                                  final command = _searchedCommands[index];

                                  return CommandView(command);
                                },
                              ),
                        ]
                        : [
                          Text("Comandos git"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _gitCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _gitCommands[index];

                              return CommandView(command);
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Comandos npm"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _npmCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _npmCommands[index];

                              return CommandView(command);
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Comandos node"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _nodeCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _nodeCommands[index];

                              return CommandView(command);
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Comandos Python"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _pythonCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _pythonCommands[index];

                              return CommandView(command);
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Comandos Flutter"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _flutterCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _flutterCommands[index];

                              return CommandView(command);
                            },
                          ),
                        ],
              ),
            ),
          ),
        );
      },
    );
  }
}

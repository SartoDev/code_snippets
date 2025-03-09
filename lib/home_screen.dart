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
  final _oracleCommands = [
    Command(
      expandedValue: "Estabelece uma conexão com servidor remoto da Oracle",
      headerValue:
          'ssh -i "C:\\Users\\Administrador\\Downloads\\oracle_server\\ssh-key-2024-12-04.key" ubuntu@168.75.94.9',
    ),
  ];
  final _gitCommands = [
    Command(
      expandedValue: "Inicializa um repositório Git.",
      headerValue: "git init",
    ),
    Command(
      expandedValue: "Clona um repositório remoto.",
      headerValue: "git clone <url>",
    ),
    Command(
      expandedValue: "Adiciona todos os arquivos ao staging.",
      headerValue: "git add .",
    ),
    Command(
      expandedValue:
          'Exibe o histórico de commits (Pressione Enter para pular a linha. Digite "q" para sair do log e voltar ao terminal).',
      headerValue: "git log",
    ),
    Command(
      expandedValue: "Mostra o status atual do repositório.",
      headerValue: "git status",
    ),
    Command(
      expandedValue: "Salva as alterações no repositório local.",
      headerValue: 'git commit -m "Mensagem"',
    ),
    Command(
      expandedValue: "Modifica a mensagem do último commit.",
      headerValue: 'git commit --amend -m "Nova Mensagem"',
    ),
    Command(
      expandedValue: "Define o nome do usuário nos commits globalmente.",
      headerValue: 'git config --global user.name "Seu Nome"',
    ),
    Command(
      expandedValue: "Define o email do usuário nos commits globalmente.",
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
      expandedValue: "Inicia o servidor de desenvolvimento Django.",
      headerValue: "python manage.py runserver",
    ),
    Command(
      expandedValue: "Cria um super usuário.",
      headerValue: "python manage.py createsuperuser",
    ),
    Command(
      expandedValue:
          "Cria arquivos de migração para refletir alterações nos modelos do Django para as entidades do banco de dados.",
      headerValue: "python manage.py makemigrations",
    ),
    Command(
      expandedValue: "Aplica os arquivos de migração.",
      headerValue: "python manage.py migrate",
    ),
    Command(
      expandedValue: "Cadastrar registros iniciais no banco de dados.",
      headerValue: 'python manage.py loaddata "fixtures\\data.json"',
    ),
    Command(
      expandedValue: "Cria um novo ambiente virtual Python.",
      headerValue: "python -m venv venv",
    ),
    Command(
      expandedValue: "Sai do ambiente virtual atual.",
      headerValue: "deactivate",
    ),
    Command(
      expandedValue: "Ativa o ambiente virtual Python.",
      headerValue: 'workon "nome_do_ambiente"',
    ),
  ];
  final _chromeCommands = [
    Command(
      expandedValue: "Rodar Chrome sem Cors",
      headerValue:
          '"C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe" --disable-web-security --user-data-dir="C:\chrome_dev"',
    ),
  ];
  final _nodeCommands = [
    Command(
      expandedValue: "Instala pacotes do package.json",
      headerValue: 'npm install',
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
                                ..._oracleCommands,
                                ..._gitCommands,
                                ..._nodeCommands,
                                ..._pythonCommands,
                                ..._chromeCommands,
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
                              ..._oracleCommands,
                              ..._gitCommands,
                              ..._nodeCommands,
                              ..._pythonCommands,
                              ..._chromeCommands,
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
                          Text("Comandos conexão Oracle"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _oracleCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _oracleCommands[index];

                              return CommandView(command);
                            },
                          ),
                          SizedBox(height: 20),
                          Text("Comandos Chrome"),
                          SizedBox(height: 10),
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _chromeCommands.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              final command = _chromeCommands[index];

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

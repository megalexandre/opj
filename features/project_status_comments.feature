# language: pt

Funcionalidade: Comentários em Status de Projetos
  Como um usuário autenticado
  Quero comentar nos status de um projeto
  Para registrar observações e atualizações no histórico

  Contexto:
    Dado que estou autenticado como usuário
    E que existe um projeto com um status cadastrado

  Cenário: Adicionar um comentário ao status
    Quando faço POST em "/projects/<project_id>/statuses/<status_id>/comments" com os dados:
      | body | Aguardando documentação do cliente |
    Então o status da resposta é 201
    E a resposta contém "body" com valor "Aguardando documentação do cliente"
    E o status tem 1 comentário

  Cenário: Adicionar comentário com body em branco retorna erro
    Quando faço POST em "/projects/<project_id>/statuses/<status_id>/comments" com os dados:
      | body |  |
    Então o status da resposta é 422

  Cenário: Atualizar um comentário existente
    Dado que existe um comentário cadastrado
    Quando faço PATCH em "/projects/<project_id>/statuses/<status_id>/comments/<comment_id>" com os dados:
      | body | Documentação recebida e aprovada |
    Então o status da resposta é 200
    E a resposta contém "body" com valor "Documentação recebida e aprovada"

  Cenário: Remover um comentário
    Dado que existe um comentário cadastrado
    Quando faço DELETE em "/projects/<project_id>/statuses/<status_id>/comments/<comment_id>"
    Então o status da resposta é 204
    E o comentário não existe mais no banco

  Cenário: Comentário em status inexistente retorna 404
    Quando faço POST em "/projects/<project_id>/statuses/00000000-0000-0000-0000-000000000000/comments" com os dados:
      | body | Comentário |
    Então o status da resposta é 404

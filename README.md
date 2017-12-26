# Gerenciamento de curso

Esse projeto contém uma api que disponibiliza acesso as seguintes entidades: **Teacher**, **Student** e **Course**. A relação entre Teacher/Student e Course é gerenciada através da entidade **CourseRelation**.

A relação entre as entidades está configurada desta forma:
* **Teacher** tem muitos **Course** s e o inverso também acontece.

* **Student** participa de vários **Course** s e **Course** pode ter vários **Student**.

Essa api é *versionada* (apenas uma versão presente) e segue o padrão  [json:api](http://http://jsonapi.org/). Sua documentação é criada com uso de swagger. Pode ser acessada no caminho: `/documentation`

## Configurações do projeto

* Ruby version: `2.3.3`
* Dependencies: `Redis`, `postgresql`

## Como rodar

* Prepare o banco de dados:
`bundle exec rake db:drop db:create db:migrate db:seed`

* Gere a documentação a ser usada por swagger-ui: `bundle exec rake swagger:docs`

* Rode o servidor de sidekiq: `bundle exec sidekiq`

* Rode o servidor normalmente: `bundle exec rails s`

* O acesso aos endpoints são feitos de maneira *não autenticada* e requer a adição dos seguintes cabeçalhos:

  * `'Accept'` => `'application/vnd.course-management.v1'`
  * `Content-Type` => `application/vnd.api+json`

## Como rodar a suíte de testes?
Este projeto projeto usa `Rspec`, `Shoulda Matches`, `FactoryBot` e `Simple Coverage` em sua suíte de testes.
Para rodar essa suíte utilize o seguinte comando: `COVERAGE=on rspec`

## TODOs
* Incluir mecanismos de buscas usando `ElasticSearch`

* Implementar configuração de `docker` e de `docker-compose`

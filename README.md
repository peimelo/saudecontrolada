# Saúde Controlada

<table>
  <tr>
    <td>Build Status</td>
    <td>
      <a href="https://travis-ci.org/peimelo/saudecontrolada_api"><img src="https://travis-ci.org/peimelo/saudecontrolada_api.svg?branch=master" alt="Build Status" ></a>
    </td>
  </tr>
  <tr>
    <td>Code Quality</td>
    <td>
      <a href="https://codeclimate.com/github/peimelo/saudecontrolada_api"><img src="https://codeclimate.com/github/peimelo/saudecontrolada_api/badges/gpa.svg" /></a>
      <a href="https://codebeat.co/projects/github-com-peimelo-saudecontrolada_api"><img alt="codebeat badge" src="https://codebeat.co/badges/8fb95a53-e610-4828-82cd-70475686ea38" /></a>
      <a href="https://codeclimate.com/github/peimelo/saudecontrolada_api/coverage"><img src="https://codeclimate.com/github/peimelo/saudecontrolada_api/badges/coverage.svg" /></a>
    </td>
  </tr>
  <tr>
    <td>Security</td>
    <td>
      <a href="https://hakiri.io/github/peimelo/saudecontrolada_api/master"><img src="https://hakiri.io/github/peimelo/saudecontrolada_api/master.svg" /></a>
      <a href="http://rails-brakeman.com/peimelo/saudecontrolada_api"><img src="http://rails-brakeman.com/peimelo/saudecontrolada_api.png" /></a>
      <a href="https://gemnasium.com/peimelo/saudecontrolada_api"><img src="https://gemnasium.com/peimelo/saudecontrolada_api.svg" /></a>
    </td>
  </tr>
</table>

##### Documentação e Backlog
[![Inline docs](http://inch-ci.org/github/peimelo/saudecontrolada_api.svg?branch=master)](http://inch-ci.org/github/peimelo/saudecontrolada_api)
[![Stories in Ready](https://badge.waffle.io/peimelo/saudecontrolada_api.svg?label=ready&title=Ready)](http://waffle.io/peimelo/saudecontrolada_api)

Saúde Controlada é uma iniciativa para que as pessoas possam gerenciar
sua saúde de forma a torná-la cada vez melhor.

Esse projeto contempla 2 repositórios:

- Backend em Ruby on Rails versão 5.x.x;
- Frontend em AngularJs versão 1.x.x.

## Backend

- Ruby on Rails servindo como api
- Banco de dados Postgres

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

bundle exec guard -p

bundle exec tmp/rails_best_practices -f html --output-file tmp/rails_best_practices.html

rubocop --format html -o tmp/rubocop.html

brakeman -o tmp/brakeman.html

annotate

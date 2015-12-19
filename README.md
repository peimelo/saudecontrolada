# Saúde Controlada

[![Code Climate](https://codeclimate.com/github/peimelo/saudecontrolada/badges/gpa.svg)](https://codeclimate.com/github/peimelo/saudecontrolada)
[![Test Coverage](https://codeclimate.com/github/peimelo/saudecontrolada/badges/coverage.svg)](https://codeclimate.com/github/peimelo/saudecontrolada/coverage)
[![Build Status](https://travis-ci.org/peimelo/saudecontrolada.svg?branch=master)](https://travis-ci.org/peimelo/saudecontrolada)
[![Dependency Status](https://gemnasium.com/peimelo/saudecontrolada.svg)](https://gemnasium.com/peimelo/saudecontrolada)
[![security](https://hakiri.io/github/peimelo/saudecontrolada/master.svg)](https://hakiri.io/github/peimelo/saudecontrolada/master)
[![Build Status](http://rails-brakeman.com/peimelo/saudecontrolada.png)](http://rails-brakeman.com/peimelo/saudecontrolada)
[![Inline docs](http://inch-ci.org/github/peimelo/saudecontrolada.svg?branch=master)](http://inch-ci.org/github/peimelo/saudecontrolada)
[![Stories in Ready](https://badge.waffle.io/peimelo/saudecontrolada.svg?label=ready&title=Ready)](http://waffle.io/peimelo/saudecontrolada)

## Descrição

[Site online do sistema Saúde Controlada!](https://saudecontrolada.com.br)

## Configuração

    CREATE ROLE saudecontrolada LOGIN ENCRYPTED PASSWORD 'saudecontrolada' NOINHERIT VALID UNTIL 'infinity';

    CREATE DATABASE saudecontrolada_development WITH ENCODING='UTF8' OWNER=saudecontrolada;
    CREATE DATABASE saudecontrolada_test WITH ENCODING='UTF8' OWNER=saudecontrolada;

    rake db:migrate RAILS_ENV=development
    rake db:migrate RAILS_ENV=test
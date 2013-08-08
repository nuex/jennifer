jennifer
========

## Overview

Jennifer is a project scaffold generator. It uses common tools like sh and awk to quickly generate boilerplate code, configuration files or a directory structure.

## Install

To install:

    git clone git://github.com/nuex/jennifer.git
    cd jennifer
    make
    sudo make install

Edit `config.mk` before running `make` if you want to customize the binary install directory (defaults to `/usr/local/bin`) and the awk library install directory (defaults to `/usr/local/lib/jennifer`).

Add the binary install directory to your path (unless it is already in your path):

    echo "export PATH=$PATH:/usr/local/bin" >> ~/.bash_profile    # (bash example)

## Usage

A jennifer template is simply a directory of files and directories that make up your project scaffold. A template could look like this:

    some_directory/
      Jenfile
      my.code
      another.code

Templates are installed using the _jen add_ command:

    jen add some_directory

You can list installed templates:

    jen list

Or delete them:
  
    jen delete mytemplate

You generate a project from a stored template with _jen new_:

    jen new mytemplate

You can also pass custom data to be bound to the template:

    jen new mytemplate -v author="Trevor Goodchild" -v city="Bregna"

If you need to see what variables are available to bind data to, use the `vars` command:

    jen vars mytemplate

The Jenfile is a text file with a list of instructions:

    ;
    ; Jennifer template for an Erlang OTP Application
    ;

    name erlang-app
    description A template for generating an Erlang OTP Application

    var appid myapp
    var description
    template erlang-app/rebar.config rebar.config
    dir apps/{{appid}}/src
    template erlang-app/app.app.src apps/{{appid}}/src/{{appid}}.app.src
    template erlang-app/app_app.erl apps/{{appid}}/src/{{appid}}.erl
    template erlang-app/app_sup.erl apps/{{appid}}/src/{{appid}}_sup.erl

Jennifer templates use mustache notation for tags. Tags get replaced with data either from the second argument in the template's _var_ command or by values you assign when you run the _jen new_ command.

### Template Commands

* name - _name_ is the name of the template and is required.
* description - _description_ is also required.
* var - _var_ is used to either set default variable data or reference any variables used in the template.
* dir - _dir_ creates a directory
* template - _template_ has two arguments. The first argument is the source template, the second is the destination location.
* cp - _cp_ also has two arguments. The first argument is the source file, the second is the destination location.

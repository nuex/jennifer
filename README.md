jennifer
========

## USAGE

Jennifer is used to quickly build and store project templates. A jennifer template looks like this:

    some_directory/
      template.jen
      my.code
      another.code

Templates are installed using the _jen add_ command:

    jen add some_directory

You can list installed templates:

    jen list

Or delete them:
  
    jen delete mytemplate

You generate templates with _jen new_:

    jen new mytemplate

You can also pass custom data to be bound to the template:

    jen new mytemplate -v author="Trevor Goodchild" -v city="Bregna"

If you need to see what variables are available, use the `vars` command:

    jen vars mytemplate

The template.jen file is a text file with a list of instructions:

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

## INSTALLATION

Installing jennifer includes cloning the git repository, running make and exporting the jennifer lib directory:

    git clone git://github.com/nuex/jennifer.git
    cd jennifer
    sudo make install
    export JEN_LIBDIR="/usr/local/jennifer/lib"

You can edit config.mk to change the install path. You'll need to update the JEN_LIBDIR path as well, of course.

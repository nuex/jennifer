-module({{appid}}).
-behaviour(application).

%% Interface

-export([start/0]).

%% Application interface

-export([start/2, stop/1]).

%% Implementation

start() ->
    application:start(?MODULE).

%% Application implementation

%% @private
start(_StartType, _StartArgs) ->
    {{appid}}_sup:start_link().

%% @private
stop(_State) ->
    ok.

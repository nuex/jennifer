%% @private
-module({{appid}}_sup).
-behaviour(supervisor).

%% Interface

-export([start_link/0]).

%% Supervisor interface

-export([init/1]).

%% Implementation

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% Supervisor implementation

init([]) ->
    Restart = {one_for_one, 5, 10},
    {ok, {Restart, []}}.

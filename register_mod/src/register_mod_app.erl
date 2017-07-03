%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(register_mod_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
  register_mod_sup:start_link().


stop(_State) ->
  ok.

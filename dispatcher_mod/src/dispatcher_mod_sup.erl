%%%-------------------------------------------------------------------
%%% @author lsb
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 七月 2017 22:51
%%%-------------------------------------------------------------------
-module(dispatcher_mod_sup).

-behaviour(supervisor).

%% API.
-export([start_link/0]).

%% supervisor.
-export([init/1]).

%% API.

-spec start_link() -> {ok, pid()}.
start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% supervisor.

init([]) ->
  Procs = [],
  {ok, {{one_for_one, 10, 10}, Procs}}.


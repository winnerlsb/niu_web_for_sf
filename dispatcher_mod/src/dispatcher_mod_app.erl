%%%-------------------------------------------------------------------
%%% @author lsb
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 七月 2017 22:51
%%% 转发入口
%%%-------------------------------------------------------------------
-module(dispatcher_mod_app).

-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
  Dispatch = cowboy_router:compile([
    {'_', [
      {"/register", register_handler, []},
      {"/login", login_handler, []},
      {"/upload", upload_handler, []},
      {"/files/[...]", cowboy_static, {priv_dir, upload, "files"}}
    ]}
  ]),
  {ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
    {env, [{dispatch, Dispatch}]}
  ]),
  dispatcher_mod_sup:start_link().

stop(_State) ->
  ok.

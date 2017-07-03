%%%-------------------------------------------------------------------
%%% @author lsb
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 七月 2017 23:01
%%%-------------------------------------------------------------------
-module(login_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Transport, Req, []) ->
  {ok, Req, undefined}.

handle(Req, State) ->

  {ok, Req, State}.

terminate(_Reason, _Req, _State) ->
  ok.


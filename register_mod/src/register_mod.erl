%%%-------------------------------------------------------------------
%%% @author lsb
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. 七月 2017 22:17
%%%-------------------------------------------------------------------
-module(register_mod).


-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).


%% ====================================================================
%% API functions
%% ====================================================================
-export([
  start_link/0,
  pre_check_account_exist/1
]).

%% ====================================================================
-record(state, {}).

start_link() ->
  gen_server:start_link(?MODULE, [], []).


init([]) ->
  process_flag(trap_exit, true),
  %% 玩家账号表存储内存和disc中
  State = #state{},
  {ok, State}.


%% ====================================================================
handle_call(Request, From, State) ->
  try
    do_call(Request, From, State)
  catch
    Error:Reason ->
      slogger:warning_msg("mod call Error! info = ~p~n, stack = ~p~n", [{Error, Reason, Request}, erlang:get_stacktrace()]),
      {reply, ok, State}
  end.


%% ====================================================================
handle_cast(Msg, State) ->
  try
    do_cast(Msg, State)
  catch
    Error:Reason ->
      slogger:warning_msg("mod cast Error! info = ~p~n, stack = ~p~n", [{Error, Reason, Msg}, erlang:get_stacktrace()]),
      {noreply, State}
  end.

handle_info(Info, State) ->
  try
    do_info(Info, State)
  catch
    Error:Reason ->
      slogger:warning_msg("mod cast Error! info = ~p~n, stack = ~p~n", [{Error, Reason, Info}, erlang:get_stacktrace()]),
      {noreply, State}
  end.



%% ====================================================================
terminate(_Reason, _State) ->
  slogger:warning_msg("~p terminated ~n", [?MODULE]),
  ok.


%% ====================================================================
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

do_call({'create_account', Account, Psw, Option}, _From, State) ->
  %% 验证account重复否
  case pre_check_account_exist(Account) of
    true ->
      Reply = {false, 1};
    _ ->
      NewAccountData = create_account_record(Account, Psw, Option),
      DBFun = fun() -> account_db:t_write(NewAccountData) end,
      case dal:run_transaction_rpc(DBFun) of
        {atomic, _} ->
          Reply = {true, calc_login_code(NewAccountData)};
        _ ->
          Reply = {false, 2}
      end
  end,
  {reply, Reply, State};

do_call(Request, From, State) ->
  slogger:warning_msg("mod call bad match! info = ~p~n", [{?MODULE, Request, From}]),
  {reply, ok, State}.

do_cast(Msg, State) ->
  slogger:warning_msg("mod cast bad match! info = ~p~n", [{?MODULE, Msg}]),
  {noreply, State}.


do_info(Info, State) ->
  slogger:warning_msg("mod info bad match! info = ~p~n", [{?MODULE, Info}]),
  {noreply, State}.

%% 生成账号数据
create_account_record(Account, Psw, Option) ->
  ok.

%% 计算登入验证串
calc_login_code(NewAccountData) ->

  ok.

pre_check_account_exist(Account) ->
  case account_db:get(Account) of
    {ok, [_AccountInfo]} ->
      true;
    _ ->
      false
  end.

-module(udp_listener).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%% ------------------------------------------------------------------
%% API Function Exports
%% ------------------------------------------------------------------

-export([start_link/0]).

%% ------------------------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-record(state, { socket }).

%% ------------------------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------------------------

start_link() ->
	io:format("udp listener start_link~n"),
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% ------------------------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------------------------

init([]) ->
	{ok, Socket} = gen_udp:open(8888, []),
    {ok, #state{ socket = Socket }}.

handle_call(_Request, _From, State) ->
	io:format("udp listener handle_call~n"),
    {reply, ok, State}.

handle_cast(_Msg, State) ->
	io:format("udp listener handle_cast~n"),
    {noreply, State}.

handle_info(UdpMsg, State) ->
	io:format("udp listener handle_info special~n"),
	udp_main_sup:handle(UdpMsg),
	{noreply, State}.

terminate(_Reason, _State) ->
	io:format("udp listener terminate~n"),
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------


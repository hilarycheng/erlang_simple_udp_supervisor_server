-module(udp_main_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, handle/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, temporary, 5000, Type, [I]}).
-define(SERVER, ?MODULE).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

handle(UdpMsg) ->
	supervisor:start_child(?SERVER, [UdpMsg]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
	io:format("udp_main_sup ~n"),
    {ok, { {simple_one_for_one, 5, 10}, [?CHILD(udp_handle_server, worker)]} }.


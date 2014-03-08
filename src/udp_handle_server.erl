-module(udp_handle_server).

-export([start_link/1]).

-export([init/1]).

start_link(Packet) ->
	io:format("udp_handle_server start_link ~n"),
	proc_lib:start_link(?MODULE, init, [[self(), Packet]]).

init([Parent, Packet]) ->
	io:format("udp_handle_server init ~n"),
	proc_lib:init_ack(Parent, {ok, self()}),
	answer_query(Packet),
	exit(normal).

answer_query({udp, Socket, IP, Port, ReqBin}) ->
	io:format("answer query ~n"),
	ok.

Simple Erlang UDP Server, Follow the Erlang DNS Server from https://github.com/hcvst/erlang-dns.

Just copy the rebar to local directory, run

rebar compile

then

erl -pa ebin -boot start_sasl

At the Erlang Shell,

application:start(udp).

Then use netcat

cat /tmp/test.txt | nc -vu 127.0.0.1 8888



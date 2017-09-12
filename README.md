MQTT Review Application
=======================

Here is example of working N2O Review Application on top of MQTT EMQ broker.

Motivation
----------

Prepare N2O protocol federation to commercial use on top of MQTT protocol.
Minimize and remove all features, duplicated by MQTT pubsub broker.
Provide EMQ extension that immediately introduce N2O protocol and
application to connected MQTT devices. Create single Erlang eco-system
for Enterprise Protocol Federation and establish
solid CORBA-, WS-, XMPP-replacement, ready for high-speed,
low-latency IoT applications.

Run
---

```sh
$ brew install erlang
$ curl -fsSL https://raw.github.com/synrc/mad/master/mad > mad \
            && chmod +x mad \
            && sudo cp mad /usr/local/bin
$ git clone git://github.com/voxoz/mq && cd mq
$ time mad dep com
Writing /apps/review/ebin/review.app
OK

real    1m45.357s
user    0m17.166s
sys     0m5.065s
$ mad rep
Configuration: [{n2o,
                    [{port,8000},
                     {app,review},
                     {pickler,n2o_secret},
                     {formatter,bert},
                     {log_modules,config},
                     {log_level,config}]},
                {emq_dashboard,
                    [{listeners_dash,
                         [{http,18083,[{acceptors,4},{max_clients,512}]}]}]},
                {emqttd,
                    [{listeners,
                         [{http,8083,[{acceptors,4},{max_clients,512}]},
                          {tcp,1883,[{acceptors,4},{max_clients,512}]}]},
                     {sysmon,
                         [{long_gc,false},
                          {long_schedule,240},
                          {large_heap,8000000},
                          {busy_port,false},
                          {busy_dist_port,true}]},
                     {session,
                         [{upgrade_qos,off},
                          {max_inflight,32},
                          {retry_interval,20},
                          {max_awaiting_rel,100},
                          {await_rel_timeout,20},
                          {enable_stats,off}]},
                     {queue,[]},
                     {allow_anonymous,true},
                     {protocol,
                         [{max_clientid_len,1024},{max_packet_size,64000}]},
                     {acl_file,"etc/acl.conf"},
                     {plugins_etc_dir,"etc/plugins/"},
                     {plugins_loaded_file,"etc/loaded_plugins"},
                     {pubsub,
                         [{pool_size,8},{by_clientid,true},{async,true}]}]},
                {kvs,
                    [{dba,store_mnesia},
                     {schema,[kvs_user,kvs_acl,kvs_feed,kvs_subscription]}]}]
Applications:  [kernel,stdlib,gproc,lager_syslog,pbkdf2,asn1,fs,ranch,mnesia,
                compiler,inets,crypto,syntax_tools,xmerl,gen_logger,esockd,
                cowlib,goldrush,public_key,lager,ssl,cowboy,mochiweb,emqttd,
                erlydtl,kvs,mad,emqttc,nitro,rest,sh,syslog,review]
Erlang/OTP 19 [erts-8.3] [source] [64-bit] [smp:4:4]
              [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Eshell V8.3  (abort with ^G)
starting emqttd on node 'nonode@nohost'
Nonexistent: []
Plugins: [{mqtt_plugin,emq_auth_username,"2.1.1",
                       "Authentication with Username/Password",false},
          {mqtt_plugin,emq_dashboard,"2.1.1","EMQ Web Dashboard",false},
          {mqtt_plugin,emq_modules,"2.1.1","EMQ Modules",false},
          {mqtt_plugin,n2o,"4.5-mqtt","N2O Server",false}]
Names: [emq_dashboard,n2o]
dashboard:http listen on 0.0.0.0:18083 with 4 acceptors.
Async Start Attempt {handler,"timer",n2o,system,n2o,[],[]}
Proc Init: init
mqtt:ws listen on 0.0.0.0:8083 with 4 acceptors.
mqtt:tcp listen on 0.0.0.0:1883 with 4 acceptors.
emqttd 2.1.1 is running now
>
```
After server is running you should enable `N2O over MQTT bridge` EMQ plugin
on plugin page http://127.0.0.1:18083/#/plugins and then open application
sample http://127.0.0.1:8000/spa/login.htm

PING, SESSION, AUTH and MQ layers of N2O
----------------------------------------

`N2O_start` and `n2o.js` is no longer used in MQTT version of N2O.
Instead `N2O_start` one should use `MQTT_start` and `mqtt.js` for session control replacement.
We traded `HEART` protocol and session facilities for bult-in MQTT features.
N2O authentication and authorization mechanism is also abandoned as MQTT
could provide AUTH features too. Obviously `wf:reg` and `wf:send` API
is also abandoned as we can use `emqttd` API directly and `{deliver,_}` protocol of
`ws_client` gen_server. 

What is added to N2O?
---------------------

The one bad thing about MQTT version is that we need to store now
both MQTT and BERT formatters on client.

```
<script src="//127.0.0.1:18083/assets/js/mqttws31.js"></script>
<script src="/spa/mq.js"></script>
```

Also IBM version of MQTT JavaScript library is far beyond the
speed and byte magic of `bert.js` library provided by N2O.
We packed BERT encoding inside MSS/MTU and so we see
WS31 replacement as desired.

Which layers are removed from MQTT version of N2O?
--------------------------------------------------

This is a good part.

* n2o_session — no Browser, so no Cookies are needed
* n2o_stream — no XHR fallback needed
* n2o_heart — no PING protocol needed
* n2o_mq — `syn` and `gproc` are no longer neede
* n2o_query — no Query Router 
* N2O.js — no pinger
* ranch — `esockd` instead
* cowboy — `mochiweb` for WebSockets inside EMQ

NOTE: WebSockets are not the most capacitive transport, the
MQTT-SN extension is able to work on UDP streams.
MQTT can work only over TCP for raw speed.

Key Things N2O is relying on
----------------------------

N2O is working entirely in context of `ws_client` processes of EMQ, just
as it is working on top of `ranch` processes of `cowboy`.
No additional `gen_server` is being introduced.

The only official transparent way with zero abstractions is to use EMQ hooks
mechanism. For N2O we need to implement only two cases `client.subscribe` and
`message.delivered`. On client subscribe we deliver all persistent information
that are ready for the client. On Message delivered we to unpacking any N2O
BERT protocol message inside MQTT session.

The single point of entrance is the `event(init)` message handler.
It can only be reached by calling `n2o_nitrogen` with `{init,<<>>}` protocol message.
However N2O MQTT is a protocol federation so we need to handle not only N2O messages,
but also KVS, ROSTER, BPE, REST protocols.
Thus after initialization during `client.subscribe`  we call `n2o_proto:info` — 
the entire N2O protocol chain recursor inside `message.delivered` hook. 
This is a best place to put the federation relay for N2O modules.

Credits
-------
* Brought to you by 5HT and M2K


use Mix.Config

config :kvs,
  dba: :kvs_mnesia,
  dba_st: :kvs_stream, 
  schema: [:kvs, :kvs_stream]

config :n2o,
  app: :review,
  port: 8000,
  mq: :n2o_syn,
  pickler: :n2o_secret,
  tables: [:cookies, :mqtt, :async, :caching, :file],
  upload: "./priv/static",
  protocols: [:n2o_heart],
  mqtt_host: {127,0,0,1},
  mqtt_tcp_port: 1883,
  mqtt_services: [
    {:index, [
      {:owner, 34239034},
      {:protocols, [:n2o_ftp, :nitro_n2o]},
      {:qos, 2}
    ]},
    {:login, [
      {:owner, 34239034},
      {:protocols, [:nitro_n2o]}
    ]},
    {:sed, [
      {:owner, 34239034},
      {:protocols, [:n2o_sed]}
    ]}
  ],
  ws_services: [],
  tcp_services: []

config :emqx,
  mgmt_port: 8081,
  default_user_passwd: "public",
  default_user_username: "admin",
  max_row_limit: 10000,
  default_application_id: [],
  default_application_secret: [],
  allow_anonymous: true,
  acl_file: 'etc/acl.conf',
  max_clientid_len: 65535,
  max_packet_size: 1_048_576,
  max_qos_allowed: 2,
  expand_plugins_dir: 'plugins/',
  plugins_etc_dir: 'etc/plugins/',
  zones: [
    {:internal,
     [
       {:use_username_as_clientid, false},
       {:upgrade_qos, false},
       {:session_expiry_interval, 7200},
       {:retry_interval, 20000},
       {:mqueue_store_qos0, true},
       :none,
       {:mqueue_default_priority, :highest},
       {:max_subscriptions, 0},
       {:max_mqueue_len, 1000},
       {:max_inflight, 32},
       {:max_awaiting_rel, 100},
       {:keepalive_backoff, 0.75},
       {:idle_timeout, 15000},
       {:force_shutdown_policy,
        %{:max_heap_size => 0, :message_queue_len => 0}},
       {:force_gc_policy, %{:bytes => 1_048_576, :count => 1000}},
       {:enable_stats, true},
       {:enable_ban, true},
       {:enable_acl, false},
       {:await_rel_timeout, 300_000},
       {:allow_anonymous, true},
       {:acl_deny_action, :ignore}
     ]},
    {:external,
     [
       {:use_username_as_clientid, false},
       {:upgrade_qos, false},
       {:session_expiry_interval, 7200},
       {:retry_interval, 20000},
       {:mqueue_store_qos0, true},
       :none,
       {:mqueue_default_priority, :lowest},
       {:max_subscriptions, 0},
       {:max_mqueue_len, 1000},
       {:max_inflight, 32},
       {:max_awaiting_rel, 100},
       {:keepalive_backoff, 0.75},
       {:idle_timeout, 15000},
       {:force_shutdown_policy,
        %{:max_heap_size => 0, :message_queue_len => 0}},
       {:force_gc_policy, %{:bytes => 0, :count => 0}},
       {:enable_stats, true},
       {:enable_ban, false},
       {:enable_acl, false},
       {:await_rel_timeout, 300_000},
       {:allow_anonymous, true},
       {:acl_deny_action, :ignore}
     ]}
  ],
  listeners: [
    {:tcp, {'127.0.0.1',11883},
      [{:tcp_options,[{:backlog,512},{:send_timeout,5000},{:send_timeout_close,true},{:nodelay,false},{:reuseaddr,true}]},
       {:acceptors,4},
       {:max_connections,1024000},
       {:max_conn_rate,1000},
       {:active_n,1000},
       {:zone,:internal}]},
    {:tcp, {'0.0.0.0',1883},
      [{:tcp_options, [{:backlog,1024},{:send_timeout,15000},{:send_timeout_close,true},{:nodelay,true},{:reuseaddr,true}]},
       {:acceptors,8},
       {:max_connections,1024000},
       {:max_conn_rate,1000},
       {:active_n,100},
       {:zone,:external},
       {:access_rules,[{:allow,:all}]}]},
    {:ws, 8083,
     [
       {:acceptors, 4},
       {:mqtt_path, "/mqtt"},
       {:max_connections, 102_400},
       {:max_conn_rate, 1000},
       {:zone, :external},
       {:verify_protocol_header, true},
       {:access_rules, [{:allow, :all}]},
       {:tcp_options,
        [
          {:backlog, 1024},
          {:send_timeout, 15000},
          {:send_timeout_close, true},
          {:nodelay, true}
        ]}
     ]}
  ]
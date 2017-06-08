var match, pl = /\+/g, search = /([^&=]+)=?([^&]*)/g,
    decode = function (s) { return decodeURIComponent(s.replace(pl, " ")); },
    query = window.location.search.substring(1),
    nodes = 4,
    params = {}; while (match = search.exec(query)) params[decode(match[1])] = decode(match[2]);
var l = location.pathname,
    x = l.substring(l.lastIndexOf("/") + 1),
    ll = x.lastIndexOf("."),
    module = x == "" ? "index" : (ll > 0 ? x.substring(0, ll) : x);
var clientId = undefined;
var ws = { send: function (payload, qos) {
        var message = new Paho.MQTT.Message(payload);
        message.destinationName = topic("events");
        message.qos = qos || 2;
        mqtt.send(message); } };

var subscribeOptions = {
    qos: 2,  // QoS
    invocationContext: { foo: true },  // Passed to success / failure callback
    onSuccess: function (x) { console.log("N2O Subscribed"); },
    onFailure: function (m) { console.log("N2O Subscription failed: " + m.errorMessage); },
    timeout: 2 };

var options = {
    timeout: 2,
    userName: module,
    password: "password",
    onFailure: function (m) { console.log("N2O Connection failed: " + m.errorMessage); },
    onSuccess: function ()  { console.log("N2O Connected");
                            } };
function token() { return localStorage.getItem("token")||''; };
function set_token(t) { return localStorage.setItem("token", t); };
function topic(prefix) { return prefix + "/" + rnd() + "/" + module + "/anon/" + clientId + "/" + token(); }
function rnd() { return Math.floor((Math.random() * nodes)+1); }
function arrayBufferToString(buffer){
    var arr = new Uint8Array(buffer);
    var str = String.fromCharCode.apply(String, arr);
    if(/[\u0080-\uffff]/.test(str)){
        throw new Error("this string seems to contain (still encoded) multibytes");
    }
    return str;
}

  mqtt = new Paho.MQTT.Client(host, 8083, '');
  mqtt.onConnectionLost = function (o) { console.log("connection lost: " + o.errorMessage); };
  mqtt.onMessageArrived = function (m) {
        if (undefined == clientId && m.payloadBytes.length == 0)
        {
            words = m.destinationName.split("/");
            clientId = words[2];
            console.log(clientId);
            ws.send(enc(tuple(atom('init'),bin(token()))));
        } else {
        var BERT = m.payloadBytes.buffer.slice(m.payloadBytes.byteOffset,
            m.payloadBytes.byteOffset + m.payloadBytes.length);
        try {
            erlang = dec(BERT);
            if (erlang.v && erlang.v[0].v == "io" &&
                erlang.v.length == 3 && typeof(erlang.v[2].v) == "object" &&
                erlang.v[2].v.length == 2 && erlang.v[2].v[0].v == "Token")
                {
                    binToken = erlang.v[2].v[1].v;
                    if (binToken.byteLength) {
                        t = arrayBufferToString(binToken);
                        set_token(t);
                        console.log("set token: " + t);
                }
            }

            erlang = dec(BERT);

            for (var i = 0; i < $bert.protos.length; i++) {
                p = $bert.protos[i];
                if (p.on(erlang, p.do).status == "ok")
                    return;

            }
        } catch (e) { console.log(e); }
        }
    };
    console.log(module);

  mqtt.connect(options);

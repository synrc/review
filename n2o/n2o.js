
// N2O CORE

var active = false,
    debug = false,
    session = "site-sid",
    protocol = window.location.protocol == 'https:' ? "wss://" : "ws://",
    querystring = window.location.pathname + window.location.search,
    host = window.location.hostname;

function qi(name) { return document.getElementById(name); }
function qs(name) { return document.querySelector(name); }
function qn(name) { return document.createElement(name); }
function is(x, num, name) { return x.t == 106 ? false : (x.v.length === num && x.v[0].v === name); }
function co(name) { match = document.cookie.match(new RegExp(name + '=([^;]+)')); return match ? match[1] : undefined; }

/// N2O Protocols

var $io = {}; $io.on = function onio(r, cb) {
    if (is(r, 3, 'io')) {
        if (r.v[2].v != undefined && r.v[2].v[1] != undefined){
          tok = String.fromCharCode.apply(null, new Uint8Array(r.v[2].v[1].v));
          localStorage.setItem("token",tok);
        }
        try { eval(utf8_dec(r.v[1].v)); if (typeof cb == 'function') cb(r); return { status: "ok" }; }
        catch (e) { console.log(e); return { status: '' }; }
    } else return { status: '' };
}

var $file = {}; $file.on = function onfile(r, cb) {
    if (is(r, 10, 'ftpack')) {
        if (typeof cb == 'function') cb(r); return { status: "ok" };
    } else return { status: '' };
}

var $token = {}; $token.on = function ontoken(r, cb) { if (is(r,2,'Token')) {
    if (typeof cb == 'function') cb(r); return { status: "ok" }; } else return { status: '' }; }

// BERT Formatter

var $bert = {}; $bert.protos = [$io, $file, $token]; $bert.on = function onbert(evt, cb) {
    if (Blob.prototype.isPrototypeOf(evt.data) && (evt.data.length > 0 || evt.data.size > 0)) {
        var r = new FileReader();
        r.addEventListener("loadend", function () {
            try {
                erlang = dec(r.result);
//                if (debug) console.log(JSON.stringify(erlang));
                if (typeof cb == 'function') cb(erlang);
                for (var i = 0; i < $bert.protos.length; i++) {
                    p = $bert.protos[i]; if (p.on(erlang, p.do).status == "ok") return;
                }
            } catch (e) { console.log(e); }
        });
        r.readAsArrayBuffer(evt.data);
        return { status: "ok" };
    } else return { status: "error", desc: "data" };
}

var protos = [$bert];

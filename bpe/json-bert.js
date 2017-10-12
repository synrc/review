function clean(r)      { for(var k in r) if(!r[k]) delete r[k]; return r; }
function check_len(x)  { try { return (eval('len'+utf8_dec(x.v[0].v))() == x.v.length) ? true : false }
                         catch (e) { return false; } }

function scalar(data)    {
    var res = undefined;
    switch (typeof data) {
        case 'string': res = bin(data); break; case 'number': res = number(data); break;
        default: console.log('Strange data: ' + data); }
    return res; };
function nil() { return {t: 106, v: undefined}; };

function decode(x) {
    if (x.t == 108) {
        var r = []; x.v.forEach(function(y) { r.push(decode(y)) }); return r;
    } else if (x.t == 109) {
        return utf8_dec(x.v);
    } else if (x.t == 104 && check_len(x)) {
        return eval('dec'+x.v[0].v)(x);
    } else if (x.t == 104) {
        var r=[]; x.v.forEach(function(a){r.push(decode(a))});
	return Object.assign({tup:'$'}, r);
    } else return x.v;
}

function encode(x) {
    if (Array.isArray(x)) {
        var r = []; x.forEach(function(y) { r.push(encode(y)) }); return {t:108,v:r};
    } else if (typeof x == 'object') {
        switch (x.tup) {
	case '$': delete x['tup']; var r=[];
    Object.keys(x).map(function(p){return x[p];}).forEach(function(a){r.push(encode(a))});
	return {t:104, v:r};
	default: return eval('enc'+x.tup)(x); }
    } else return scalar(x);
}

function encmax_tour(d) {
    var tup = atom('max_tour');
    var count = 'count' in d && d.count ? number(d.count) : nil();
    var joined = 'joined' in d && d.joined ? number(d.joined) : nil();
    return tuple(tup,count,joined); }

function lenmax_tour() { return 3; }
function decmax_tour(d) {
    var r={}; r.tup = 'max_tour';
    r.count = d && d.v[1] ? d.v[1].v : undefined;
    r.joined = d && d.v[2] ? d.v[2].v : undefined;
    return clean(r); }

function enctour_list(d) {
    var tup = atom('tour_list');
    var users = []; if ('users' in d && d.users)
	 { d.users.forEach(function(x){
	users.push(encode(x))});
	 users={t:108,v:users}; } else { users = nil() };
    return tuple(tup,users); }

function lentour_list() { return 2; }
function dectour_list(d) {
    var r={}; r.tup = 'tour_list';
    r.users = [];
	 (d && d.v[1] && d.v[1].v) ?
	 d.v[1].v.forEach(function(x){r.users.push(decode(x))}) :
	 r.users = undefined;
    return clean(r); }

function encjoin_application(d) {
    var tup = atom('join_application');
    var id = 'id' in d && d.id ? number(d.id) : nil();
    var name = 'name' in d && d.name ? atom(d.name) : nil();
    var data = 'data' in d && d.data ? encode(d.data) : nil();
    return tuple(tup,id,name,data); }

function lenjoin_application() { return 4; }
function decjoin_application(d) {
    var r={}; r.tup = 'join_application';
    r.id = d && d.v[1] ? d.v[1].v : undefined;
    r.name = d && d.v[2] ? d.v[2].v : undefined;
    r.data = d && d.v[3] ? decode(d.v[3].v) : undefined;
    return clean(r); }


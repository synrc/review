function clean(r)      { for(var k in r) if(!r[k]) delete r[k]; return r; }
function check_len(x)  { try { return (eval('len'+utf8_arr(x.v[0].v))() == x.v.length) ? true : false }
                         catch (e) { return false; } }

function scalar(data)    {
    var res = undefined;
    switch (typeof data) {
        case 'string': res = bin(data); break; case 'number': res = number(data); break;
        default: console.log('Strange data: ' + data); }
    return res; };
function nil() { return {t: 106, v: undefined}; };

function decode(x) {
    if (x == undefined) {
        return [];
    } if (x % 1 === 0) {
        return x;
    } else if (x.t == 108) {
        var r = []; x.v.forEach(function(y) { r.push(decode(y)) }); return r;
    } else if (x.t == 109) {
        return utf8_arr(x.v);
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

function encdict(d) {
    var tup = atom('dict');
    var id = []; if ('id' in d && d.id)
	 { d.id.forEach(function(x){
	id.push(encode(x))});
	 id={t:108,v:id}; } else { id = nil() };
    var type = 'type' in d && d.type ? bin(d.type) : nil();
    var name = 'name' in d && d.name ? bin(d.name) : nil();
    return tuple(tup,id,type,name); }

function lendict() { return 4; }
function decdict(d) {
    var r={}; r.tup = 'dict';
    r.id = [];
	 (d && d.v[1] && d.v[1].v) ?
	 d.v[1].v.forEach(function(x){r.id.push(decode(x))}) :
	 r.id = undefined;
    r.type = d && d.v[2] ? utf8_arr(d.v[2].v) : undefined;
    r.name = d && d.v[3] ? utf8_arr(d.v[3].v) : undefined;
    return clean(r); }

function encLoc(d) {
    var tup = atom('Loc');
    var id = 'id' in d && d.id ? bin(d.id) : nil();
    var code = 'code' in d && d.code ? encode(d.code) : nil();
    var country = 'country' in d && d.country ? bin(d.country) : nil();
    var city = 'city' in d && d.city ? bin(d.city) : nil();
    var address = 'address' in d && d.address ? bin(d.address) : nil();
    var type = 'type' in d && d.type ? encode(d.type) : nil();
    return tuple(tup,id,code,country,city,address,type); }

function lenLoc() { return 7; }
function decLoc(d) {
    var r={}; r.tup = 'Loc';
    r.id = d && d.v[1] ? utf8_arr(d.v[1].v) : undefined;
    r.code = d && d.v[2] ? decode(d.v[2]) : undefined;
    r.country = d && d.v[3] ? utf8_arr(d.v[3].v) : undefined;
    r.city = d && d.v[4] ? utf8_arr(d.v[4].v) : undefined;
    r.address = d && d.v[5] ? utf8_arr(d.v[5].v) : undefined;
    r.type = d && d.v[6] ? decode(d.v[6]) : undefined;
    return clean(r); }

function encOrganization(d) {
    var tup = atom('Organization');
    var id = []; if ('id' in d && d.id)
	 { d.id.forEach(function(x){
	id.push(encode(x))});
	 id={t:108,v:id}; } else { id = nil() };
    var name = 'name' in d && d.name ? bin(d.name) : nil();
    var details = 'details' in d && d.details ? bin(d.details) : nil();
    var hq = 'hq' in d && d.hq ? encode(d.hq) : nil();
    var orgname = 'orgname' in d && d.orgname ? bin(d.orgname) : nil();
    var address = 'address' in d && d.address ? bin(d.address) : nil();
    var director = 'director' in d && d.director ? bin(d.director) : nil();
    var phones = 'phones' in d && d.phones ? encode(d.phones) : nil();
    var url = 'url' in d && d.url ? encode(d.url) : nil();
    var code = 'code' in d && d.code ? encode(d.code) : nil();
    var login = 'login' in d && d.login ? bin(d.login) : nil();
    var password = 'password' in d && d.password ? bin(d.password) : nil();
    var location = 'location' in d && d.location ? encode(d.location) : nil();
    var type = 'type' in d && d.type ? encode(d.type) : nil();
    var keys = 'keys' in d && d.keys ? number(d.keys) : nil();
    return tuple(tup,id,name,details,hq,orgname,address,director,phones,url,code,
	login,password,location,type,keys); }

function lenOrganization() { return 16; }
function decOrganization(d) {
    var r={}; r.tup = 'Organization';
    r.id = [];
	 (d && d.v[1] && d.v[1].v) ?
	 d.v[1].v.forEach(function(x){r.id.push(decode(x))}) :
	 r.id = undefined;
    r.name = d && d.v[2] ? utf8_arr(d.v[2].v) : undefined;
    r.details = d && d.v[3] ? utf8_arr(d.v[3].v) : undefined;
    r.hq = d && d.v[4] ? decode(d.v[4]) : undefined;
    r.orgname = d && d.v[5] ? utf8_arr(d.v[5].v) : undefined;
    r.address = d && d.v[6] ? utf8_arr(d.v[6].v) : undefined;
    r.director = d && d.v[7] ? utf8_arr(d.v[7].v) : undefined;
    r.phones = d && d.v[8] ? decode(d.v[8]) : undefined;
    r.url = d && d.v[9] ? decode(d.v[9]) : undefined;
    r.code = d && d.v[10] ? decode(d.v[10]) : undefined;
    r.login = d && d.v[11] ? utf8_arr(d.v[11].v) : undefined;
    r.password = d && d.v[12] ? utf8_arr(d.v[12].v) : undefined;
    r.location = d && d.v[13] ? decode(d.v[13]) : undefined;
    r.type = d && d.v[14] ? decode(d.v[14]) : undefined;
    r.keys = d && d.v[15] ? d.v[15].v : undefined;
    return clean(r); }

function encPerson(d) {
    var tup = atom('Person');
    var id = 'id' in d && d.id ? encode(d.id) : nil();
    var cn = 'cn' in d && d.cn ? bin(d.cn) : nil();
    var name = 'name' in d && d.name ? bin(d.name) : nil();
    var displayName = 'displayName' in d && d.displayName ? bin(d.displayName) : nil();
    var location = 'location' in d && d.location ? encode(d.location) : nil();
    var hours = 'hours' in d && d.hours ? number(d.hours) : nil();
    var type = 'type' in d && d.type ? encode(d.type) : nil();
    return tuple(tup,id,cn,name,displayName,location,hours,type); }

function lenPerson() { return 8; }
function decPerson(d) {
    var r={}; r.tup = 'Person';
    r.id = d && d.v[1] ? decode(d.v[1]) : undefined;
    r.cn = d && d.v[2] ? utf8_arr(d.v[2].v) : undefined;
    r.name = d && d.v[3] ? utf8_arr(d.v[3].v) : undefined;
    r.displayName = d && d.v[4] ? utf8_arr(d.v[4].v) : undefined;
    r.location = d && d.v[5] ? decode(d.v[5]) : undefined;
    r.hours = d && d.v[6] ? d.v[6].v : undefined;
    r.type = d && d.v[7] ? decode(d.v[7]) : undefined;
    return clean(r); }

function encPersonCN(d) {
    var tup = atom('PersonCN');
    var cn = 'cn' in d && d.cn ? encode(d.cn) : nil();
    var id = 'id' in d && d.id ? encode(d.id) : nil();
    return tuple(tup,cn,id); }

function lenPersonCN() { return 3; }
function decPersonCN(d) {
    var r={}; r.tup = 'PersonCN';
    r.cn = d && d.v[1] ? decode(d.v[1]) : undefined;
    r.id = d && d.v[2] ? decode(d.v[2]) : undefined;
    return clean(r); }

function encBranch(d) {
    var tup = atom('Branch');
    var id = 'id' in d && d.id ? bin(d.id) : nil();
    var name = []; if ('name' in d && d.name)
	 { d.name.forEach(function(x){
	name.push(encode(x))});
	 name={t:108,v:name}; } else { name = nil() };
    var org = 'org' in d && d.org ? bin(d.org) : nil();
    var parent = 'parent' in d && d.parent ? bin(d.parent) : nil();
    var short = []; if ('short' in d && d.short)
	 { d.short.forEach(function(x){
	short.push(encode(x))});
	 short={t:108,v:short}; } else { short = nil() };
    var head = 'head' in d && d.head ? encode(d.head) : nil();
    var deputies = []; if ('deputies' in d && d.deputies)
	 { d.deputies.forEach(function(x){
	deputies.push(encode(x))});
	 deputies={t:108,v:deputies}; } else { deputies = nil() };
    var type = 'type' in d && d.type ? atom(d.type) : nil();
    var loc = 'loc' in d && d.loc ? encode(d.loc) : nil();
    return tuple(tup,id,name,org,parent,short,head,deputies,type,loc); }

function lenBranch() { return 10; }
function decBranch(d) {
    var r={}; r.tup = 'Branch';
    r.id = d && d.v[1] ? utf8_arr(d.v[1].v) : undefined;
    r.name = [];
	 (d && d.v[2] && d.v[2].v) ?
	 d.v[2].v.forEach(function(x){r.name.push(decode(x))}) :
	 r.name = undefined;
    r.org = d && d.v[3] ? utf8_arr(d.v[3].v) : undefined;
    r.parent = d && d.v[4] ? utf8_arr(d.v[4].v) : undefined;
    r.short = [];
	 (d && d.v[5] && d.v[5].v) ?
	 d.v[5].v.forEach(function(x){r.short.push(decode(x))}) :
	 r.short = undefined;
    r.head = d && d.v[6] ? decode(d.v[6]) : undefined;
    r.deputies = [];
	 (d && d.v[7] && d.v[7].v) ?
	 d.v[7].v.forEach(function(x){r.deputies.push(decode(x))}) :
	 r.deputies = undefined;
    r.type = d && d.v[8] ? d.v[8].v : undefined;
    r.loc = d && d.v[9] ? decode(d.v[9]) : undefined;
    return clean(r); }

function encEmployee(d) {
    var tup = atom('Employee');
    var id = 'id' in d && d.id ? encode(d.id) : nil();
    var person = 'person' in d && d.person ? encode(d.person) : nil();
    var org = 'org' in d && d.org ? encode(d.org) : nil();
    var branch = 'branch' in d && d.branch ? encode(d.branch) : nil();
    var code = 'code' in d && d.code ? encode(d.code) : nil();
    var surname = 'surname' in d && d.surname ? encode(d.surname) : nil();
    var name = 'name' in d && d.name ? encode(d.name) : nil();
    var middle_name = 'middle_name' in d && d.middle_name ? encode(d.middle_name) : nil();
    var sex = 'sex' in d && d.sex ? encode(d.sex) : nil();
    var birthday = 'birthday' in d && d.birthday ? encode(d.birthday) : nil();
    var hired = 'hired' in d && d.hired ? encode(d.hired) : nil();
    var fired = 'fired' in d && d.fired ? encode(d.fired) : nil();
    var inn = 'inn' in d && d.inn ? encode(d.inn) : nil();
    var position = 'position' in d && d.position ? encode(d.position) : nil();
    var number = 'number' in d && d.number ? encode(d.number) : nil();
    var title = []; if ('title' in d && d.title)
	 { d.title.forEach(function(x){
	title.push(encode(x))});
	 title={t:108,v:title}; } else { title = nil() };
    var role = []; if ('role' in d && d.role)
	 { d.role.forEach(function(x){
	role.push(encode(x))});
	 role={t:108,v:role}; } else { role = nil() };
    var phone = 'phone' in d && d.phone ? encode(d.phone) : nil();
    var mail = []; if ('mail' in d && d.mail)
	 { d.mail.forEach(function(x){
	mail.push(encode(x))});
	 mail={t:108,v:mail}; } else { mail = nil() };
    var type = 'type' in d && d.type ? encode(d.type) : nil();
    return tuple(tup,id,person,org,branch,code,surname,name,middle_name,sex,birthday,
	hired,fired,inn,position,number,title,role,phone,mail,type); }

function lenEmployee() { return 21; }
function decEmployee(d) {
    var r={}; r.tup = 'Employee';
    r.id = d && d.v[1] ? decode(d.v[1]) : undefined;
    r.person = d && d.v[2] ? decode(d.v[2]) : undefined;
    r.org = d && d.v[3] ? decode(d.v[3]) : undefined;
    r.branch = d && d.v[4] ? decode(d.v[4]) : undefined;
    r.code = d && d.v[5] ? decode(d.v[5]) : undefined;
    r.surname = d && d.v[6] ? decode(d.v[6]) : undefined;
    r.name = d && d.v[7] ? decode(d.v[7]) : undefined;
    r.middle_name = d && d.v[8] ? decode(d.v[8]) : undefined;
    r.sex = d && d.v[9] ? decode(d.v[9]) : undefined;
    r.birthday = d && d.v[10] ? decode(d.v[10]) : undefined;
    r.hired = d && d.v[11] ? decode(d.v[11]) : undefined;
    r.fired = d && d.v[12] ? decode(d.v[12]) : undefined;
    r.inn = d && d.v[13] ? decode(d.v[13]) : undefined;
    r.position = d && d.v[14] ? decode(d.v[14]) : undefined;
    r.number = d && d.v[15] ? decode(d.v[15]) : undefined;
    r.title = [];
	 (d && d.v[16] && d.v[16].v) ?
	 d.v[16].v.forEach(function(x){r.title.push(decode(x))}) :
	 r.title = undefined;
    r.role = [];
	 (d && d.v[17] && d.v[17].v) ?
	 d.v[17].v.forEach(function(x){r.role.push(decode(x))}) :
	 r.role = undefined;
    r.phone = d && d.v[18] ? decode(d.v[18]) : undefined;
    r.mail = [];
	 (d && d.v[19] && d.v[19].v) ?
	 d.v[19].v.forEach(function(x){r.mail.push(decode(x))}) :
	 r.mail = undefined;
    r.type = d && d.v[20] ? decode(d.v[20]) : undefined;
    return clean(r); }

function encEmployeeCode(d) {
    var tup = atom('EmployeeCode');
    var code = 'code' in d && d.code ? encode(d.code) : nil();
    var cn = 'cn' in d && d.cn ? encode(d.cn) : nil();
    return tuple(tup,code,cn); }

function lenEmployeeCode() { return 3; }
function decEmployeeCode(d) {
    var r={}; r.tup = 'EmployeeCode';
    r.code = d && d.v[1] ? decode(d.v[1]) : undefined;
    r.cn = d && d.v[2] ? decode(d.v[2]) : undefined;
    return clean(r); }


const express = require('express');
const ActiveRecord = require('active_record');
const app = express();

module.exports = User;

ActiveRecord.Base.extend(User, ActiveRecord.Base);

app.use(express.static('public'));
app.set('view engine', 'pug');

function User () {
	this.initialize(arguments[0]);
	this.validates('username', {
		presence: true
	});
	this.validates('display_name', {
		presence: true
	});
	this.validate_length_of('password', {minimum: 5});
	this.has_secure_password();
}

User.table_name = 'users';
User.fields('username', 'password', 'display_name', 'site_name', 'site_url', 'site_description', 'is_admin', 'is_approved');

User.next = function() {
	var next = User.find(this.id + 1);
	if (!next) {
		next = User.first();
	}
	return next;
}

User.prev = function() {
	var prev = User.find(this.id - 1);
	if (!prev) {
		prev = User.last();
	}
	return prev;
}

app.get('/', function (req, res) {
  res.render('index', {message: 'hello, world!', heading: 'hello!!'});
});

app.get('/site/:id', function (req, res) {
  var user = User.find(this.id);
  res.render('site', {user: user});
});

app.get('/site/:id/next', function (req, res) {
	var user = User.find(req.params.id);
	res.send(user.next.site_url);
});

app.get('/site/:id/prev', function (req, res) {
	var user = User.find(req.params.id);
	res.send(user.prev.site_url);
});

app.get('/admin', function (req, res) {
  var users = User.all;
  res.render('admin', {users: users});
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
});

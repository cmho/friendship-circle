const express = require('express');
const activerecord = require('active_record');
const app = express();

module.exports = User;

ActiveRecord.Base.extend(User, ActiveRecord.Base);

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

});

app.get('/user/:id/next', function (req, res) {
	var user = User.find(req.params.id);
	return user.next.site_url;
});

app.get('/user/:id/prev', function (req, res) {
	var user = User.find(req.params.id);
	return user.prev.site_url;
});

'use strict';

var lockfile = require('lockfile');

module.exports = function atomicFs(file, opts, fn, cb) {
	if (arguments.length <= 3) {
		cb = fn;
		fn = opts;
		opts = {};
	}

	opts = opts || {};

	lockfile.lock(file, opts, function (err) {
		if (err) {
			return cb(err);
		}

		fn(function (fnerr) {
			lockfile.unlock(file, function (err) {
				return cb(fnerr || err);
			});
		});
	});
};

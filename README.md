# node-atomic-fs [![Travis-CI.org Build Status](https://img.shields.io/travis/Qix-/node-atomic-fs.svg?style=flat-square)](https://travis-ci.org/Qix-/node-atomic-fs) [![Coveralls.io Coverage Rating](https://img.shields.io/coveralls/Qix-/node-atomic-fs.svg?style=flat-square)](https://coveralls.io/r/Qix-/node-atomic-fs)
> Atomically perform file operations

Works similarly to a mutex for files. This means *all* file operations must be
wrapped in calls to `atomicFs` in order to achieve locks.

## Example
```javascript
var atomicFs = require('atomic-fs');

atomicFs('some/path/to/file',
	function (cb) {
		/* locked */
		/* some file operations */
		cb();
	},
	function (err) {
		/* unlocked */
	});
```

## License
Licensed under the [MIT License](http://opensource.org/licenses/MIT).
You can find a copy of it in [LICENSE](LICENSE).

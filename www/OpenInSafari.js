var exec = require('cordova/exec');
var executeCallback = function(callback, message) {
    if (typeof callback === 'function') {
        callback(message);
    }
};


/**
 * Open URL in default system browser.
 * @param {string} URL to open
 * @param {Function} [successCallback] - Optional success callback, recieves message object.
 * @param {Function} [errorCallback] - Optional error callback, recieves message object.
 * @returns {Promise}
 */
exports.open = function(url, successCallback, errorCallback) {
    return new Promise(function(resolve, reject) {
        exec(function(message) {
            executeCallback(successCallback, message);
            resolve(message);
        }, function(message) {
            executeCallback(errorCallback, message);
            reject(message);
        }, 'OpenInSafari', 'open', [{url: url}]);
    });
};

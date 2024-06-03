var exec = require('cordova/exec');
var executeCallback = function(callback, message) {
    if (typeof callback === 'function') {
        callback(message);
    }
};


/**
 * Send data to intent of another application.
 * @param {object} order
 * @param {Function} [successCallback] - Optional success callback, recieves message object.
 * @param {Function} [errorCallback] - Optional error callback, recieves message object.
 * @returns {Promise}
 */
exports.get = function(successCallback, errorCallback) {
    return new Promise(function(resolve, reject) {
        exec(function(message) {
            executeCallback(successCallback, message);
            resolve(message);
        }, function(message) {
            executeCallback(errorCallback, message);
            reject(message);
        }, 'MySpeed', 'get', []);
    });
};

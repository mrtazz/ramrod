/* extend jquery with methods for HTTP PUT and DELETE */
function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
        });
}

jQuery.extend({
    http_put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    http_delete: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

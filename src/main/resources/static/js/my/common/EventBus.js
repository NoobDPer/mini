var EventBus = (function () {

    function EventBus() {
        this.events = {};
    }

    /**
     * 声明事件
     * @param eventName 事件名称
     * @param flags [{string}] $.Callbacks()的flags参数
     * @returns {$.Callbacks}
     */
    EventBus.prototype.declare = function (eventName, flags) {
        var callbacks = this.events[eventName];
        if (callbacks != null) {
            delete this.events[eventName];
        }
        callbacks = $.Callbacks(flags);
        this.events[eventName] = {
            callbacks : callbacks
        };
        return this.__getEvent(eventName);
    };

    EventBus.prototype.__getEvent = function(eventName) {
        var event = this.events[eventName];
        if (!event) {
            throw new Error('未声明的事件');
        }
        return event;
    };

    EventBus.prototype.subscribe = function (eventName, fn) {
        this.__getEvent(eventName).callbacks.add(fn);
    };

    EventBus.prototype.publish = function (eventName, data) {
        var event = this.__getEvent(eventName);
        if (!event) {
            return null;
        }
        event.callbacks.fire({
            data: data,
            event: event
        });
    };

    return EventBus;
})();
mixpanelTrackDirective = (Mixpanel) ->
    restrict: 'A'
    link: ($scope, el, attr) ->
        console.log 'mixpanelTrack directive has loaded'
        el.on "click", ->
            [ name, payload ] = JSON.parse attr.mixpanelTrack
            console.log 'mixpanel-track:', name, payload
            Mixpanel.track name, payload
angular
    .module 'yi.mixpanel.mixpanel-track'
    .directive 'mixpanelTrack', mixpanelTrackDirective
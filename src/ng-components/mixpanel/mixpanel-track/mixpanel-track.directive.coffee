mixpanelTrackDirective = (Mixpanel) ->
    restrict: 'A'
    link: ($scope, el, attr) ->
        el.on "click", ->
            [ name, payload ] = JSON.parse attr.mixpanelTrack
            console.log "Mixpanel.track", MixpanelService, Mixpanel.track, name, payload
            Mixpanel.track name, payload
angular
    .module 'yi.mixpanel.mixpanel-track'
    .directive 'mixpanelTrack', mixpanelTrackDirective
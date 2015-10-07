###*
 * NOTE: Tried to bind this to document, but it didnt work, thus relying on global lexical scope.
###
_evalScriptOnWindow = (script) =>
    console.log "script", script
    eval script

# Service constructor
MixpanelService = ($routeParams, getMixpanel) ->
    @track = (eventName, eventData) ->
        debugger
        console.log 'mixpanel.trackIt', getMixpanel(), eventName, eventData
        getMixpanel().track eventName, eventData
    @

# Provider
MixpanelProvider = =>
    
    getMixpanel = -> window['mixpanel'] # Must be evaluated as changes form (like google analytics)
    identity = null
    routeParamsChange = null
    locationChange = null
    configObj = null

    # Config
    @setConfig = (val) =>
        return null unless val?.isActive()
        configObj = val
        _evalScriptOnWindow configObj.getScript()
        identity          = configObj.identityFunc getMixpanel()
        locationChange    = configObj.locationChange
        routeParamsChange = configObj.routeParamsChange

    # Service creation
    @$get = ($rootScope, $routeParams, $location) =>
        if not configObj?.isActive() then return track: -> console.warn 'mixpanel analytics inactive'
        $rootScope.$watch (=> $routeParams), (newVal) => routeParamsChange getMixpanel(), newVal
        $rootScope.$watch (=> $location),    (newVal) => locationChange getMixpanel(), newVal
        new MixpanelService $routeParams, getMixpanel

    @

angular
    .module 'yi.mixpanel'
    .provider 'Mixpanel', MixpanelProvider
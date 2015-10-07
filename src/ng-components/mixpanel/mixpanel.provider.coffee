###*
 * NOTE: Tried to bind this to document, but it didnt work, thus relying on global lexical scope.
###
_evalScriptOnWindow = (script) =>
    eval script

MixpanelProvider = ->
    props =
        mixpanel: null
        identity: null
        routeParamsChange: null
        locationChange: null

    _addScript = (key) =>
        _evalScriptOnWindow key

    # Config
    setConfig = (configObj) =>
        
        return null unless configObj?.isActive()
        props.config = configObj
        props.mixpanel = window.mixpanel
        props.identity = props.config.identityFunc props.mixpanel
        _addScript props.config.getScript()

    # Methods shared between service and provider
    methodsProps = {
        props
        setConfig
        _addScript
    }

    # Service constructor
    MixpanelService = ($routeParams) ->
        @track = (eventName, eventData) =>
            console.log 'mixpanel.track', mixpanel, eventName, eventData
            mixpanel.track eventName, eventData
        _.extend @, methodsProps
        @


    # Constructor
    @$get = ($rootScope, $routeParams, $location) =>
        console.log '@$get props.isActive:', props
        return track: -> console.log 'mixpanel analytics `isActive() == false`' unless props.config?.isActive()
        getRouteParams = => $routeParams
        getLocation = => $location
        $rootScope.$watch getRouteParams, (newVal) => props.routeParamsChange props.mixpanel, newVal
        $rootScope.$watch getLocation, (newVal) => props.locationChange props.mixpanel, newVal
        new MixpanelService $routeParams

    _.extend @, methodsProps
    @
tes=123
angular
    .module 'yi.mixpanel'
    .provider 'Mixpanel', MixpanelProvider
# Yieldify ng Mixpanel componenets

## What

Angular 1.x components for mixpanel

## Main features

- attribute directives for tracking
- Highly configurable
- Puts it where you expect

## Usage

export-report.template.html:
```html
    <h3> Awesome report </h3>
    <save-button mixpanel-track="{{['saved',  {'Is report ': true, 'Document name': 'Awesome report'}]}}"></save-button>

```



## Installation

In the config phase:

```CoffeeScript

angular.module('app').config ( configMixpanelConstant, MixpanelProvider ) ->
    MixpanelProvider.setConfig configMixpanelConstant

```


config-mixpanel.constant.coffee:

```CoffeeScript

configMixpanelConstant =
    isActive: => true


    identityFunc: (mp) =>
        mp.identify USER_ID

        mp.people.set {
            "$email": window.user.email
            "$name": window.user.name
        }

        mp.people.set_once {
            "Staff": window.user.isStaff
        }

        mp.people.increment "App load count"

        mp.register {
            "Dash version"  : window.user.version
        }

        return window.USER_ID


    routeParamsChange: (mp, newVal) -> # unused currently

    locationChange: (mp, newVal) ->
        p = 0
        pathBits = _.compact newVal.$$path.split '/'
        mp.register { "Url path seg #{p}": pathBits[p-1] } while p++ < pathBits.length
        mp.track "Location change"  if pathBits?[1]

    getScript: () ->
        envs =
            "dash-lab.com" : """
            <!-- start Mixpanel --><script type="text/javascript">(function(e,b){if(!b.__SV){var a,f,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable time_event track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.union people.track_charge people.clear_charges people.delete_user".split(" ");
            for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=e.createElement("script");a.type="text/javascript";a.async=!0;a.src="undefined"!==typeof MIXPANEL_CUSTOM_LIB_URL?MIXPANEL_CUSTOM_LIB_URL:"file:"===e.location.protocol&&"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js".match(/^\/\//)?"https://cdn.mxpnl.com/libs/mixpanel-2-latest.min.js":"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";f=e.getElementsByTagName("script")[0];f.parentNode.insertBefore(a,f)}})(document,window.mixpanel||[]);
            mixpanel.init("YYYYYYYYYYYYYYYYYYYYYYYYYYYYY");</script><!-- end Mixpanel -->
            """
        
            "unknown" : """<!-- start Mixpanel --><script type="text/javascript">(function(e,b){if(!b.__SV){var a,f,i,g;window.mixpanel=b;b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable time_event track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.union people.track_charge people.clear_charges people.delete_user".split(" ");
            for(g=0;g<i.length;g++)f(c,i[g]);b._i.push([a,e,d])};b.__SV=1.2;a=e.createElement("script");a.type="text/javascript";a.async=!0;a.src="undefined"!==typeof MIXPANEL_CUSTOM_LIB_URL?MIXPANEL_CUSTOM_LIB_URL:"file:"===e.location.protocol&&"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js".match(/^\/\//)?"https://cdn.mxpnl.com/libs/mixpanel-2-latest.min.js":"//cdn.mxpnl.com/libs/mixpanel-2-latest.min.js";f=e.getElementsByTagName("script")[0];f.parentNode.insertBefore(a,f)}})(document,window.mixpanel||[]);
            mixpanel.init("ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");</script><!-- end Mixpanel -->
            """
        chosen = envs[window.location.hostname] or envs.unknown
        chosen = chosen.split('\/\/').join('\\/\\/') # needs to be escaped for eval
        chosen.split('<!-- start Mixpanel --><script type="text/javascript">').join('').split('</script><!-- end Mixpanel -->').join('')


angular
    .module 'app.config.configMixpanel'
    .constant 'configMixpanelConstant', configMixpanelConstant

```



## Build

```Shell

$ npm i --save-dev
$ gulp

```

## Todo

- Cleanup
- Change docs code examples to javascript
- Write tests

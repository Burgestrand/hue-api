---
title: Unofficial Philips Hue API Reference
---

# [Philips Hue API — Unofficial Reference Documentation](http://burgestrand.github.com/hue-api)

Philips Hue API reference documentation, created by reverse-engineering,
sniffing network traffic and a lot of guessing.

There is a mailing list, dedicated to discussions and questions about hacking
the Philips Hue and related protocols.

- Mailing list web interface: <https://groups.google.com/d/forum/hue-hackers>
- Mailing list e-mail address: <hue-hackers@googlegroups.com>

This repository was forked from the [GitHub API v3 documentation][].  It’s a
static site built with [nanoc][], and is published to <http://burgestrand.github.com/hue-api>
for hosting via [GitHub Pages][].

All submissions are welcome. To submit a change, fork this repo, commit your
changes, and send us a [pull request](http://help.github.com/send-pull-requests/).

[nanoc]: http://nanoc.stoneship.org/
[GitHub Pages]: http://pages.github.com/
[GitHub API v3 documentation]: https://github.com/github/developer.github.com

## Typical Hue bridge API workflow

1. <%= relative_link_to 'Hue bridge discovery', '/api/discovery' %> via SSDP (a multicast protocol over UDP).
   Ruhue has an example of how this discovery can be performed written in Ruby and UDP sockets: [Hue.discover][].
2. <%= relative_link_to 'A one-time application registration', '/api/auth/registraiton' %> to the Hue bridge
   over HTTP. You pick your own username, which is used for all subsequent API calls.
3. Finished. You may now place any API calls, using your username, against the Hue bridge.

[SSDP]: http://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[Hue.discover]: https://github.com/Burgestrand/ruhue/blob/181072803db7f64730576373147ae15694416617/lib/hue.rb#L23

## Reading Hue bridge system state

You can read the state of the entire system, after <%= relative_link_to 'authentication', '/api/auth/registration' %>, through a single endpoint.

<%= http 'GET /api/:username' %>

### Response

<% json do %>
{
  "lights":{
    "1":{
      "state":{
        "on":true,
        "bri":240,
        "hue":15331,
        "sat":121,
        "xy":[
          0.4448,
          0.4066
        ],
        "ct":343,
        "alert":"none",
        "effect":"none",
        "colormode":"ct",
        "reachable":true
      },
      "type":"Extended color light",
      "name":"TV Vänster",
      "modelid":"LCT001",
      "swversion":"65003148",
      "pointsymbol":{
        "1":"none",
        "2":"none",
        "3":"none",
        "4":"none",
        "5":"none",
        "6":"none",
        "7":"none",
        "8":"none"
      }
    }
  },
  "groups":{

  },
  "config":{
    "name":"Lumm",
    "mac":"00:00:00:00:7b:be",
    "dhcp":true,
    "ipaddress":"192.168.0.21",
    "netmask":"255.255.255.0",
    "gateway":"192.168.0.1",
    "proxyaddress":" ",
    "proxyport":0,
    "UTC":"2012-11-06T21:57:59",
    "whitelist":{
      "24e04807fe143caeb52b4ccb305635f8":{
        "last use date":"2012-11-06T20:43:34",
        "create date":"1970-01-01T00:00:45",
        "name":"Kim Burgestrand’s iPhone"
      }
    },
    "swversion":"01003542",
    "swupdate":{
      "updatestate":0,
      "url":"",
      "text":"",
      "notify":false
    },
    "linkbutton":false,
    "portalservices":true
  },
  "schedules":{
    "1":{
      "name":"Frukost on 103811             ",
      "description":" ",
      "command":{
        "address":"/api/24e04807fe143caeb52b4ccb305635f8/lights/3/state",
        "body":{
          "bri":253,
          "transitiontime":5400,
          "xy":[
            0.52594,
            0.43074
          ],
          "on":true
        },
        "method":"PUT"
      },
      "time":"2012-11-07T04:41:02"
    }
  }
}
<% end %>

---
title: Bridge configuration
---

# Bridge configuration

You can read and change configuration settings of your bridge, such as it’s name,
wether it uses DHCP or not, proxy information and application whitelist.

<%= toc %>

## Reading bridge configuration

<%= http 'GET /api/:username/config' %>

### Response

<% json do %>
{
  "name":"Lumm",
  "mac":"00:00:00:00:7b:be",
  "dhcp":true,
  "ipaddress":"192.168.0.21",
  "netmask":"255.255.255.0",
  "gateway":"192.168.0.1",
  "proxyaddress":" ",
  "proxyport":0,
  "UTC":"2012-11-06T21:35:35",
  "whitelist":{
    "24e04807fe143caeb52b4ccb305635f8":{
      "last use date":"2012-11-06T20:43:34",
      "create date":"1970-01-01T00:00:45",
      "name":"Kim Burgestrand’s iPhone"
    },
    "burgestrand":{
      "last use date":"2012-11-05T20:39:41",
      "create date":"2012-11-06T21:31:10",
      "name":"macbook"
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
}
<% end %>

## Updating bridge configuration

<%= http 'PUT /api/:username/config' %>

### Parameters

All parameters are optional. Only the parameters present will update values on the Hue.

name
: new name of the Hue bridge.

dhcp
: true if the bridge should use DHCP. if you set this to false you might make your bridge unreachable.
  If that happens, there is a “Restore to factory settings” button on the back of the bridge.

portalservices
: true if remote access through <http://meethue.com/> is to be enabled.

### Input

<%= json "name" => "Lumm" %>

### Response

<% json do %>
[
  {
    "success":{
      "/config/name":"Lumm"
    }
  }
]
<% end %>

## Deregistering an application

Removes a username from the whitelist of registered applications.

<%= http "DELETE /api/:username/config/whitelist/:username" %>

### Response

<%= json [{ "success" => "/config/whitelist/burgestrand deleted" }] %>

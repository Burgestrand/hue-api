---
title: Groups
---

# Groups

Groups allow you to group your lights, useful to control them all at the
same time with just one API call.

**Note**: There exists a special group with a number of 0, which contains all
lights known to the bridge. Issuing operations on group #0 will change all
lights simultaneously.

<%= toc %>

## List all groups

<%= http 'GET /api/:username/groups' %>

### Response

No meaningful response known yet.

## Show group information

Information retrieved is not live-updated from all lights. Values returned are simply
the values that were last assigned.

<%= http 'GET /api/:username/groups/:number' %>

### Parameters

number
: group number of the group you wish to control, 0 for a group which contains all lights.

### Response

<%= http 'GET /api/:username/groups/0' %>

<% json do %>
{
  "action":{
    "on":true,
    "bri":254,
    "hue":13122,
    "sat":211,
    "xy":[ 0.5119, 0.4147 ],
    "ct":467,
    "effect":"none",
    "colormode":"ct"
  },
  "lights":[ "1", "2", "3" ],
  "name":"Lightset 0"
}
<% end %>

## Controlling all lights in a group

<%= http 'PUT /api/:username/groups/:number/action' %>

### Parameters

<%= relative_link_to "See the API for “Changing light color and turning them on/off”.", "/api/lights/#changing-light-color-and-turning-them-onoff" %>

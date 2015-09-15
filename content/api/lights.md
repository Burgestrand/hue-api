---
title: Lights
---

# Lights

Allows you to list and control individual lights. You can only
change the state of one light at a time. For controlling multiple
lights with one API call, <%= relative_link_to 'see Groups', '/api/groups' %>.

<%= toc %>

## List all lights and their names

<%= http 'GET /api/:username/lights' %>

### Response

<% json do %>
{
  "1":{
    "name":"TV Left"
  },
  "2":{
    "name":"TV Right"
  }
}
<% end %>

The number before each light is its ID. You’ll use it for changing
the state of the light.

## Show light information

<%= http 'GET /api/:username/lights/:number' %>

### Parameters

number
: number assigned to the light you wish to control, see <%= link_to 'List all lights and their names', '#list-all-lights-and-their-names' %>.

### Response

<% json do %>
{
  "state": {
    "on": true,
    "bri": 202,
    "hue": 13122,
    "sat": 211,
    "xy": [0.5119, 0.4147],
    "ct": 467,
    "alert": "none",
    "effect": "none",
    "colormode": "ct",
    "reachable": true
  },
  "type": "Extended color light",
  "name": "TV Left",
  "modelid": "LCT001",
  "swversion": "65003148",
  "pointsymbol": {
    "1": "none",
    "2": "none",
    "3": "none",
    "4": "none",
    "5": "none",
    "6": "none",
    "7": "none",
    "8": "none"
  }
}
<% end %>

## Changing light color and turning them on/off

There are three modes of color: hue/sat/bri, xy-coordinates, or color temperature. Setting one
of these will change the colormode, but will not update any other values to reflect the change.

<%= http 'PUT /api/:username/lights/:number/state' %>

### Parameters

on
: true if the light should be on.

bri
: brightness, in range 0 - 254. 0 is not off.

hue
: hue, in range 0 - 65535.

sat
: saturation, in range 0 - 254.

xy
: color as array of xy-coordinates.

ct
: white color temperature, 154 (cold) - 500 (warm).

alert
: `select` flashes light once, `lselect` flashes repeatedly for 10 seconds.

transitiontime
: time for transition in deciseconds.

### Input

<%= json "on" => false %>

### Response

<%= json [{"success" => {"/lights/1/state/on" => false}}] %>

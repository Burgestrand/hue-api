---
title: Schedules
---

# Schedules

Schedules allow you to schedule an API call for a given point in
time in the future. You can schedule any Hue bridge API call.

<%= toc %>

## List all schedules

All you receive from this command is the schedule id and it’s name.

<%= http 'GET /api/:username/schedules' %>

### Response

<% json do %>
{
  "1":{
    "name":"Frukost on f 423043           "
  },
  "2":{
    "name":"Frukost on 607775             "
  }
}
<% end %>

## Create a new scheduled operation

<%= http 'POST /api/:username/schedules' %>

### Parameters

name (optional)
: a name to give to your schedule. Does not need to be unique. Must be between
  1 and 32 characters. If not specified it defaults to “schedule”.

description (optional)
: a description to give your schedule. Must be between 1 and 64 characters.

time
: a time, specified in UTC, formatted as YYYY-MM-DDTHH:MM:SS, when the scheduled
  operation should be performed. Once performed, the scheduled operation is removed
  from the Hue. Values earlier than the current time will result in an error.

command
: a command object, describing the request to be performed when the scheduled
  operation is invoked. You can invoke pretty much any URL with any method,
  as long as all parameters have been defined.

  action
  : a bridge API resource to which the operation should be invoked on.

  method
  : the HTTP method the operation should be invoked with.

  body
  : body that the operation should be sent with, `{}` if it should be empty.

### Input

<% json do %>
{
  "name":"Good night",
  "description":"I should really go to bed by now.",
  "command":{
    "address":"/api/24e04807fe143caeb52b4ccb305635f8/groups/0/action",
    "method":"PUT",
    "body":{
      "on":false
    }
  },
  "time":"2013-03-02T00:00:00"
}
<% end %>

### Response

The id given is the id number for the newly created schedule.

<% json do %>
[
  {
    "success":{
      "id":"1"
    }
  }
]
<% end %>

## Show schedule information

<%= http 'GET /api/:username/schedules/:number' %>

### Parameters

number
: group number you wish to retrieve information from.

### Response

<% json do %>
{
  "name":"Good night",
  "description":"I should really go to bed by now.",
  "command":{
    "address":"/api/burgestrand/groups/0/action",
    "body":{
      "on":false
    },
    "method":"PUT"
  },
  "time":"2013-03-02T00:00:00"
}
<% end %>

## Update an existing scheduled operation

<%= http 'PUT /api/:username/schedules/:number' %>

### Parameters

<%= relative_link_to "See the parameters for “Create a new scheduled operation”.", "/api/schedules/#create-a-new-scheduled-operation" %>

### Input

<% json do %>
{
  "name": "Hey"
}
<% end %>

### Response

<% json do %>
[
  {
    "success":{
      "/schedules/1/name":"Hey"
    }
  }
]
<% end %>

## Delete a previously scheduled operation

<%= http 'DELETE /api/:username/schedules/:number' %>

### Parameters

number
: group number you wish to delete.

### Response

<% json do %>
[
  {
    "success":"/schedules/6 deleted"
  }
]
<% end %>

---
title: Application registration
---

# Application registration

Before you can send any API calls to the bridge you’ll need to register a username. Your
bridge will remember your username, and keeps track of when it was last used.

Multiple applications can be registered with the same username, as long as their devicetype
is different. It is currently unknown what effect this might have on the bridge.

You can <%= relative_link_to 'deregister a registered application through the configuration', '/api/config#deregistering-an-application' %>.

<%= toc %>

## Registering an application

<%= http 'POST /api' %>

### Parameters

username
: numbers (0-9) and letters (a-z, A-Z), between 10 and 40 bytes in length (inclusive).

devicetype
: accepts any string, between 1 and 40 bytes in length (inclusive), used to label the application with a name.

### Input

<%= json "username" => "burgestrand", "devicetype" => "Ruhue API Client" %>

### Response

#### Success

<%= json [{"success" => { "username" => "burgestrand" }}] %>

#### Link button not pressed

<% json do %>
[
  {
    "error":{
      "type":101,
      "address":"",
      "description":"link button not pressed"
    }
  }
]
<% end %>

#### Invalid username and empty devicetype

<% json do %>
[
  {
    "error":{
      "type":7,
      "address":"/username",
      "description":"invalid value, burges, for parameter, username"
    }
  },
  {
    "error":{
      "type":2,
      "address":"/",
      "description":"body contains invalid json"
    }
  }
]
<% end %>

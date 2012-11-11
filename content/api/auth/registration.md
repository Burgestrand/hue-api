# Application registration

Before you can send any API calls to the bridge you’ll need to register a username. Your
bridge will remember your username, and keeps track of when it was last used.

Multiple applications can be registered with the same username, as long as their devicetype
is different. It is currently unknown what effect this might have on the bridge.

- TOC
{:toc}

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

<%= json [{"success" => { "username" => "burgestrand" }}] %>

### Failure responses

Failure. Given an invalid username (too short), and an empty devicetype. Error
type 7 is for invalid values, and the description contains a human readable
string of what is wrong.

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

A successful initial post, given a username of `burgestrand` and device type of
`macbook`.  As you can see, an error of type 101 means that the user needs to
press the link button on the Hue bridge, in order for it to allow new registrations.

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

## Deregistering an application

Removes a username from the whitelist of registered applications. See also <%= relative_link_to 'changing configuration', '/api/config/change' %>.

<%= http "DELETE /api/:username/config/whitelist/:username" %>

### Response

<%= json [{ "success" => "/config/whitelist/burgestrand deleted" }] %>

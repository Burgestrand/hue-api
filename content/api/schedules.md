---
title: Schedules
---

# Schedules

Schedules allow you to change light state at a given time.

<%= toc %>

## List all schedules

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

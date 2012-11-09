---
title: API Workflow
---

# Typical API workflow

1. Hue hub discovery via [SSDP][]. Ruhue has an example of how this discovery
   can be performed written in Ruby and UDP sockets: [Hue.discover][].
2. A one-time application registration to the Hue hub via a POST to <%= link_to '/api', '/api/registration' %>.
   The username used in this registration is used in all subsequent API calls.
3. Finished. You may now place any API calls against the Hue hub.

[SSDP]: http://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[Hue.discover]: https://github.com/Burgestrand/ruhue/blob/181072803db7f64730576373147ae15694416617/lib/hue.rb#L23

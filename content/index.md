---
title: Hue API
---

# The Philips Hue API

Philips Hue API reference documentation, created by reverse-engineering,
sniffing network traffic and a lot of guessing.

There is a mailing list, dedicated to discussions and questions about hacking
the Philips Hue and related protocols.

- Mailing list web interface: <https://groups.google.com/d/forum/hue-hackers>
- Mailing list e-mail address: <hue-hackers@googlegroups.com>

## API

Typical API workflow:

1. Hue hub discovery via [SSDP][]. Ruhue has an example of how this discovery
   can be performed written in Ruby and UDP sockets: [Hue.discover][].
2. A one-time application registration to the Hue hub via a POST to [[/api]].
   The username used in this registration is used in all subsequent API calls.
3. Finished. You may now place any API calls against the Hue hub.

[SSDP]: http://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol
[Hue.discover]: https://github.com/Burgestrand/ruhue/blob/181072803db7f64730576373147ae15694416617/lib/hue.rb#L23

## Contributions

To contribute to this wiki, please clone the Ruhue repository, check out the
wiki branch, and create your feature branch from there. Once you are done, do
send a pull request to the Ruhue repository.

This is the way it’ll have to be until GitHub supports pull requests for wikis.

When doing a contribution, please respect the following formatting rules:

- Every API URL has it’s own page.
- If different verbs are supported (GET, POST, PUT, DELETE) for an URL, explanation
  of each verb and it’s effects are written on the page for that URL.
- Parameters in URLs are prefixed by a colon, e.g. `/api/:username`.
- All API methods must include an example response body.
- All API methods that allow a request body should include an example body payload.
- All API methods that allow a request body must list available parameter names, if
  the parameter is optional, and an explanation of it’s effect.
- JSON data must be formatted with <http://jsonformatter.curiousconcept.com/>, at two
  space indentation.

### GET /description.xml

Appears to be a general description about the device. Presentation URL, as
well as icons, are reachable via GET requests.

```xml
<?xml version="1.0"?>
<root xmlns="urn:schemas-upnp-org:device-1-0">
  <specVersion>
    <major>1</major>
    <minor>0</minor>
  </specVersion>
  <URLBase>http://192.168.0.21:80/</URLBase>
  <device>
    <deviceType>urn:schemas-upnp-org:device:Basic:1</deviceType>
    <friendlyName>Philips hue (192.168.0.21)</friendlyName>
    <manufacturer>Royal Philips Electronics</manufacturer>
    <manufacturerURL>http://www.philips.com</manufacturerURL>
    <modelDescription>Philips hue Personal Wireless Lighting</modelDescription>
    <modelName>Philips hue bridge 2012</modelName>
    <modelNumber>1000000000000</modelNumber>
    <modelURL>http://www.meethue.com</modelURL>
    <serialNumber>93eadbeef13</serialNumber>
    <UDN>uuid:01234567-89ab-cdef-0123-456789abcdef</UDN>
    <serviceList>
      <service>
        <serviceType>(null)</serviceType>
        <serviceId>(null)</serviceId>
        <controlURL>(null)</controlURL>
        <eventSubURL>(null)</eventSubURL>
        <SCPDURL>(null)</SCPDURL>
      </service>
    </serviceList>
    <presentationURL>index.html</presentationURL>
    <iconList>
      <icon>
        <mimetype>image/png</mimetype>
        <height>48</height>
        <width>48</width>
        <depth>24</depth>
        <url>hue_logo_0.png</url>
      </icon>
      <icon>
        <mimetype>image/png</mimetype>
        <height>120</height>
        <width>120</width>
        <depth>24</depth>
        <url>hue_logo_3.png</url>
      </icon>
    </iconList>
  </device>
</root>
```

## POST /api

Register an application with the Hue hub. All API calls to the Hue hub require a
registered username as part of the URL.

After application registration, application details will be remembered by the Hub.
The Hub also keeps track of last access, as can be seen in GET [[/api/:username/config]],
part of the `whitelist` response property.

If you register multiple times, even if it is with the same parameters, the Hub will
register every successfull registration in the whitelist. You can delete registered
users from the whitelist with DELETE [[/api/:username/config/whitelist/:username]].

### Parameters

- username: numbers (0-9) and letters (a-z, A-Z), between 10 and 40 bytes in length (inclusive).
- devicetype: appears to accept any string, between 1 and 40 bytes in length (inclusive).

```json
{
  "username":"burgestrand",
  "devicetype":"any random thing"
}
```

### Responses

Failure. Given an invalid username (too short), and an empty devicetype. Error
type 7 is for invalid values, and the description contains a human readable
string of what is wrong.

```json
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
```

A successful initial post, given a username of `burgestrand` and device type of
`macbook`.  As you can see, an error of type 101 means that the user needs to
press the link button on the Hue hub, in order for it to allow new registrations.

```json
[
  {
    "error":{
      "type":101,
      "address":"",
      "description":"link button not pressed"
    }
  }
]
```

Same request as above example, but after the link button has been pressed. I am
currently unaware if there is a certain time this pairing needs to be done after
clicking the link button.

The username is used for subsequent API calls.

```json
[
  {
    "success":{
      "username":"burgestrand"
    }
  }
]
```

### GET /api/`username`

Username is the username you used for registering your application in `POST /api` call.
This API call will return a hash, containing information about hub configuration (same
as `GET /api/username/config`), the lights, groups (unsure of what it is about), and
schedules (commands to be executed at a given timestamp).

```json
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
    },
    "2":{
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
      "name":"TV Höger",
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
    },
    "3":{
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
      "name":"Skrivbord",
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
      },
      "9874172fdb7caf6f62cc9a935276229f":{
        "last use date":"2012-11-06T19:20:35",
        "create date":"2012-11-05T20:41:24",
        "name":"iPhone"
      },
      "burgestrand":{
        "last use date":"2012-11-06T21:57:59",
        "create date":"2012-11-06T21:29:57",
        "name":"macbook"
      },
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
      "name":"Frukost on f 012373           ",
      "description":" ",
      "command":{
        "address":"/api/24e04807fe143caeb52b4ccb305635f8/lights/3/state",
        "body":{
          "bri":1,
          "xy":[
            0.52594,
            0.43074
          ],
          "on":true
        },
        "method":"PUT"
      },
      "time":"2012-11-07T04:41:00"
    },
    "2":{
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
```

### GET /api/`username`/config

Retrieves Hue hub configuration information. Can also be retrieved from `GET /api/username`.

```json
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
```

### GET /api/`username`/lights/

Retrieves a list of lights paired with the Hue hub, and their names.

```json
{
  "1":{
    "name":"TV Vänster"
  },
  "2":{
    "name":"TV Höger"
  },
  "3":{
    "name":"Skrivbord"
  }
}
```

### GET /api/`username`/groups

Believed to return a list of groups. Most likely similar to the `/schedules` and `/lights` call;
returning an object of groups IDs and their names.

### GET /api/`username`/schedules

Retrieves a list of schedules and their names.

```json
{
  "1":{
    "name":"Frukost on f 423043           "
  },
  "2":{
    "name":"Frukost on 607775             "
  }
}
```

### PUT /api/`username`/config/

Update Hue configuration values. A list of values can be retrieved from `GET /api/username/config`.

#### Parameters

All parameters are optional. Only the parameters present will update values on the Hue.

- name: name of the Hue hub.

Acceptable example payload:

```json
{
  "name": "New name"
}
```

#### Responses

The response will, on success, contain a list of properties that were changed, together with their new values. Here’s
an example from changing the name.

```json
[
  {
    "success":{
      "/config/name":"Lumm"
    }
  }
]
```

### DELETE /api/`username`/config/whitelist/`username`

Removes a username from the whitelist of registered applications.

```json
[
  {
    "success":"/config/whitelist/burgestrand deleted"
  }
]
```

### PUT /api/`username`/lights/`light_number`/state

Change the state parameter of any of your lights.

#### Parameters

All parameters are optional.

- on: true if the light should be on, false if it should be off.

Acceptable example payload, turning the light off.

```json
{
  "on":false
}
```

#### Responses

```json
[
  {
    "success":{
      "/lights/1/state/on":false
    }
  }
]
```

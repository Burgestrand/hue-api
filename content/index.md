---
title: Hue API
---

# The Philips Hue API


## Current Version

    Accept: application/vnd.github.beta+json

The GitHub API version is currently in beta.  [The `beta` media type](/v3/media/)
property will be valid until sometime in 2013.  A notice will be given closer
to the actual date.

We consider the "beta" API unchangeable.  [File a support issue](https://github.com/contact)
if you have problems.

### Breaking Beta Changes

##### August 30, 2012
* Added `repo:status` scope
* Added Status API

##### August 7, 2012
* Clarified watching/stargazing

##### June 12, 2012:
* Removed API v1 support
* Removed API v2 support

##### June 15th, 2011:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the url.
* Creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:user/gists` is no
  longer supported.

##### June 1st, 2011:

* Removed support for PUT verb on update requests. Use POST or PATCH
  instead.
* Removed `.json` extension from all URLs.
* No longer using the X-Next or X-Last headers. Pagination info is
  returned in the Link header instead.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.

module.exports.url = require 'url'
module.exports.qstring = require 'querystring'

# 'querystring' seems to (almost) implement RFC 2396, which is
# Obsoleted by RFC 3986.
#
# i'm not convinced the result is good (not saying invalid).
#
# the following rant documents my path through the specs.
#
# RFC 3986 includes these productions in the BNF:
#
#   URI         = scheme ":" hier-part [ "?" query ] [ "#" fragment ]
#
#   reserved    = gen-delims / sub-delims
#
#   gen-delims  = ":" / "/" / "?" / "#" / "[" / "]" / "@"
#
#   sub-delims  = "!" / "$" / "&" / "'" / "(" / ")"
#                     / "*" / "+" / "," / ";" / "="
#
#   query       = *( pchar / "/" / "?" )
#
#   pchar       = unreserved / pct-encoded / sub-delims / ":" / "@"
#
# notice that `query` is *delimited* from `hier-part` by (the first)
# "?", and `query` can contain further occurrences of this character.
#
# `sub-delims` are clearly allowed in `query`, because they are,
# or can be, well, sub-delimiters:
#
#   The purpose of reserved characters is to provide a set of delimiting
#   characters that are distinguishable from other data within a URI.
#   URIs that differ in the replacement of a reserved character with its
#   corresponding percent-encoded octet are not equivalent.  Percent-
#   encoding a reserved character, or decoding a percent-encoded octet
#   that corresponds to a reserved character, will change how the URI is
#   interpreted by most applications.  Thus, characters in the reserved
#   set are protected from normalization and are therefore safe to be
#   used by scheme-specific and producer-specific algorithms for
#   delimiting data subcomponents within a URI.
#
#   [...]
#
#   URI producing applications should percent-encode data octets that
#   correspond to characters in the reserved set unless these characters
#   are specifically allowed by the URI scheme to represent data in that
#   component.  If a reserved character is found in a URI component and
#   no delimiting role is known for that character, then it must be
#   interpreted as representing the data octet corresponding to that
#   character's encoding in US-ASCII.
#
# querystring escapes all `sub-delims` except these: "!'()*", which,
# at least to me, means that their use as subdelimiters cannot be
# distinguished from their use as part of data.
# that is to say: it's obviously necessary to escape "#&=" in input
# keys and values, but i don't see same necessity with ":/?[]@$+,;".
#
# * "/" / "?" are terms in the `query` definition.
# * ":" / "@" are terms in the `pchar` definition.
# * "+" is ambiguous, but not toward the query syntax.
#
# the rest seems pretty unproblematic within the URL syntax.
# querystring should either percent-encode all `sub-delims` or only
# those that create actual ambiguities in the overall syntax.
#
# then again, RFC 3986 is not HTTP-specific, so maybe RFC 2616 tells
# more?
#
#   3.2.1 General Syntax
#
#   [...]
#
#   This specification adopts the definitions of "URI-reference",
#   "absoluteURI", "relativeURI", "port", "host","abs_path", "rel_path",
#   and "authority" from [rfc2396].
#
# and
#
#   3.2.2 http URL:
#
#   http_URL = "http:" "//" host [ ":" port ] [ abs_path [ "?" query ]]
#
# `query` is not defined anywhere in RFC 2616, but, URI-reference,
# absoluteURI and relativeURI in RFC 2396 are defined in terms of
# `query` among others, so it's safe to assume that RFC 2616 adopts
# the `query` definition from RFC 2396.
#
# RFC 2396
#
#     reserved    = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" |
#                   "$" | ","
#
#     unreserved  = alphanum | mark
#
#     mark        = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"
#
#     escaped     = "%" hex hex
#
#     uric        = reserved | unreserved | escaped
#
#     query       = *uric
#
#   Within a query component, the characters ";", "/", "?", ":", "@",
#   "&", "=", "+", ",", and "$" are reserved.
#
# [rfc2616] http://tools.ietf.org/html/rfc2616#section-3.2.2
# [rfc2396] http://tools.ietf.org/html/rfc2396

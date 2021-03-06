# Desirable Properties

<h2>Values</h2>

<h3 id=deterministic>Deterministic</h3>

- A given input always produces the same output
- Easily Cacheable
- Verifiable by multiple actors
- *e.g. Multiply or adding two integers*
- *e.g. Converting to lowercase or uppercase*
- *e.g. Concatenating strings*
- *e.g. Substring of another strings*
- *e.g. Removing duplicates from a list of items*
- *e.g. SHA256 hash digest (RFC 6234)*
- *e.g. Base64 encoding/decoding (RFC 4648)*
- *e.g. Gzip decoding (RFC 1952)*

```console
# Converting to lowercase
> echo "AbC" | tr "[:upper:]" "[:lower:]"
abc

# SHA256 hash digest
> echo "abc" | shasum -a 256
edeaaff3f1774ad2888673770c6d64097e391bc362d7d6fb34982ddf0efd18cb  -

# Base64 encoding
> echo "abc" | base64
YWJjCg==

# Base64 decoding
> echo "YWJjCg==" | base64 -d
abc

# Gzip decompressing
> echo "H4sIADFoHGAAA0tMSuYCAE6BiEcEAAAA" | base64 --decode | gzip --decompress
abc
```

<h3 id=unique>Unique</h3>

- Unique within a context or globally unique?
- Won’t clash with existing values
- *e.g. UUID (RFC 4122)*
- *e.g. SHA256 hash digest (RFC 6234)*
- Warning: could still be [guessable](#guessable): *e.g. Auto increment SQL primary key*

```console
# UUID
> uuidgen
5F36D0E2-F524-46B8-870B-9AA70128F8AF
```

<h3 id=random>Random</h3>

- Not [Guessable](#guessable)
- Should never clash with existing values
- *e.g. UUID v4*
- *e.g. Cryptographically Random source*

```console
> head -c16 /dev/urandom | base64
4mQ9EA==
```

<h3 id=guessable>Undesirable: Guessable</h3>

- Not Secure
- Not [Random](#random)
- *e.g. Auto incrementing SQL primary key*
- *e.g. The current time*

```console
> date -u '+%Y-%m-%dT%H:%M:%SZ'
2021-02-07T22:51:21Z
```

----

<h2>Acts</h2>

<h3 id=immutable>Immutable</h3>

- Changes to data work on a copy, preserving the original
- Benefits caching: *given I have an object’s ID, the contents will always be the same*
- Benefits syncing: *retrieve only the parts I do not yet have*
- *e.g. Twitter tweets cannot be edited, only deleted*
- *e.g. YouTube video media cannot be edited, only deleted*
- *e.g. Git object from a committed file*

<h3 id=stateless>Stateless</h3>

- Is [Deterministic](#deterministic)
- *e.g. Restful HTTP GET request*

<h3 id=idempotent>Idempotent</h3>

- The same effect is produced if run once, twice, or a thousand times
- *e.g. Consumer of an at-least-once event delivery system*
- *e.g. [Stripe charges](https://stripe.com/docs/api/idempotent_requests)*
- Hint: Could generate a [random](#random) identifier for each request, which allows recording which commands have already been processed.

<h3 id=versioned>Versioned</h3>

- Won't break previous usages
- *e.g. [Stripe’s API Versioning](https://stripe.com/blog/api-versioning)*

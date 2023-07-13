# vexed

**vexed** is a server for the [`nex:// protocol`](https://nex.nightfall.city/), with basic CGI support.

## But why?

As of me writing this, there is no other `nex://` server with CGI support. In fact, I believe there is no other `nex://` server out there other than [the reference implementation](https://hg.sr.ht/~m15o/nexd).

Also, this serves as an exercise to learn the [V programming language](https://vlang.io).

## Security considerations

Don't use this server if the CGI scripts you call may harm your system. **vexed** does *not* check whether the scripts it calls are secure, and does not have sandboxing capabilities builtin.

## Dependencies

**vexed** relies on being able to listen to port `1900` for incoming TCP connections.

There are no build time dependencies other than a functioning V build environment (V compiler, V standard library).

## Build

`v .`

The release binary was built using `v -prod -prealloc . && strip vexed`.

## Usage

`./vexed` runs the server with the current working directory as root directory. Note that this is not the root for CGI scripts.

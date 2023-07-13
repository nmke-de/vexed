module main

import net
import os

fn main() {
	// Environment variables for CGI
	os.setenv('GATEWAY_INTERFACE', 'CGI/1.1', true)
	os.setenv('REQUEST_METHOD', 'GET', true)
	os.setenv('SERVER_NAME', os.hostname() or { 'localhost' }, true)
	os.setenv('SERVER_PORT', '1900', true)
	os.setenv('SERVER_PROTOCOL', 'nex/1.0', true)
	os.setenv('SERVER_SOFTWARE', '1', true)

	mut listener := net.listen_tcp(net.AddrFamily.ip, ':1900') or {
		println('Failed to listen on Port 1900.')
		C.exit(1)
	}

	// Loop
	for {
		mut connection := listener.accept() or { continue }
		spawn serve(mut connection)
	}
}

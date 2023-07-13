module main

import net

fn main() {
	mut listener := net.listen_tcp(net.AddrFamily.ip, ':1900')!

	// Loop
	for {
		mut connection := listener.accept()!
		path := connection.read_line()
		connection.write_string('${path}\r\n')!
		connection.close()!
	}
}

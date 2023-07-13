module main

import net

fn serve(mut connection net.TcpConn) {
	path := connection.read_line()
	connection.write_string('${path}\r\n') or {}
	connection.close() or {}
}

module main

import net
import os

fn serve(mut connection net.TcpConn) {
	request := connection.read_line().all_before('\r\n')
	path := request.replace_each(['../', '/']).all_after('/').all_before('?')
	result := if path == '..' || path.ends_with('/..') || path == '' {
		ls(os.getwd())
	} else if os.is_dir(path) {
		ls(path)
	} else if os.is_executable(path) {
		cgi(connection, request, path)
	} else {
		cat(path)
	}
	connection.write_string(result) or {}
	connection.close() or {}
}

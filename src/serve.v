module main

import net
import os

fn serve(mut connection net.TcpConn) {
	request := connection.read_line().all_before('\r\n')
	path := request.replace_each(['../', '/']).all_after('/').all_before('?')

	// Environment variables for CGI
	os.setenv('QUERY_STRING', query_string(request), true)
	os.setenv('REMOTE_ADDR', (connection.addr() or {
		net.Addr{
			f: 0
		}
	}).str(), true)
	os.setenv('SCRIPT_NAME', '${os.hostname() or { 'localhost' }}/${path}', true)

	result := if path == '..' || path.ends_with('/..') || path == '' {
		ls(os.getwd())
	} else if os.is_dir(path) {
		ls(path)
	} else if os.is_executable(path) {
		cgi(path)
	} else {
		cat(path)
	}
	connection.write_string(result) or {}
	connection.close() or {}
}

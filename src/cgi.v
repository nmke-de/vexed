module main

import net
import os

fn cgi(connection &net.TcpConn, request string, path string) string {
	// TODO mitigate TOCTOU attack (https://github.com/vlang/v/blob/master/vlib/os/README.md)
	os.setenv('QUERY_STRING', query_string(request), true)
	os.setenv('REMOTE_ADDR', (connection.addr() or {
		net.Addr
		{
			f:
			0
		}
	}).str(), true)
	os.setenv('SCRIPT_NAME', '${os.hostname() or { 'localhost' }}/${path}', true)
	return os.execute('./${path}').output
}

module main

import net
import os

fn serve(mut connection net.TcpConn) {
	path := connection.read_line().all_before('\r\n').replace_each(['../', '/']).all_after('/')
	result := if path == '..' || path.ends_with('/..') || path == '' {
		ls(os.getwd())
	} else if os.is_dir(path) {
		ls(path)
	} else if os.is_executable(path) {
		// TODO mitigate TOCTOU attack (https://github.com/vlang/v/blob/master/vlib/os/README.md)
		os.execute('./${path}').output
	} else {
		cat(path)
	}
	connection.write_string(result) or {}
	connection.close() or {}
}

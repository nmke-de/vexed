module main

import net
import os

fn serve(mut connection net.TcpConn) {
	path := connection.read_line().all_before('\r\n').replace_each(['../', '/']).all_after('/')
	result := if path == '..' || path.ends_with('/..') || path == '' {
		ls(os.getwd())
	} else if os.is_dir(path) {
		ls('${os.getwd()}/${path}')
	} else {
		cat(path)
	}
	connection.write_string(result) or {}
	connection.close() or {}
}

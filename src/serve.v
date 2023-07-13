module main

import net
import os

fn serve(mut connection net.TcpConn) {
	path := connection.read_line().all_before('\r\n').all_after('/')
	result := if os.is_dir(path) {
		ls('${os.getwd()}/${path}')
	} else if path == '' {
		ls(os.getwd())
	} else {
		cat(path)
	}
	connection.write_string(result) or {}
	connection.close() or {}
}

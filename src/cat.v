module main

import io
import os

fn cat(filename string) string {
	if os.is_executable(filename) {
		return cgi(filename)
	}
	mut f := os.open(filename) or { return '' }
	defer {
		f.close()
	}
	result := io.read_all(reader: f) or { return '' }
	return result.bytestr()
}

module main

import os

fn cgi(path string) string {
	// TODO mitigate TOCTOU attack (https://github.com/vlang/v/blob/master/vlib/os/README.md)
	return os.execute('./${path}').output
}

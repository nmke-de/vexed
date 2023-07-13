module main

import os

fn ls(dir string) string {
	mut result := '${dir}\n\n'
	for file in os.ls(dir) or { []string{} } {
		result += '=> ${file}\n'
	}
	return result
}

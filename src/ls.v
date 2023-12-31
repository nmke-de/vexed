module main

import os

fn ls(dir string) string {
	dirname := if os.getwd() == dir {
		'/'
	} else {
		'${dir.all_after(os.getwd())}'
	}
	if os.exists('${dir}/index') {
		return cat('${dir}/index')
	}
	mut result := '${dirname}\n\n'
	for file in os.ls(dir) or { []string{} } {
		result += if os.is_dir('${dir}/${file}') {
			'=> ${file}/\n'
		} else {
			'=> ${file}\n'
		}
	}
	return result
}

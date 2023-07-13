module main

fn query_string(request string) string {
	if request.contains_any('?') {
		return request.all_after('?')
	}
	return ''
}

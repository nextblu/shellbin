import os
import json
import net.http

fn http_request(method, xdata string) string {
    xreq := http.Request{
		method: method
		headers: {
		'Content-Type': 'application/json'
		}
		cookies: map[string]string
		data: xdata
		url: "https://shellbin-api.nextblu.com/api/v1/bin/new"
		user_agent: ""
		verbose: false
		user_ptr: 0
		ws_func: 0
		}
		result := xreq.do() or {
			println("\x1B[31mThe server is offline or this client is outdated. Failed to create the bin.\033[0m\t\t")
			return "error"
		}
		return result.text.replace('"', "")
}

fn main() {
		// Reading data from the stdin
        mut data := os.get_lines()
		mut encoded_data := json.encode(data)
		// Sending data to the endpoint
		mut http_result := http_request("POST", encoded_data)
		if http_result != 'error' {
			println("\x1B[36m 🚀ShellBin\033[0m v0.0.1.")
			println("Here is your bin: https://shellbin.nextblu.com/$http_result")	
		}else{
			println('Please check the status at https://status.nextblu.com/')
		}
}
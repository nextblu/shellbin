import os
import json
import net.http


fn http_request(xdata string) string {
        xreq := http.Request{
                method: http.Method.post
                headers: {
                        'Content-Type': 'application/json'
                }
                cookies: map[string]string{}
                data: xdata
                url: 'https://shellbin-api.nextblu.com/api/v1/bin/new'
                user_agent: ''
                verbose: false
                user_ptr: 0
                ws_func: 0
        }
        result := xreq.do() or {
                println('\x1B[31mThe server is offline or this client is outdated. Failed to create the bin.\033[0m\t\t')
                return 'error'
        }
        return result.text.replace('"', '')
}

fn get_shellbin_lines() string {
	mut line := ''
	mut inputstr := ''
	$if windows {
		// The problem is that os.get_lines() stops reading the moment it sees a blank line
		// Unfortunately on windows, most output commands are seperated by a blank line
		// To handle this, we need to read more than one blank line in a sequence before we can conclude
		// that we are at the end of blank of whatever data needs to be read
		// from std_out
		// Here the number of times to break after seeing a non breaking sequence of blank lines chosen is 5
		// Hopefully, this gets fixed someday and we don't need this whole block
		max_blank_lines := 5
		mut blank_lines_count := 0
		for {
			line = get_raw_line()
			if line.len <= 0 {
				blank_lines_count++
				if blank_lines_count > max_blank_lines {
					break
				}
			} else {
				line = line.trim_space()
				inputstr += '\n'+line
				blank_lines_count = 0
			}
		}
	} $else {
		for {
			line = get_raw_line()
			if line.len <= 0 {
				break
			}
			line = line.trim_space()
			inputstr += '\n'+line
		}
		return inputstr
	}
}

fn main() {
        // array to hold data read from stdin
	mut data := get_shellbin_lines()
	mut encoded_data := json.encode(data)
	// Sending data to the endpoint
	mut http_result := http_request(encoded_data)
	if http_result != 'error' {
			$if windows{
			    println('\x1B[36m ShellBin\033[0m v1.0.6')
			    os.system('echo https://shellbin.nextblu.com/#/$http_result | clip')
			    println('Here is your bin: https://shellbin.nextblu.com/#/$http_result')
			    println('Your bin url was copied into your clipboard!')
			    }
			$else{
			    println('\x1B[36m ShellBin\033[0m v1.0.6')
			    println('Here is your bin: https://shellbin.nextblu.com/#/$http_result')
			    }
	} else {
			println('The server may be down. Please check the status at https://status.nextblu.com/')
	}
}

import net
import time
import os
import term

const (
	red = "\033[31m"
	green = "\033[32m"
)
fn main() {
	ip := os.args[1] or {
		eprintln("Invalid args! | ./tcp-ping <ip> <port> <count>")
		return
	}
	port := os.args[2] or {
		eprintln("Invalid args! | ./tcp-ping <ip> <port> <count>")
		return
	}
	count := os.args[3] or {
		eprintln("Invalid args! | ./tcp-ping <ip> <port> <count>")
		return
	}
	mut counter := 0
	mut failed := 0
	term.clear()
	print("Pinging ${ip}:${port}\n\n")
	for {
		counter += 1
		net.dial_tcp("${ip}:${port}") or {
		eprintln("${red}[Connection Timed Out ${ip}:${port}${green} Offline]")
			time.sleep(1 * time.second)
			failed += 1
			continue
		}
		print("${green}[Connected To ${ip}:${port} | Protocol TCP | Count ${counter} Online]\n")
		time.sleep(1 * time.second)
		if counter == count.int() {
			print("Stopping test | ${counter} count sent, ${failed} failed to connect!\n")
			return
		}
	}
}
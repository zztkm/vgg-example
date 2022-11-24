module main

import gx
import encoding.hex

fn main() {
	hc := hex.decode("ffa501") or {
		eprintln(err)
		return
	}

	c := gx.rgb(hc[0], hc[1], hc[2])
	println(c.r)
	println(c.g)
	println(c.b)
}

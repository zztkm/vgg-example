module main

struct Circle {
mut:
	x int
}

struct App {
mut:
	circles []Circle
}

fn main() {
	mut app := App{}
	for i in 0 .. 10 {
		app.circles << Circle{
			x: i
		}
	}

	for circle in app.circles {
		println(circle.x)
	}
}

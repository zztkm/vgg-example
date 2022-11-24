module main

import gg
import gx
import rand

const palette_url = "https://coolors.co/264653-2a9d8f-e9c46a-f4a261-e76f51"

struct Circle {
mut:
	init_x f32
	x f32
	y f32
	radius f32
}

struct App {
mut:
	ctx &gg.Context
	circle_num int
	circles []Circle
}

// [live]
fn (mut app App) init() {
	for _ in 0 .. app.circle_num {
		x := rand.f32_in_range(-400.0, 400.0) or {
			eprintln(err)
			exit(1)
		}
		println(x)
		radius := rand.f32_in_range(5.0, 20.0) or {
			eprintln(err)
			exit(1)
		}
		app.circles << Circle {
			init_x: x
			x: x
			y: 0.0
			radius: radius
		}
	}
}

// [live]
fn (mut app App) draw() {
    app.ctx.begin()
	for circle in app.circles {
		app.ctx.draw_circle_filled(circle.x, circle.y, circle.radius, gx.blue)
	}
    app.ctx.end()
	app.update()
}

// [live]
fn (mut app App) update() {
	for mut circle in app.circles {
		if circle.x <= 600.0 {
			circle.x = circle.x + 10.0
			circle.y = circle.y + 10.0
		} else {
			circle.x = circle.init_x
			circle.y  = 0.0
		}
	}
}

fn main() {
	mut app := App{
		ctx: 0
		circle_num: 100
	}
    app.ctx = gg.new_context(
        bg_color: gx.rgb(174, 198, 255)
        width: 600
        height: 600
        window_title: 'Many circle'
		init_fn: app.init
        frame_fn: app.draw
		user_data: &app
    )
    app.ctx.run()
}


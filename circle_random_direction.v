module main

import gg
import gx
import rand
import encoding.hex

const palette_url = 'https://coolors.co/264653-2a9d8f-e9c46a-f4a261-e76f51'

const (
	width  = 800.0
	height = 800.0
)

struct Circle {
mut:
	init_x f32
	init_y f32
	x      f32
	y      f32
	radius f32
	color  gx.Color
	speed  f32
	direction int
}

struct App {
mut:
	ctx        &gg.Context
	circle_num int
	circles    []Circle
}

// [live]
fn (mut app App) init() {
	// URLの中から16進数で表現されたカラーの配列を取得する
	palette := palette_url.split('/')#[-1..][0].split('-')
	println(palette)
	for i in 0 .. app.circle_num {
		x := rand.f32_in_range(-width, width) or {
			eprintln(err)
			exit(1)
		}
		y := rand.f32_in_range(-width, width) or {
			eprintln(err)
			exit(1)
		}
		radius := rand.f32_in_range(2.0, 15.0) or {
			eprintln(err)
			exit(1)
		}
		color_code := palette[i % palette.len]
		rgb := hex.decode(color_code) or {
			eprintln(err)
			exit(1)
		}
		speed := rand.f32_in_range(2.0, 7.0) or {
			eprintln(err)
			exit(1)
		}
		direction := i % 4
		color := gx.rgb(rgb[0], rgb[1], rgb[2])
		app.circles << Circle{
			init_x: x
			init_y: y
			x: x
			y: y
			radius: radius
			color: color
			speed: speed
			direction: direction
		}
	}
}

// [live]
fn (mut app App) draw() {
	app.ctx.begin()
	for circle in app.circles {
		app.ctx.draw_circle_filled(circle.x, circle.y, circle.radius, circle.color)
	}
	app.ctx.end()
	app.update()
}

// [live]
fn (mut app App) update() {
	for mut circle in app.circles {
		if circle.direction == 0 {
			if circle.x <= width {
				circle.x = circle.x + circle.speed
				circle.y = circle.y + circle.speed
			} else {
				circle.x = circle.init_x
				circle.y = 0.0
			}
		}
		if circle.direction == 1 {
			if 0.0 <= circle.x {
				circle.x = circle.x - circle.speed
				circle.y = circle.y - circle.speed
			} else {
				circle.x = circle.init_x
				circle.y = 0.0
			}
		}
		if circle.direction == 2 {
			if 0.0 <= circle.y {
				circle.x = circle.x + circle.speed
				circle.y = circle.y - circle.speed
			} else {
				circle.x = circle.init_x
				circle.y = circle.init_y
			}
		}
		if circle.direction == 3 {
			if circle.y <= height {
				circle.x = circle.x - circle.speed
				circle.y = circle.y + circle.speed
			} else {
				circle.x = circle.init_x
				circle.y = circle.init_y
			}
		}
	}
}

fn main() {
	mut app := App{
		ctx: 0
		circle_num: 150
	}
	app.ctx = gg.new_context(
		bg_color: gx.rgb(174, 198, 255)
		width: int(width)
		height: int(height)
		window_title: 'Many circle'
		init_fn: app.init
		frame_fn: app.draw
		user_data: &app
	)
	app.ctx.run()
}

module main

import gg
import gx

struct CircleState {
mut:
	ctx &gg.Context
	x f32
	y f32
}

fn (mut state CircleState) draw() {
	state.ctx.draw_circle_filled(state.x, state.y, 60.0, gx.blue)
	state.ctx.draw_circle_filled(600 - state.x, state.y, 60.0, gx.red)
}

fn (mut state CircleState) update() {
	if state.x <= 600.0 {
		state.x = state.x + 10.0
		state.y = state.y + 10.0
	} else {
		state.x = 0.0
		state.y  = 0.0
	}
}

[live]
fn frame(mut state CircleState) {
    state.ctx.begin()
	state.draw()
    state.ctx.end()
	state.update()
}

fn main() {
	mut state := CircleState{ctx: 0, x: 0.0, y: 0.0}
    state.ctx = gg.new_context(
        bg_color: gx.rgb(174, 198, 255)
        width: 600
        height: 600
        window_title: 'Polygons'
        frame_fn: frame
		user_data: &state
    )
    state.ctx.run()
}


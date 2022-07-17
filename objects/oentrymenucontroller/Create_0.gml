display_set_gui_size(room_width, room_height);
guiW = room_width
guiH = room_height
textColor = make_color_rgb(229,217,200)

centeredX = guiW/2
baseY = guiH/3
baseMenuButtonOffset = 100

if (!audio_is_playing(sndBluTrack))
{
	audio_play_sound(sndBluTrack,0,true)
	audio_play_sound(sndAmbience,0,true)
}
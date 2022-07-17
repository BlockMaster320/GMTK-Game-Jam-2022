menuState = MENU_STATE.main;

display_set_gui_size(room_width, room_height);

if (!audio_is_playing(sndBluTrack))
{
	audio_play_sound(sndBluTrack,0,true)
	audio_play_sound(sndAmbience,0,true)
}
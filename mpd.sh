echo "Enter mpd user..."
read -e user
echo "Enter music directory..."
read -e music_dir

sudo apt-get update && sudo apt-get install mpd mpc -y

mpdFiles=(mpd/tag_cache mpd.log pid state sticker.sql)
mpdFolders=(mpd/playlists mpd/music)

mkdir /home/$user/mpd

for mpdfile in "${mpdFiles[@]}"; do
  touch /home/$user/$mpdfile
done

for mpdfolder in "${mpdFolders[@]}"; do
  mkdir /home/$user/$mpdfolder
done

printf "music_directory		\"$music_dir\"
playlist_directory		\"/home/${user}/mpd/playlists\"
db_file			\"/home/${user}/mpd/tag_cache\"
log_file			\"/home/${user}/mpd/mpd.log\"
pid_file			\"/home/${user}/mpd/pid\"
state_file			\"/home/${user}/mpd/state\"
sticker_file                   \"//home/${user}//mpd/sticker.sql\"

user				\"${user}\"
bind_to_address		\"localhost\"

input {
        plugin \"curl\"
}

audio_output {
	type		\"alsa\"
	name		\"My ALSA Device\"
	device		\"hw:0,0\"	# optional
	format		\"44100:16:2\"	# optional
	mixer_device	\"default\"	# optional
	mixer_control	\"PCM\"		# optional
	mixer_index	\"0\"		# optional
}

filesystem_charset		\"UTF-8\"
id3v1_encoding			\"UTF-8\"" | sudo tee /etc/mpd.conf

echo "
All done!!"

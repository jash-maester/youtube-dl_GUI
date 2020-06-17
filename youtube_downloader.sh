#!/bin/sh
audio="";
playlist="";
dLocation='~/Music';
url=$(zenity --entry --width 500 --text "Enter video link" --title "Youtube Downloader" --entry-text="");

#Whether to download audio or not
zenity --question --width 500 --text "Download audio only?";
isAudio=$?;
if [ $isAudio -eq 0 ]
then
    audio=" -x --audio-quality 5 --audio-format mp3 "
fi

#Whether it's a playlist 
zenity --question --width 500 --text "Is this a playlist?";
isPlaylist=$?;
if [ $isPlaylist -eq 0 ]
then
    playlist="--yes-playlist"
fi

#Whether you want to change default save location
zenity --question --width 500 --text "Default save location: ~/Music . Do you want to change it?";
isLocationChange=$?;
if [ $isLocationChange -eq 0 ]
then
    dLocation=$(zenity --file-selection --confirm-overwrite --title="Choose a directory" --directory);
fi

printf "Downloading: %s \n" "$url"
printf "File will be downloaded in: %s\n" "$dLocation"

youtube-dl $url $playlist $audio -o $dLocation/'%(title)s.%(ext)s' --newline

echo "Download Complete..."

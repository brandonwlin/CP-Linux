#!/bin/bash

# https://en.wikipedia.org/wiki/Video_file_format
UNAUTH_VIDEO_FILE_EXTENTIONS_REGEX="\.webm$|\.mkv$|\.flv$|\.flv$|\.vob$|\.ogv$|\.ogg$|\.drc$|\.gif$|\.gifv$|\.mng$|\.avi$|\.MTS$|\.M2TS$|\.TS$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|\.viv$|\.asf$|\.amv$|\.mp4$|\.m4p$|\.m4v$|\.mpg$|\.mp2$|\.mpeg$|\.mpe$|\.mpv$|\.mpg$|\.mpeg$|\.m2v$|\.m4v$|\.svi$|\.3gp$|\.3g2$|\.mxf$|\.roq$|\.nsv$|\.flv $|\.f4v $|\.f4p $|\.f4a $|\.f4b$"
# https://en.wikipedia.org/wiki/Audio_file_format
UNAUTH_AUDIO_FILE_EXTENTIONS_REGEX="\.3gp$|\.aa$|\.aac$|\.aax$|\.act$|\.aiff$|\.alac$|\.amr$|\.ape$|\.au$|\.awb$|\.dss$|\.dvf$|\.flac$|\.gsm$|\.iklax$|\.ivs$|\.m4a$|\.m4b$|\.m4p$|\.mmf$|\.movpkg$|\.mp3$|\.mpc$|\.msv$|\.nmf$|\.ogg$|\.oga$|\.mogg$|\.opus$|\.ra$|\.rm$|\.raw$|\.rf64$|\.sln$|\.tta$|\.voc$|\.vox$|\.wav$|\.wma$|\.wv$|\.webm$|\.8svx$|\.cda$"

echo "Checking for UNAUTH_VIDEO_FILE_EXTENTIONS"
sudo find / -type f 2>/dev/null | grep -E "$UNAUTH_VIDEO_FILE_EXTENTIONS_REGEX"

echo "Checking for UNAUTH_AUDIO_FILE_EXTENTIONS_REGEX"
sudo find / -type f 2>/dev/null | grep -E "$UNAUTH_AUDIO_FILE_EXTENTIONS_REGEX"


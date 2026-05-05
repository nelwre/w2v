#!/usr/bin/env bash

usage() {
    echo "Usage: ./wav2mov.sh [--bg black|image.png|anim.gif] [--fmt mov|mkv] filename.wav"
    echo ""
    echo "  --bg    black (default), path to image, or animated gif"
    echo "  --fmt   mov (default) or mkv"
    exit 1
}

BG="black"
FMT="mov"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --bg)  BG="$2";  shift 2 ;;
        --fmt) FMT="$2"; shift 2 ;;
        -h|--help) usage ;;
        *) WAV="$1"; shift ;;
    esac
done

[ -z "$WAV" ]         && usage
[ ! -f "$WAV" ]       && echo "File not found: $WAV" && exit 1
[[ "$WAV" != *.wav ]] && echo "Expected a .wav file" && exit 1

base="${WAV%.wav}"

# — output codec —
if [ "$FMT" = "mkv" ]; then
    OUT="${base}.mkv"
    ACODEC="-c:a flac"
    VCODEC="-c:v libx264 -tune stillimage -pix_fmt yuv420p"
else
    OUT="${base}.mov"
    ACODEC="-c:a pcm_s16le"
    VCODEC="-c:v libx264 -tune stillimage -pix_fmt yuv420p"
fi

# — video source —
if [ "$BG" = "black" ]; then
    VIDEO_INPUT="-f lavfi -i color=c=black:s=1280x720:r=30"
    EXTRA_FLAGS=""

elif [[ "$BG" == *.gif ]]; then
    [ ! -f "$BG" ] && echo "GIF not found: $BG" && exit 1
    VIDEO_INPUT="-stream_loop -1 -i \"$BG\""
    # animated gif: force stable framerate and loop until audio ends
    EXTRA_FLAGS="-vf scale=1280:720:flags=lanczos,fps=30"

else
    # static image (png, jpg, etc)
    [ ! -f "$BG" ] && echo "Image not found: $BG" && exit 1
    VIDEO_INPUT="-loop 1 -i \"$BG\""
    EXTRA_FLAGS="-vf scale=1280:720:flags=lanczos"
fi

echo "Processing: $OUT"

eval ffmpeg $VIDEO_INPUT \
       -i "$WAV" \
       -shortest \
       $VCODEC \
       $EXTRA_FLAGS \
       $ACODEC \
       "$OUT"

echo "Done: $OUT"

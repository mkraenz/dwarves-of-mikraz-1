# TODO fail pipeline on error of any command

rm -r .build && mkdir .build
/home/mirco/programming/gamedev/godot4/Godot_v4.1.2-stable_linux.x86_64 --export-release Web .build/index.html
/home/mirco/programming/gamedev/itchio-butler/butler push .build mkraenz/dwarves-of-mikraz:web

echo 'Deployed successfully. Check itch.io at https://mkraenz.itch.io/dwarves-of-mikraz'
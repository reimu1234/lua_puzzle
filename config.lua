-- Game configuration settings

game_config = {
    screen_size = {
        width = 800,
        height = 600,
    },
    piece_count_limits = {
        min = 3,
        max = 100,
    },
    snap_distance = 10,
    file_paths = {
        images = "assets/images/",
        audio = "assets/audio/",
        levels = "assets/levels/",
    }
}

return game_config
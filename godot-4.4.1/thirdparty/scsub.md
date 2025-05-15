```py
# godot-4.4.1\scene\resources\SCsub
thirdparty_dir = "#thirdparty/misc/"
thirdparty_sources = [
    "mikktspace.c",
    "qoa.c",
]

# default_font.gen.h 文件的生成依赖于 OpenSans_SemiBold.woff2 文件
# godot-4.4.1\scene\theme\SCsub
env.Depends("#scene/theme/default_font.gen.h", "#thirdparty/fonts/OpenSans_SemiBold.woff2")
env.CommandNoCache(
    "#scene/theme/default_font.gen.h",
    "#thirdparty/fonts/OpenSans_SemiBold.woff2",
    env.Run(default_theme_builders.make_fonts_header),
)

```

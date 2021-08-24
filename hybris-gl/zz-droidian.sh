#!/bin/sh

export EGL_PLATFORM=wayland
export COGL_DISABLE_MAPBUFFERRANGE=true

# Force gles on gdk
export GDK_GL=gles

// Copyright 2023 Eugenio "g7" Paolantonio <me@medesimo.eu>
// SPDX-License-Identifier: MPL-2.0

// Since firefox-esr 115, webrender is enabled automatically when
// supported. Leave this one commented here for reference
//pref('gfx.webrender.all', true);

// Disable allow-partial-present-buffer-age
pref('gfx.webrender.allow-partial-present-buffer-age', false);

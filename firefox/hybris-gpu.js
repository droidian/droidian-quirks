// Copyright 2024 Bardia Moshiri <fakeshell@bardia.tech>
// SPDX-License-Identifier: MPL-2.0

// This option will break firefox esr 115 on devices with a Mali gpu
// on other devices it doesn't do anything anyways firefox is not gpu accelerated
pref("layers.acceleration.disabled", true);

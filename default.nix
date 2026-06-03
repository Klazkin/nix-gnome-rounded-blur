{ fetchFromGitHub, gobject-introspection, lib, meson, glib, stdenv, mutter
, pkg-config, cmake, cairo, gsettings-desktop-schemas, wayland, libGL, libxfixes
, libxi, atk, ninja }:

stdenv.mkDerivation {
  pname = "gnome-rounded-blur";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "kancko";
    repo = "gnome-rounded-blur";
    tag = "v1.0.1";
    hash = "sha256-hiWQaYydlyIMHKsx49f7sGOLM9ev1g1kdlloUszZU8I=";
    fetchSubmodules = false;
  };

  patches = [ ];

  nativeBuildInputs = [ meson pkg-config cmake gobject-introspection ];

  buildInputs = [
    mutter
    glib
    cairo
    gsettings-desktop-schemas
    wayland
    libGL
    libxfixes
    libxi
    ninja
    atk
  ] ++ (mutter.buildInputs or [ ]) ++ (mutter.propagatedBuildInputs or [ ]);

  meta = with lib; {
    description =
      "A standalone library providing Blur.BlurEffect with corner radius support for GNOME Shell extensions.";
    homepage = "https://github.com/kancko/gnome-rounded-blur";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}

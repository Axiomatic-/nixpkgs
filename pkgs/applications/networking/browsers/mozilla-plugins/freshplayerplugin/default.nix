{ stdenv
, ragel
, pkgconfig
, pcre
, pango
, openssl
, mesa
, libvdpau
, libva
, libv4l
, libpulseaudio
, libpthreadstubs
, libevent
, libdrm
, libXrender
, libXrandr
, libXdmcp
, libXcursor
, gtk2
, glib
, ffmpeg
, fetchFromGitHub
, cmake
, chromium
, alsaLib }:

stdenv.mkDerivation rec {
  name = "freshplayerplugin-${version}";
  version = "0.3.5";
  src = fetchFromGitHub {
    owner = "i-rinat";
    repo = "freshplayerplugin";
    rev = "v${version}";
    sha256 = "0a4nzxbq89h5zbsiqj3vxbiir4sp4d5jmzan9fhfpbvlcqi57h87";
  };

  preConfigure = ''
    sed -ie 's#/opt/google/chrome/PepperFlash#'${chromium.plugins.flash}/lib/'#g' src/config_pepperflash.c
  '';

  installPhase = ''
    mkdir -p "$out/lib/mozilla/plugins" 
    cp libfreshwrapper-flashplayer.so "$out/lib/mozilla/plugins"
  '';

  nativeBuildInputs = [ cmake pkgconfig];

  buildInputs = [
    alsaLib chromium ffmpeg glib gtk2 libXcursor libXdmcp libXrandr libXrender libdrm libevent libpthreadstubs libpulseaudio libv4l libva libvdpau mesa openssl pango pcre ragel
  ];

  meta = with stdenv.lib; {
    description = "ppapi2npapi wrapper for flashplayer.";
    homepage = "https://github.com/i-rinat/freshplayerplugin";
    license = licenses.mit;
    platforms = platforms.linux;
};
}

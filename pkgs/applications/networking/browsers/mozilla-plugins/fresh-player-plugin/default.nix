{ stdenv, 
fetchFromGitHub, 
alsaLib,
cmake,
openssl,
pango,
pkgconfig,
ragel,
glib,
libevent,
gtk2,
libXrandr,
libXrender,
libXcursor,
libv4l,
ffmpeg,
libva,
libvdpau,
libdrm,
libpulseaudio,
mesa }:

stdenv.mkDerivation rec {
  name = "freshplayerplugin-${version}";
  version = "0.3.3";
  src = fetchFromGitHub {
    owner = "i-rinat";
    repo = "freshplayerplugin";
    rev = "v${version}";
    sha256 = "029rhv9q7bn21fn9q0gcqcv8ambk67x0f8k7knp54khbd8fazpmm";
  };

  buildPhase = ''
#    "cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .."
    "make"
  '';

  installPhase = ''
    mkdir -p "$out/lib/mozilla/plugins"
    cp libfreshwrapper-flashplayer.so "$out/lib/mozilla/plugins"
    
    mkdir -p "$out/share/${name}/plugin"
    ln -s "$out/lib/mozilla/plugins/libfreshwrapper-flashplayer.so" "$out/share/${name}/plugin"
  '';

  buildInputs = [
    alsaLib cmake openssl pango pkgconfig ragel glib libevent gtk2 libXrandr libXrender libXcursor libv4l ffmpeg libva libvdpau libdrm libpulseaudio mesa
  ];

  meta = with stdenv.lib; {
    description = "ppapi2npapi wrapper for flashplayer.";
    homepage = "https://github.com/i-rinat/freshplayerplugin";
    license = licenses.mit;
    platforms = platforms.linux;
};
}

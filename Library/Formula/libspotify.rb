require 'formula'

class Libspotify <Formula
  url 'http://developer.spotify.com/download/libspotify/libspotify-0.0.6-Darwin.zip'
  version '0.0.6'
  homepage 'http://developer.spotify.com/en/libspotify/overview/'
  md5 'c4bbddf8a4e5e2ba3127728212228622'

  def install
    prefix.install 'share'
    (include+'libspotify').install "libspotify.framework/Versions/#{version}/Headers/api.h"
    lib.install "libspotify.framework/Versions/#{version}/libspotify" => 'libspotify.0.0.6.dylib'
    doc.install Dir['doc/*']

    cd lib
    ln_s "libspotify.0.0.6.dylib", "libspotify.dylib"

    system "install_name_tool", "-id",
           "#{HOMEBREW_PREFIX}/lib/libspotify.#{version}.dylib",
           "libspotify.dylib"

    (lib+'pkgconfig/libspotify.pc').write pc_content
  end

  def pc_content; <<-EOS.undent
    prefix=#{HOMEBREW_PREFIX}
    exec_prefix=${prefix}
    libdir=${exec_prefix}/lib
    includedir=${prefix}/include

    Name: libspotify
    Description: Spotify client library
    Version: #{version}
    Libs: -L${libdir} -lspotify
    Cflags: -I${includedir}
    EOS
  end
end

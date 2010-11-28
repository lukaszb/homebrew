require 'formula'

class IkeScan <Formula
  url 'http://www.nta-monitor.com/tools/ike-scan/download/ike-scan-1.9.tar.gz'
  homepage 'http://www.nta-monitor.com/tools/ike-scan/'
  md5 'bed63c7d2f54c482525a735be7b5e720'

  def install
    system "./configure", "--with-openssl", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--mandir=#{man}"
    system "make install"
  end
end

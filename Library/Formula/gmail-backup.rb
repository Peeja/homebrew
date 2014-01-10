require 'formula'

class GmailBackup < Formula
  homepage 'http://www.gmail-backup.com/'
  url 'http://gmail-backup-com.googlecode.com/svn/tags/20110307'
  head 'http://gmail-backup-com.googlecode.com/svn/trunk'

  def install
    libexec.install Dir["*"]

    # bin.write_exec_script won't cut it here, because gmail-backup has to be
    # run from within its install directory.

    exec_script = bin/'gmail-backup'

    exec_script.write <<-EOS.undent
      #!/bin/bash
      PYTHONPATH="#{libexec}:$PYTHONPATH" exec python #{libexec/'gmail-backup.py'} "$@"
    EOS
  end

  def test
    system "#{bin}/gmail-backup", "--help"
  end
end

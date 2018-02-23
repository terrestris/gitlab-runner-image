Gitlab runner image
===================

A basic docker image with preinstalled SenchaCmd, maven, nodejs and
chrome/chromium for headless testing.

The images are tagged with the SenchaCmd version.

Everything except the SenchaCmd is installed via apt (and thus
available in the standard $PATH). SenchaCmd is installed in
`/root/bin/Sencha/Cmd/$SENCHA_CMD_VERSION/sencha`.

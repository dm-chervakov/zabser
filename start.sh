#!/bin/bash
# ---------------------------------------------------------------------------------
# Mount point Apache2 
# ---------------------------------------------------------------------------------

/etc/init.d/mysql start

source /etc/apache2/envvars
/usr/sbin/apache2 -DFOREGROUND


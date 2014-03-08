# MacPorts Installer addition on 2012-09-24_at_19:23:05:
#   adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:$PATH

# added for brew
export PATH=/usr/local/bin:$PATH


#python installed from ports
# now set as default using :   sudo port select --set python python27
#alias pythonPorts='/opt/local/bin/python2.7'
#alias pipPorts='/opt/local/bin/pip-2.7'
# set a symbolic link to /opt/local/sbin as pip

alias startMysql='cd /opt/local ; /opt/local/lib/mysql5/bin/mysqld_safe &'



if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

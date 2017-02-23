#!/bin/bash                                                                                         
#export JAVA_HOME=~/jdk1.7.0_75/; export ANT_HOME=~/apache-ant-1.9.4/; ~/apache-ant-1.9.4/bin/ant --execdebug
                                                                                                    
git clean -xfd

unset JAVA_TOOL_OPTIONS                                                                             
export LANG="en_US.UTF-8"                                                                           
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF8"                                                     
export ANT_OPTS="-Xms4G -Xmx4G"                                                                     
export ANT_HOME=~/apache-ant-1.9.4/; ~/apache-ant-1.9.4/bin/ant --execdebug

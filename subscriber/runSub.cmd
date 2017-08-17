@ECHO OFF
REM ###########################################################################
REM #        (c) Copyright, Real-Time Innovations, All rights reserved.       #
REM #                                                                         #
REM #        Permission to modify and use for internal purposes granted.      #
REM # This software is provided "as is", without warranty, express or implied #
REM #                                                                         #
REM ###########################################################################


REM If Java compiler is not in your search path, set it here:
REM SET JAVA="C:\Program Files\Java\jdk1.6.0_10"


REM Make sure NDDSHOME is set correctly
IF NOT DEFINED NDDSHOME (
    ECHO "NDDSHOME environment variable is not set"
    GOTO ENDSCRIPT
)
IF NOT DEFINED RTI_OPENSSLHOME (
    ECHO "RTI_OPENSSLHOME environment variable is not set"
    GOTO ENDSCRIPT
)
IF NOT DEFINED RTI_EXAMPLE_ARCH (
    ECHO "RTI_EXAMPLE_ARCH environment variable is not set"
    GOTO ENDSCRIPT
)

set Path=%NDDSHOME%\lib\;%RTI_OPENSSLHOME%\%RTI_EXAMPLE_ARCH%\release\bin;%Path%

REM Make sure java is in the search path
FOR %%F IN (java.exe) DO IF NOT EXIST %%~$PATH:F (
    ECHO Error: java.exe not found in current search path.
    ECHO Make sure that JRE is correctly installed and that you have
    ECHO java.exe in your search path.
    GOTO ENDSCRIPT
)

REM Ensure the software has been built
IF NOT EXIST objs (
    ECHO Binary directory not found. Did you build the application?
    GOTO ENDSCRIPT
)

java -classpath objs;"%NDDSHOME%"\lib\java\nddsjava.jar HelloWorldSubscriber %1 %2 %3 %4 %5 %6


:ENDSCRIPT:

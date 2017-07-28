=====================================================
RTI Connext (formerly, RTI Data Distribution Service)
Hello_security Example Application
=====================================================

Welcome to Connext.


Compiling this Example
----------------------
You must set the environment variable NDDSHOME to your RTI Connext
installation directory.

Before compiling, make sure that the desired version of javac compiler
is in your PATH environment variable.

To build this example on a Windows system, type the following in a 
command shell:

  > build

To build this example on a UNIX-based system, type the following in a 
command shell:

  > ./build.sh

To remove all the generated files (.class files), just delete the 'objs'
directory. 

On UNIX-based systems:
  > rm -Rf objs

On Windows systems:
  > RD /S /Q OBJS


Running this Example
--------------------
You must set the environment variable NDDSHOME to your RTI Connext installation
directory. You must also set RTI_EXAMPLE_ARCH to <architecture> 
(e.g., x64Linux2.6gcc4.4.5).

To run this example on a Windows system, you must set RTI_OPENSSLHOME to your
OpenSSL installation_directory then type the following in two different
command shells, either on the same machine  or on different machines:

  > runSub
  > runPub

To run this example on a UNIX-based system, you must set RTI_OPENSSLHOME to
your OpenSSL installation_directory then type the following in two different
command shells, either on the same machine or on different machines:

  > ./runSub.sh
  > ./runPub.sh

Accepted parameters
-------------------
This example takes 3 parameters.  The first two are the same as hello_world
and other examples; the domain ID and number of samples.  The third parameter
allows you to specify the encryption algorithm.  This example uses ECDSA-ECDH
by default.  To run this example using DSA-DH or RSA-ECDH, add the
command-line argument "dsa" or "rsa", respectively following the domain ID
and number of samles.  e.g. "0 0 dsa"


Troubleshooting this Example
============================
If you see the following error:

Cryptography_encrypt:error:0607B083:lib(6):func(123):reason(131)

you are likely linking against an older version of OpenSSL. You need version
1.0.1c or later.

If you see the following error:

Authentication_get_certificate:failed to verify certificate

your certificates have likely expired. You need to regenerate the peer{1,2,3}.pem 
or peer{1,2,3}dsa.pem files following the instructions in the "RTI Security
Plugins Getting Started Guide".

For more information, please consult the "RTI Security Plugins Getting Started
Guide".

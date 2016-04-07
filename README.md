# BUILD ESP8266
This is the source code to build MicroPython for the ESP8266 on a Raspberry Pi

## References

[1] http://forum.micropython.org/viewforum.php?f=16
    The MicroPython ESP8266 Forum

[2] https://github.com/pfalcon/esp-open-sdk
    The eps-open-sdk  (required to build for ESP8266)

[3] https://github.com/micropython
    The MicroPython source


## License
The MIT License (MIT)

Copyright (c) 2016, gojimmypi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


Other stuff referenced:

esp-open-sdk is in its nature merely a makefile, and is in public domain. However, the toolchain this makefile builds consists of many components, each having its own license. You should study and abide them all.

Quick summary: gcc is under GPL, which means that if you're distributing a toolchain binary you must be ready to provide complete toolchain sources on the first request.

Since version 1.1.0, vendor SDK comes under modified MIT license. Newlib, used as C library comes with variety of BSD-like licenses. libgcc, compiler support library, comes with a linking exception. All the above means that for applications compiled with this toolchain, there are no specific requirements regarding source availability of the application or toolchain. (In other words, you can use it to build closed-source applications). (There're however standard attribution requirements - see licences for details).


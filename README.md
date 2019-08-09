# fsdocker-clang-libfuzzer-jenkins

This is a Dockerfile to setup a Jenkins slave environment for building and fuzzing the Firestorm viewer post Alex-Ivy.

If you don't know what this is, this isn't for you.

## Getting Started

This image is hosted on the Docker hub, so simply run:

```
docker pull udidifier/fsdocker:clang-libfuzzer
```

Use the -v flag with docker run to bind mount your build directory into your container, like this:

```
docker run -v $(pwd):/opt/build udidifier/fsdocker:clang-libfuzzer
```

This will bind your current directory to /opt/build in your container.
Autobuild expects AUTOBUILD_VARIABLES_FILE to point to a variables file, you can define it at container launch with the -e flag.

```
Example
```

```
docker run -v $(pwd):/opt/build -w /opt/build/ -e AUTOBUILD_VARIABLES_FILE=/opt/build/variables udidifier/fsdocker:clang-libfuzzer autobuild configure -A 64 -c ReleaseFS_open -- --chan "MyViewer" -DFMODEX:BOOL=ON -DUSE_AVX2_OPTIMIZATION:BOOL=ON -DUSE_KDU=FALSE -DFMODSTUDIO:BOOL=OFF
```

You can also wrap your autobuild invocation into a neat script for a cleaner command line.    

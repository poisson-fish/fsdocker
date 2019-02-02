# fsdocker

This is a simple Dockerfile to setup a containerized build environment for building the Firestorm viewer post Alex-Ivy. This can make it easier to encorporate the build chain into custom IDE environments or whatever, since you don't need a chroot running as root. Who uses LXC anyway?

## Getting Started

This image is hosted on the Docker hub, so simply run:

```
docker pull udidifier/fsdocker
```

Use the -v flag with docker run to bind mount your build directory into your container, like this:

```
docker run -v $(pwd):/opt/build fsdocker
```

This will bind your current directory to /opt/build in your container.
Autobuild expects AUTOBUILD_VARIABLES_FILE to point to a variables file, you can define it at container launch with the -e flag.

```
Example
```

```
docker run -v $(pwd):/opt/build -w /opt/build/ -e AUTOBUILD_VARIABLES_FILE=/opt/build/variables fsdocker autobuild configure -A 64 -c ReleaseFS_open -- --chan "MyViewer" -DFMODEX:BOOL=ON -DUSE_AVX2_OPTIMIZATION:BOOL=ON -DUSE_KDU=FALSE -DFMODSTUDIO:BOOL=OFF
```

You can also wrap your autobuild invocation into a neat script for a cleaner command line.    

# nonfree_opencv_android
This repo talks about how to use Nonfree module of OpenCV (SURF and SIFT) with Android JNI and NDK. This tutorial will show you a quick way to build your nonfree module (SIFT and SURF) in OpenCV for Android NDK project. You can follow this tutorial to set up your own project.

development environment is set up as follows:
```
- macOS Catalina
- Android ndk 16.1.4479499
- OpenCV-2.4.11-android-sdk
```

## How to build?
We will first build libnonfree.so, and then show how to use it to build an Android native application.

### Step 1: create project, prepare files needed.


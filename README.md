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
資料夾會有以下內容。其中 `OpenCV-2.4.11-android-sdk` 可以從 OpenCV [官網](https://opencv.org/releases/)下載。至於為何要下載舊版 SDK 由於舊版 OpenCV 在早期 SIFT 和 SURF 因專利專系並未釋出，必須透過 nonffree 來存取。但是在 2020 SIFT 的專利已過期，使得 OpenCV 4.4.0 釋出 SIFT演算法並已移至主儲存庫的資料夾中。

```
.
├── OpenCV-2.4.11-android-sdk
├── README.md
└── jni
   ├── Android.mk
   ├── Application.mk
   ├── nonfree_init.cpp
   ├── precomp.hpp
   ├── sift.cpp
   └── surf.cpp
```

剛有提到因專利法關係在 OpenCV 4.4.0 之前版本是無法直接使用 SIFT 和 SURF 類的演算法。因此這裏採用 `OpenCV-2.4.11` 示範。如果是自己另外從官網下載的SDK，必須要在 `OpenCV-2.4.11-android-sdk\sdk\native\jni\include\opencv2\` 中加入 `nonfree` 資料夾，並加上 `features2d.hpp`、`nonfree.hpp`這兩隻檔案。在這 repo 中我已經幫大家[上傳](https://github.com/andy6804tw/nonfree_opencv_android/tree/main/OpenCV-2.4.11-android-sdk/sdk/native/jni/include/opencv2/nonfree)好了(也是這個repo肥大的幫兇)。

## Step 2: Create jni folder
在主目錄下新增 `jni` 資料夾。並新增 `nonfree_init.cpp, precomp.hpp, sift.cpp, surf.cpp`。

## Step 3: build libnonfree.so
建立 `Android.mk` 和 `Application.mk`

```
# Application.mk
APP_ABI := armeabi-v7a x86
APP_STL := gnustl_static
APP_CPPFLAGS := -frtti -fexceptions
APP_PLATFORM := android-15
```

```
# Android.mk
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
OPENCV_INSTALL_MODULES:=on
OPENCV_CAMERA_MODULES:=off
include ./OpenCV-2.4.11-android-sdk/sdk/native/jni/OpenCV.mk

LOCAL_C_INCLUDES:= ./OpenCV-2.4.11-android-sdk/sdk/native/jni/include
LOCAL_MODULE    := nonfree
LOCAL_CFLAGS    := -Werror -O3 -ffast-math
LOCAL_LDLIBS    += -llog
LOCAL_SRC_FILES := nonfree_init.cpp sift.cpp surf.cpp
include $(BUILD_SHARED_LIBRARY)
```
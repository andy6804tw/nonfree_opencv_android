LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
OPENCV_INSTALL_MODULES:=on
OPENCV_CAMERA_MODULES:=off
include /Users/yilintsai/Desktop/OpenCV-android-sdk/sdk/native/jni/OpenCV.mk

LOCAL_C_INCLUDES:= /Users/yilintsai/Desktop/OpenCV-android-sdk/sdk/native/jni/include
LOCAL_MODULE    := nonfree
LOCAL_CFLAGS    := -Werror -O3 -ffast-math
LOCAL_LDLIBS    += -llog
LOCAL_SRC_FILES := nonfree_init.cpp \
 sift.cpp \
 surf.cpp
include $(BUILD_SHARED_LIBRARY)
#
# Nicholas Yue nicholas_yue@users.sourceforge.net
#
# Note:
# (1) A dummy file include/config.h is required (remance from configure)
# (2) Default installation directory is /usr/local, override with -DCMAKE_INSTALL_PREFIX="" during cmake
#     invocation
# (3) Do the usual "make clean all" to build the library
# (4) To install either "make install" or "make install DESTDIR=<your directory>"
# (5) Need to include changes in include/log4cpp/Portability.hh for OSX to build
cmake_minimum_required(VERSION 3.0)
PROJECT ( LOG4CPP )

INCLUDE_DIRECTORIES ( include )
INCLUDE_DIRECTORIES ( . )

IF (WIN32)
  ADD_DEFINITIONS ( -D_CRT_SECURE_NO_WARNINGS )
ELSE (WIN32)
  IF (APPLE)
    message("handle for apple")
    ADD_DEFINITIONS ( -DNDEBUG -DLOG4CPP_HAVE_SSTREAM )
  ELSE (APPLE)
    ADD_DEFINITIONS ( -pthread -DNDEBUG -DLOG4CPP_HAVE_SSTREAM )
  ENDIF (APPLE)
ENDIF (WIN32)

IF ( CMAKE_BUILD_TYPE MATCHES "Debug" )
  SET ( LOG4CPP_LIBRARY_NAME "log4cppD" )
ELSE ( CMAKE_BUILD_TYPE MATCHES "Debug" )
  SET ( LOG4CPP_LIBRARY_NAME "log4cpp" )
ENDIF ( CMAKE_BUILD_TYPE MATCHES "Debug" )

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


IF(ANDROID)
  message("handle for android")
  SET(CMAKE_CXX_FLAGS "-fexceptions  -std=c++11   ${CMAKE_CXX_FLAGS} ")
  # set(prebuilt_stdcxx_PATH /Users/lihaifeng/.ndk/sources/cxx-stl/stlport/libs/armeabi)
  # include_directories(${prebuilt_stdcxx_PATH}/include
  # ${prebuilt_stdcxx_PATH}/libs/armeabi/include)
  #include_directories(${ANDROID_NDK}/sources/cxx-stl/stlport/stlport)
  #message(android_ndk:${ANDROID_NDK})
  #LINK_DIRECTORIES(${ANDROID_NDK}/sources/cxx-stl/stlport/libs/${ANDROID_ABI})
elseif(IOS)
  message("handle for ios")
ENDIF()

ADD_LIBRARY ( ${LOG4CPP_LIBRARY_NAME} STATIC
  src/Appender.cpp
  src/AppenderSkeleton.cpp
  src/AppendersFactory.cpp
  src/BufferingAppender.cpp
  src/FactoryParams.cpp
  src/LayoutsFactory.cpp
  src/LevelEvaluator.cpp
  src/Localtime.cpp
  src/PassThroughLayout.cpp
  src/TriggeringEventEvaluatorFactory.cpp
  src/LayoutAppender.cpp
  src/FileAppender.cpp
  src/DailyRollingFileAppender.cpp
  src/RollingFileAppender.cpp
  src/FixedContextCategory.cpp
  src/IdsaAppender.cpp
  src/OstreamAppender.cpp
  src/StringQueueAppender.cpp
  src/SyslogAppender.cpp
  src/RemoteSyslogAppender.cpp
  src/SimpleLayout.cpp
  src/BasicLayout.cpp
  src/PatternLayout.cpp
  src/Category.cpp
  src/CategoryStream.cpp
  src/HierarchyMaintainer.cpp
  src/Configurator.cpp
  src/BasicConfigurator.cpp
  src/SimpleConfigurator.cpp
  src/PropertyConfigurator.cpp
  src/PropertyConfiguratorImpl.cpp
  src/LoggingEvent.cpp
  src/Priority.cpp
  src/NDC.cpp
  src/Filter.cpp
  src/TimeStamp.cpp
  src/StringUtil.cpp
  src/Properties.cpp
  src/Win32DebugAppender.cpp
  src/NTEventLogAppender.cpp
  src/DllMain.cpp
  src/DummyThreads.cpp
  src/MSThreads.cpp
  src/OmniThreads.cpp
  src/PThreads.cpp
  src/PortabilityImpl.cpp
  src/AbortAppender.cpp
  )
IF(ANDROID)
#  TARGET_LINK_LIBRARIES(${LOG4CPP_LIBRARY_NAME} stlport_shared)
ENDIF()

IF (WIN32)
  TARGET_LINK_LIBRARIES (${LOG4CPP_LIBRARY_NAME} kernel32 user32 ws2_32 advapi32 )
  SET_TARGET_PROPERTIES(${LOG4CPP_LIBRARY_NAME} PROPERTIES LINK_FLAGS /NODEFAULTLIB:msvcrt )
ENDIF (WIN32)

INSTALL (
  DIRECTORY include/log4cpp
  DESTINATION include
  PATTERN "config.h" EXCLUDE
  PATTERN ".svn" EXCLUDE
  PATTERN "*.am" EXCLUDE
  PATTERN "*.in" EXCLUDE
  )

# INSTALL (
#   TARGETS ${LOG4CPP_LIBRARY_NAME}
#   ARCHIVE DESTINATION lib
#   )

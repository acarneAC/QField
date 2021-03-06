################################################
# DON'T EDIT THIS FILE, USE config.pri instead #
################################################

include( paths.pri )

!android {
  INCLUDEPATH += $${QGIS_INSTALL_PATH}/include/qgis
  LIBS += $${QGIS_INSTALL_PATH}/lib/libqgis_core.so \
          $${QGIS_INSTALL_PATH}/lib/libqgis_gui.so
}

android {
  QGIS_INSTALL_PATH = $${OSGEO4A_STAGE_DIR}/$$ANDROID_TARGET_ARCH$$/files
  INCLUDEPATH += $${OSGEO4A_STAGE_DIR}/$$ANDROID_TARGET_ARCH$$/include/qgis
  LIBS += $${OSGEO4A_STAGE_DIR}/$$ANDROID_TARGET_ARCH$$/lib/libqgis_core.so \
          $${OSGEO4A_STAGE_DIR}/$$ANDROID_TARGET_ARCH$$/lib/libqgis_gui.so

  system( mkdir $$shadowed($$PWD)/tmp )
  system( "pushd $$QGIS_INSTALL_PATH; rm $$shadowed($$PWD)/tmp/assets.zip; zip -r $$shadowed($$PWD)/tmp/assets.zip share/resources/ share/svg/; popd" )
  qgis_assets.path = /assets
  qgis_assets.files = "$$shadowed($$PWD)/tmp/assets.zip"
  INSTALLS += qgis_assets
  qgis_providers.path = /libs/$$ANDROID_TARGET_ARCH$$
  qgis_providers.files = $$files( $$OSGEO4A_DIR/$$ANDROID_TARGET_ARCH$$/lib*provider.so )
  INSTALLS += qgis_providers
}

DEFINES += "CORE_EXPORT=" \
           "GUI_EXPORT=" \
           "QGIS_PLUGIN_DIR=\\\"$$QGIS_INSTALL_PATH$$/lib/qgis/plugins/\\\"" \
           "QGIS_INSTALL_DIR=\\\"$$QGIS_INSTALL_PATH$$\\\""

QMAKE_RPATHDIR += $${QGIS_INSTALL_PATH}/lib/

# Add QWT and QScintilla custom build paths if your distro only ships Qt4 versions
# and you had to build them manually for Qt5
QMAKE_RPATHDIR += $${QWT_DIR}
QMAKE_RPATHDIR += $${QSCINTILLA_DIR}

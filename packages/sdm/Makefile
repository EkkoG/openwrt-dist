include $(TOPDIR)/rules.mk
 
PKG_NAME:=sdm
PKG_VERSION:=0.0.1
PKG_RELEASE:=1
 
include $(INCLUDE_DIR)/package.mk
 
define Package/sdm
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=A simple daomon manager
  URL:=https://github.com/EkkoG/sdm
endef
 
define Package/sdm/description
 A simple daomon manager
endef
 
define Build/Compile
echo 'pass'
endef
 
define Package/sdm/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/sdm.config $(1)/etc/config/sdm
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/sdm.init $(1)/etc/init.d/sdm
endef
 
$(eval $(call BuildPackage,sdm))
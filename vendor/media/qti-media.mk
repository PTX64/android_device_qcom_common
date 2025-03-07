# Copyright (C) 2021 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_SOONG_NAMESPACES += \
    device/qcom/common/vendor/media

TARGET_MEDIA_COMPONENT_VARIANT := media

# Inherit configuration from the HAL.
ifeq ($(call is-board-platform-in-list, $(5_10_FAMILY)), true)
    $(call inherit-product-if-exists, hardware/qcom-caf/sm8450/media/product.mk)
else ifeq ($(call is-board-platform-in-list, $(5_15_FAMILY)), true)
    $(call inherit-product-if-exists, hardware/qcom-caf/sm8550/media/product.mk)
else ifeq ($(call is-board-platform-in-list, $(6_1_FAMILY)), true)
    $(call inherit-product-if-exists, hardware/qcom-caf/sm8650/media/product.mk)
endif

# Enable 64-bit mediaserver
PRODUCT_VENDOR_PROPERTIES += \
    ro.mediaserver.64b.enable=true

PRODUCT_COPY_FILES += \
    device/qcom/common/vendor/media/media_codecs_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_audio.xml

# Packages
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.2.vendor \
    libavservices_minijail.vendor

# Properties
PRODUCT_SYSTEM_EXT_PROPERTIES += \
    media.settings.xml=/vendor/etc/media_profiles_vendor.xml \
    media.stagefright.thumbnail.prefer_hw_codecs=true \
    ro.media.recorder-max-base-layer-fps=60

# Media Init
PRODUCT_COPY_FILES += \
    device/qcom/common/vendor/media/init.qti.media.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.media.sh

# Get non-open-source specific aspects.
$(call inherit-product-if-exists, vendor/qcom/common/vendor/media/media-vendor.mk)

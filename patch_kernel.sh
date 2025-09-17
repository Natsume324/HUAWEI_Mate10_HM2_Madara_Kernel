#!/bin/bash
# patch_kernel_config.sh
# 用来批量修改内核 .config 配置，把指定选项禁用
# 用法: ./patch_kernel_config.sh [config_file]

CONFIG_FILE="${1:-.config}"  # 如果没传参数就默认用当前目录下的 .config

# 要禁用的配置项列表
CONFIGS=(
    CONFIG_HISI_PMALLOC
    CONFIG_HIVIEW_SELINUX
    CONFIG_HISI_SELINUX_EBITMAP_RO
    CONFIG_HISI_SELINUX_PROT
    CONFIG_HISI_RO_LSM_HOOKS
    CONFIG_INTEGRITY
    CONFIG_INTEGRITY_AUDIT
    CONFIG_HUAWEI_CRYPTO_TEST_MDPP
    CONFIG_HUAWEI_SELINUX_DSM
    CONFIG_HUAWEI_HIDESYMS
    CONFIG_HW_SLUB_SANITIZE
    CONFIG_HUAWEI_PROC_CHECK_ROOT
    CONFIG_HW_ROOT_SCAN
    CONFIG_HUAWEI_EIMA
    CONFIG_HUAWEI_EIMA_ACCESS_CONTROL
    CONFIG_HW_DOUBLE_FREE_DYNAMIC_CHECK
    CONFIG_HKIP_ATKINFO
    CONFIG_HW_KERNEL_STP
    CONFIG_HISI_HHEE
    CONFIG_HISI_HHEE_TOKEN
    CONFIG_HISI_DIEID
    CONFIG_HISI_SUBPMU
    CONFIG_TEE_ANTIROOT_CLIENT
    CONFIG_HWAA
    CONFIG_DM_VERITY
    CONFIG_DM_VERITY_AVB
    CONFIG_DM_VERITY_FEC
    CONFIG_HAVE_KPROBES
    CONFIG_HW_SYSTEM_WR_PROTECT
    CONFIG_HISI_EARLY_RODATA_PROTECTION
    CONFIG_HISI_DUMMY_KO
    CONFIG_HUAWEI_USB_SHORT_CIRCUIT_PROTECT
)

if [ ! -f "$CONFIG_FILE" ]; then
    echo "错误: $CONFIG_FILE 不存在"
    exit 1
fi

for cfg in "${CONFIGS[@]}"; do
    if grep -qE "^$cfg=|^# $cfg is" "$CONFIG_FILE"; then
        echo "禁用 $cfg"
        # 把所有相关行替换成 "# CONFIG_xxx is not set"
        sed -i "s/^$cfg=.*/# $cfg is not set/" "$CONFIG_FILE"
        sed -i "s/^# $cfg is.*/# $cfg is not set/" "$CONFIG_FILE"
    fi
done

echo "内核配置已补丁完成 ✅"


#!/bin/bash
# ============================================================
#  卸载 / 清理 SSHFS 挂载（配套脚本）
#  用法：bash teardown-sshfs-mount.sh
# ============================================================

set -e

SERVICE_NAME="sshfs-remote-eda"
MOUNT_POINT="$HOME/remote_eda_lianghuaxiao"

echo "==> 停止并禁用服务"
systemctl --user disable --now "${SERVICE_NAME}.service" 2>/dev/null || true

echo "==> 卸载挂载点"
fusermount -u "$MOUNT_POINT" 2>/dev/null || sudo umount "$MOUNT_POINT" 2>/dev/null || true

echo "==> 删除 service 文件"
rm -f "$HOME/.config/systemd/user/${SERVICE_NAME}.service"
systemctl --user daemon-reload

echo "==> 清理 linger（可选，需要 sudo）"
# sudo loginctl disable-linger "$USER" 2>/dev/null || true

echo ""
echo "✅ 清理完成。挂载点目录 $MOUNT_POINT 保留（可手动 rmdir）"

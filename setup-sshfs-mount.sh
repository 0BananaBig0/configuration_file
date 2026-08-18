#!/bin/bash
# ============================================================
#  SSHFS 开机自动挂载脚本（systemd user service 方案）
#  用法：bash setup-sshfs-mount.sh
# ============================================================

# set -e

# ---------- 配置区（按需修改） ----------
SSH_USER=""
SSH_HOST=""
REMOTE_PATH="/data/workspaces/lianghuaxiao"
MOUNT_POINT="$HOME/remote_eda_lianghuaxiao"
SSH_KEY="$HOME/.ssh/id_rsa"
SERVICE_NAME="sshfs-remote-eda"
# --------------------------------------

echo "==> [1/7] 检查 sshfs 是否安装"
if ! command -v sshfs >/dev/null 2>&1; then
    echo "    sshfs 未安装，正在尝试安装..."
    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y sshfs
    elif command -v yum >/dev/null 2>&1; then
        sudo yum install -y sshfs
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y sshfs
    else
        echo "    请手动安装 sshfs 后重新运行此脚本"
        # exit 1
    fi
else
    echo "    sshfs 已安装: $(sshfs -V 2>&1 | head -1)"
fi

echo ""
echo "==> [2/7] 检查 SSH 免密登录"
if [ ! -f "$SSH_KEY" ]; then
    echo "    未找到 $SSH_KEY，正在生成 SSH 密钥..."
    ssh-keygen -t rsa -b 4096 -f "$SSH_KEY" -N ""
    echo "    请将公钥复制到远端："
    echo "    ssh-copy-id ${SSH_USER}@${SSH_HOST}"
    echo "    或手动将 $SSH_KEY.pub 内容追加到远端 ~/.ssh/authorized_keys"
    echo ""
    echo "    公钥内容如下，可手动复制："
    cat "${SSH_KEY}.pub"
    echo ""
    read -p "    已配置好免密登录后按回车继续..."
fi

# 测试免密登录
echo "    测试连接 ${SSH_USER}@${SSH_HOST} ..."
if ssh -o BatchMode=yes -o ConnectTimeout=5 \
       -i "$SSH_KEY" "${SSH_USER}@${SSH_HOST}" "echo ok" 2>/dev/null | grep -q ok; then
    echo "    免密登录 OK ✓"
else
    echo "    免密登录失败！请先运行：ssh-copy-id ${SSH_USER}@${SSH_HOST}"
    echo "    或确认 ${SSH_KEY} 对应的公钥已加入远端 authorized_keys"
    # exit 1
fi

echo ""
echo "==> [3/7] 创建挂载目录"
mkdir -p "$MOUNT_POINT"
echo "    挂载点: $MOUNT_POINT"

echo ""
echo "==> [4/7] 写入 systemd user service 文件"
mkdir -p "$HOME/.config/systemd/user"

SERVICE_FILE="$HOME/.config/systemd/user/${SERVICE_NAME}.service"
cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=SSHFS mount to EDA workspace (${SSH_USER}@${SSH_HOST}:${REMOTE_PATH})
Wants=network-online.target
After=network-online.target

[Service]
Type=forking
ExecStart=/usr/bin/sshfs \\
  -o reconnect \\
  -o ServerAliveInterval=15 \\
  -o ServerAliveCountMax=3 \\
  -o IdentityFile=${SSH_KEY} \\
  -o allow_other \\
  -o default_permissions \\
  ${SSH_USER}@${SSH_HOST}:${REMOTE_PATH} \\
  ${MOUNT_POINT}

ExecStop=/usr/bin/fusermount -u ${MOUNT_POINT}
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
EOF

echo "    已写入: $SERVICE_FILE"

echo ""
echo "==> [5/7] 启用 linger（让 user service 开机自启，无需先登录）"
sudo loginctl enable-linger "$USER" 2>/dev/null || \
    loginctl enable-linger "$USER" 2>/dev/null || \
    echo "    请手动执行: sudo loginctl enable-linger $USER"

echo ""
echo "==> [6/7] 启动并启用服务"
systemctl --user daemon-reload
systemctl --user enable --now "${SERVICE_NAME}.service"
sleep 2

echo ""
echo "==> [7/7] 检查挂载状态"
if systemctl --user is-active --quiet "${SERVICE_NAME}.service"; then
    echo "    服务状态: running ✓"
else
    echo "    服务状态: 异常，查看日志："
    systemctl --user status "${SERVICE_NAME}.service" --no-pager
fi

echo ""
echo "----------------------------------------"
echo "  挂载点:  $MOUNT_POINT"
echo "  远端:    ${SSH_USER}@${SSH_HOST}:${REMOTE_PATH}"
echo "  服务:    ${SERVICE_NAME}.service"
echo "----------------------------------------"
echo ""
echo "常用命令："
echo "  查看状态:  systemctl --user status ${SERVICE_NAME}.service"
echo "  重新挂载:  systemctl --user restart ${SERVICE_NAME}.service"
echo "  停止挂载:  systemctl --user stop ${SERVICE_NAME}.service"
echo "  禁用开机:  systemctl --user disable ${SERVICE_NAME}.service"
echo "  查看远端:  ls ${MOUNT_POINT}"
echo ""

# 最终验证
if mountpoint -q "$MOUNT_POINT"; then
    echo "✅ 挂载成功！$MOUNT_POINT 已可访问"
    ls "$MOUNT_POINT" | head -10
else
    echo "⚠️  挂载点尚未就绪，等待几秒后重试..."
    sleep 3
    if mountpoint -q "$MOUNT_POINT"; then
        echo "✅ 挂载成功！"
        ls "$MOUNT_POINT" | head -10
    else
        echo "❌ 挂载失败，请检查："
        echo "   1. 远端 SSH 服务是否可达: ssh ${SSH_USER}@${SSH_HOST}"
        echo "   2. 远端目录是否存在:    ssh ${SSH_USER}@${SSH_HOST} ls ${REMOTE_PATH}"
        echo "   3. 查看日志:            systemctl --user status ${SERVICE_NAME}.service"
    fi
fi

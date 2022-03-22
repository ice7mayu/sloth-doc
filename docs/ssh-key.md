# 添加 SSH Key

首先确认 **~/.ssh** 目录中是否已经有创建过的 ssh key.

如果没有则需要创建一对 public/private key:

```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
```

创建成功后会在 **~/.ssh** 目录下生成以下2个文件:

```text
-rw-------   1 user  staff   411B Feb 28 19:26 id_ed25519
-rw-r--r--   1 user  staff   102B Feb 28 19:26 id_ed25519.pub
```

复制 `id_ed25519.pub` 内容到自己的 Gitlab 账号中.

```shell
cat id_ed25519.pub
```

**public** key 示例输出:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1xTE5AAAAIM4EcJgxeQf+qx9mO8g4ilLeuortWkSW2leklJNd5MBD your_email@example.com
```

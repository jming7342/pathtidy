# pathtidy

一个查看和处理 $PATH 的小工具。
list 输出带编号和重复标记的列表；dedup、rm、add 输出可直接使用的 PATH 字符串。

## 为什么

`$PATH` 是一长串用冒号分隔的目录，终端里 `echo $PATH` 出来是一坨，阅读体验极差。

pathtidy 把它拆开看（`list`），也能简单处理（`dedup` / `rm` / `add`），
输出干净的结果，由你决定怎么用。

直接改 `~/.bashrc` 风险高，写错了终端可能起不来。
pathtidy 不碰配置文件，只输出结果——改不改、怎么改，你自己决定。

## 安装

```bash
git clone https://github.com/jming7342/pathtidy.git
cd pathtidy
chmod +x bin/pathtidy

ln -s "$(pwd)/bin/pathtidy" ~/.local/bin/pathtidy
```

要求 bash 4.0+（用了关联数组）。

## 用法

### 列出所有路径

```bash
pathtidy list
```

输出带编号，重复的会标记：

```
 1  /usr/bin
 2  /bin
 3  /usr/bin   (Duplicate with No.1)
```

### 去重

```bash
pathtidy dedup
```

输出：

```
/usr/bin:/bin
```

### 删除指定编号

```bash
pathtidy rm 2        # 删除第 2 条
pathtidy rm 2 4      # 删除第 2、4 条
```

### 插入路径

```bash
pathtidy add 2 /new/path    # 在第 2 位插入
pathtidy add /new/path      # 默认追加到末尾
```

### 可组合

每个命令只做一件事，都从 stdin 读、向 stdout 写，可以用管道串起来：

```bash
pathtidy dedup | pathtidy rm 2 | pathtidy list
```

### 直接用于终端指令

```bash
export PATH="$(pathtidy dedup | pathtidy rm 2)"
```

### 多次 add 时，位置基于上一次的结果

`add` 的位置是"上一次 add 后 PATH 里的位置"。如果要插多条，**建议从大数开始加**：

```bash
pathtidy add 6 /b | pathtidy add 2 /a
```

## 依赖

- bash 4.0+
- Linux

## License

MIT
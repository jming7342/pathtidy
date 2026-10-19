do_help() {
    cat <<'EOF'
Usage: pathtidy <command> [args]

查看和处理 $PATH 的小工具。

Commands:
  list                 列出所有路径，带编号，标记重复
  dedup                输出去重后的 PATH
  rm <num>...          删除指定编号的路径
  add [pos] <path>     在指定位置插入路径，省略 pos 则追加末尾
  help                 显示此帮助

位置说明:
  编号从 1 开始，对应 list 输出的编号。
  rm 的编号范围: 1 到 count
  add 的位置范围: 1 到 count+1（count+1 表示末尾）

示例:
  pathtidy list
  pathtidy dedup
  pathtidy rm 2
  pathtidy rm 2 4
  pathtidy add 2 /new/path
  pathtidy add /new/path

组合:
  pathtidy dedup | pathtidy rm 2 | pathtidy list

临时生效:
  export PATH="$(pathtidy dedup)"
EOF
}
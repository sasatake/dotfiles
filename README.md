# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理する dotfiles リポジトリ。

## セットアップ

```bash
chezmoi init --apply <repo-url>
```

## 運用フロー

### Claude Code での編集時

1. ファイルを編集すると、フック（`.claude/settings.local.json`）により `chezmoi apply` が自動実行される
2. 区切りのいいタイミングで `/commit` を使って git commit
3. `git push` で リモートに反映

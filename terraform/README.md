# Terraform ドキュメント

## 基本的なコマンド
```zsh
git secrets --install
```
### 初回時に実行
```zsh
terraform init
```
### 現状のソースコードを元に適用範囲を確認
引数  
`[-var <KEY>=<VALUE>]` 変数の指定  
`[-var-file <VAR_FILE>]` 変数ファイルの指定
```zsh
terraform plan
  [-var <KEY>=<VALUE>]
  [-var-file <VAR_FILE>]
```
### terraformの適用
引数  
`[-auto-approve]` 実行計画の確認なし  
`[-var <KEY>=<VALUE>]` 変数の指定  
`[-var-file <VAR_FILE>]` 変数ファイルの指定
```zsh
terraform apply
  [-auto-approve]
  [-var <KEY>=<VALUE>]
  [-var-file <VAR_FILE>]
```
### 全てのリソースを削除
引数  
`[-auto-approve]` 実行計画の確認なし
```zsh
terraform destroy
  [-auto-approve]
```
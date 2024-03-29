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
## ブロックタイプ
|   type    |        description        |
|:---------:|:-------------------------:|
|  locals   |      外部から変更不可のローカル変数      |
| variable  |        外部から変更可能な変数        |
| terraform |       Terraformについて       |
|   data    | Terraformの管理対象外のリソースの取り込み |
| resource  |   Terraformの管理対象となるリソース   | 
|  output   |      外部から参照できるようにする値      |

### locals
使い方 `${locals.<NAME>}`で参照
```terraform
# locals定義
locals {
  project = "sample"
  env     = "prod"
}
# localsの利用
resource "aws_instance" "sample_ec2" {
  # 省略
  tags = {
    Name = "${locals.project}-${locals.env}"
  }
}
```

### variables
使い方 `${var.<NAME>}`で参照
```terraform
# variablesの定義
variable "project" {
  type = string
  default = "sample"
}
# variablesの利用
resource "aws_instance" "sample_ec2" {
  # 省略
  tags = {
    Name = "${var.project}-prod-ec2"
  }
}
```
#### 変数の変更
- 環境変数による変更
```zsh
TF_VAR_<NAME> 
```
- 変数ファイルによる変更(`tfvars`)
`terraform.tfvars`に以下のように書く
```terraform
var1 = "Sample"
```
`terraform apply`のとき引数不要
- コマンド引数による変更
```zsh
[-var <KEY>=<VALUE>]
[-var-file <VAR_FILE>]
```
#### データ型について
- primitive
  - `number` 数値
  - `string` 文字列
  - `bool`   bool値 (`true`/`false`)
- 構造体
  - `object({<NAME>=<TYPE>, ...})` key-value型
  - `tuple([<TYPE>, ...])` 各列の型が決まっている配列
- collection
  - `list(<TYPE>)` 特定の型で構成される配列
  - `map(<TYPE>)` stringで構成される配列
  - `set(<TYPE>)` 集合型の配列
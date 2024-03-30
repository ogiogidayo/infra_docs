# Terraform ドキュメント

## 基本的なコマンド
```zsh
git secrets --install
```
### 初回時に実行
```zsh
terraform init
```
### formatter
```terraform
terraform fmt
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
カレントディレクトリのみ適用 サブディレクトリは適用されない  
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
#### その他
- 組み込み関数のtest
```zsh
terraform console
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
### output
```terraform
resource "aws_instance" "sample" {
ami           = "ami-0253ce315ad0c9655"
instance_type = "t2.micro"
}
# EC2インスタンスのidを出力
output "ec2_instance_id" {
  value = aws_instance.sample.id
}
```
### リソース参照
参照方法: `<BLOCK_TYPE>.<LABEL_1>.<LABEL_2>`  
example  
```terraform
resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/20"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
# aws_vpc.vpc.id として参照
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
}
```
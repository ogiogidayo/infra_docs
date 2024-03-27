# インフラ周りのドキュメント
## ディレクトリ構成
```text
.
├── README.md
├── linux
├── terraform
├── docker-compose.yml
├── Dockerfile
└── Makefile
```

## Linuxのシェルにアクセス
### Dockerで起動
ルートで以下を行う。
```zsh
make up
```
### シェルへアクセス
#### 一般ユーザーとしてアクセス
```zsh
make shell
```
#### ルートユーザーとしてアクセス
```zsh
make root-shell
```
### Linuxから抜ける方法
```bash
exit
```
### Dockerを落とす方法
```zsh
make down
```
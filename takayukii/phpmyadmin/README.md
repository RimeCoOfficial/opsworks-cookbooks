# phpmyadmin

###### Forked from: https://github.com/takayukii/cookbooks/tree/master/phpmyadmin

phpMyAdminを導入する。

## Requirements

OpsWorksの下記の環境下で動作確認済

``` 
Operating System: Amazon Linux AMI release 2015.03
OpsWorks Layers: Node.js App Server
```

## Attributes

Attributesでは構成するサーバーのポート番号を指定できる。


キー | 型  | 説明 | 初期値
---- | --- | ---  |---
`["phpmyadmin"]["db_hostname"]` | 文字列 | MySQLのホスト名 | `127.0.0.1`

## Usage

#### phpmyadmin::nginx

```json
{
  "phpmyadmin": {
    "db_hostname": "mydbinstance.qwhsdahdjauw.us-west-2.rds.amazonaws.com"
  }
}
```

注）phpMyAdminはパスがそのままだと攻撃されやすいため避ける事。

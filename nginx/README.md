nginx cookbook
==============

nginxを導入する。

Requirements
------------

phpMyAdminのインストールは[phpmyadmin](../phpmyadmin)をinclude_recipeしている。

OpsWorksの下記の環境下で動作確認済

```
Operating System: Amazon Linux AMI release 2015.03
OpsWorks Layers: Node.js App Server
```

Attributes
----------

<table>
  <tr>
    <th>キー</th>
    <th>型</th>
    <th>説明</th>
    <th>初期値</th>
  </tr>
  <tr>
    <td><tt>["nginx"]["node_proxy"]["http_port"]</tt></td>
    <td>数値</td>
    <td>ELBからHTTPで受け付けるポート番号</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>["nginx"]["node_proxy"]["https_port"]</tt></td>
    <td>数値</td>
    <td>ELBからHTTPSで受け付けるポート番号</td>
    <td><tt>44380</tt></td>
  </tr>
  <tr>
    <td><tt>["nginx"]["node_proxy"]["wss_port"]</tt></td>
    <td>数値</td>
    <td>ELBからSSL/TCPで受け付けるポート番号</td>
    <td><tt>3000</tt></td>
  </tr>
  <tr>
    <td><tt>["nginx"]["node_proxy"]["node_port"]</tt></td>
    <td>数値</td>
    <td>EC2でNode.jsが起動するポート</td>
    <td><tt>80</tt></td>
  </tr>
  <tr>
    <td><tt>["nginx"]["node_proxy"]["phpmyadmin_name"]</tt></td>
    <td>文字列</td>
    <td>phpMyAdminのパス（URL） e.g. phpmyadminの場合 /phpmyadmin でアクセスする</td>
    <td><tt>空（設定されない）</tt></td>
  </tr>
</table>

phpmyadmin_nameを指定すると[phpmyadmin](../phpmyadmin)のphpmyadmin::nginxがinclude_recipeで実行される

Usage
-----

#### nginx::node_proxy

本レシピでは下記を設定する。

* HTTPS強制
* WSSの転送
* gzip圧縮（javascript、cssファイル等も含む）
* phpMyAdminの導入（オプション）

下記のようにnginxが構成される。この構成はELBのリスナー設定と密に関わるものであるため合わせて設定する。

<table>
  <tr>
    <th>種類</th>
    <th>説明</th>
  </tr>
  <tr>
    <td>HTTP</td>
    <td>HTTPでリクエストを受け付けHTTPSにリダイレクトする</td>
  </tr>
  <tr>
    <td>HTTPS</td>
    <td>Node.jsが起動している80ポートに転送する</td>
  </tr>
  <tr>
    <td>WSS</td>
    <td>WebSocket通信を行う</td>
  </tr>
</table>

```json
{
  "nodeproxy": {
    "http_port": 8080,
    "https_port": 44380,
    "wss_port": 3000,
    "phpmyadmin_name": "nimdaphpym"
  },
  "phpmyadmin": {
    "db_hostname": "url.to.rds.com"
  }
}
```


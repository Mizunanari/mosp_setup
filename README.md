# mosp_docker

MosP勤怠管理ソフトウェアをかんたんに導入できるスクリプトを作成しました。

公式のリファレンスにしたがってスクリプトを作成しています。

環境はdockerを使用しています。

自己責任でお使いください。

[公式インストールdoc](https://ja.osdn.net/projects/mosp/releases/72904)

## 環境

* [docker](https://www.docker.com/)

## 利用手順

### 前準備

このmosp_setupを適当なディレクトリにクローン

```bash
git clone https://github.com/Mizunanari/mosp_setup.git
```

[MosP勤怠管理V4](https://ja.osdn.net/projects/mosp/releases/p12162)

ダウンロードし、同じディレクトリに格納

### docer centos7 の立ち上げ

dockerのコマンドにルート権限が必要な場合は sudo を前につける

```bash
docker run --privileged -it -d --name mosp -p 80:80 centos:centos7 /sbin/init
```

```bash
docker exec -it mosp bash
```

### ユーザーを作成する

|user|pass|
|--|--|
|usermosp|passmosp|


```bash
useradd usermosp
passwd usermosp
```

```
New password:passmosp
```

```
Retype new password:passmosp
```

### dockerを抜ける

```bash
exit
```

### host pcにて

#### このスクリプトをcloneしたディレクトリに移動

```
cd /mosp_script
```

#### 設定ファイルとスクリプトをdockerに移動

dockerのコマンドにルート権限が必要な場合は sudo を前につける

```bash
docker cp ./pg_hba.conf mosp:/home/usermosp/
docker cp ./mosp_setup.sh mosp:/home/usermosp/
docker cp ./time4.war mosp:/home/usermosp/
```

#### 再びコンテナに入る

```bash
docker exec -it mosp bash
```

### ファイルの確認

先程コピーしたファイルがあるかを確認

```bash
cd /home/usermosp
ls -la
```

### 権限の付与

スクリプトに権限を付与します。

```bash
chmod 700 ./mosp_setup.sh
```

### 実行

```bash
./mosp_setup.sh
```

少し時間がかかります。

### Postgres のパスワード設定

```bash
su – postgres
```

```bash
psql
```

```bash
\password
```

```bash
> 新しいパスワード:postgres
> もう一度入力してください:postgres
```

```bash
\q
```

```bash
exit
```

### ブラウザで開く

http://localhost/time4/pub/common/html/setup.html

初期ユーザーのパスワードはIDと同じになる

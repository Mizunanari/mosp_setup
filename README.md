# mosp_docker

## 環境

* [docker](https://www.docker.com/)

## 利用手順

スクリプトの利用方法

### docer centos7 の立ち上げ

```bash
docker run --privileged -i -t -d --name mosp -p 80:80 centos:centos7 /sbin/init bash
```

### ユーザーを作成する

|user|pass|
|--|--|
|usermosp|passmosp|

```bash
useradd usermosp
passwd usermosp
```

### dockerを抜ける

```bash
exit
```

### host pcにて

```bash
docker cp ./pg_hda.conf mosp:/home/usermosp/
docker cp ./mosp_setup.sh mosp:/home/usermosp/
docker cp ./time4.war mosp:/home/usermosp/
```

```bash
docker exec -it mosp bash
```

### ファイルの確認

```bash
cd /home/usermosp
ls -la
```

### 権限の付与

```bash
chmod 700 ./mosp_setup.sh
```

### 実行

```bash
./mosp_setup.sh
```

### Postgres のパスワード設定

```bash
su – postgres
psql
\password
新しいパスワード:postgres
もう一度入力してください:postgres
\q
exit
```

### ブラウザで開く

http://localhost/time4/pub/common/html/setup.html

初期ユーザーのパスワードはIDと同じになる
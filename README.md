# Sinatraのメモアプリ

SinatraでシンプルなWebアプリを作ろうの課題に取り組みます〜

## 使い方

1. リポジトリのクローンを作成する

```
$ git clone https://github.com/vinhactindi/sinatra-practice.git
```

2. 必要なgemをインストールする

```
$ bundle install 
```

3. アプリを起動する

```
$ bundle exec ruby main.rb
```

## URL

|Method|Path|Description
|--|--|--|
|GET|/memos|メモの一覧を表示。|
|GET|/memos/new|Newメモの画面を表示。|
|GET|/memos/`{memo_id}`|メモのidを受け取って表示。|
|GET|/memos/`{memo_id}`/edit|メモのidを受け取って、変更の画面を表示。|
|POST|/memos|メモを受け取って追加する。|
|PATCH|/memos/`{memo_id}`|メモを受け取って、変更する。|
|DELETE|/memos/`{memo_id}`|メモのidを受け取って、削除する。|

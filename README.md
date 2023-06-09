# README
# 簡易仕様書

### 作者
佐野友哉

### アプリ名
さがしてmeal

#### コンセプト
一番近くのお店が一瞬で分かる。

#### こだわったポイント
検索条件を豊富にしました。

#### デザイン面でこだわったポイント
要素を大きく簡潔に記載し、見やすく分かりやすいような画面にしました。

### 公開したアプリの URL（Store にリリースしている場合）
未公開

### 該当プロジェクトのリポジトリ URL（GitHub,GitLab など Git ホスティングサービスを利用されている場合）
https://github.com/sano-nakaji/Sagashite-meal.git

## 開発環境
### 開発環境
Visual Studio Code 1.77.1

### 開発言語
Ruby 3.0.5
Ruby on Rails 7.0.4.3

## 動作対象端末・OS
### 動作対象OS
Windows 10 21H2

### 動作対象ブラウザ
Google chrome 111.0.5563.147 (x64)
Microsoft Edge 112.0.1722.34 (x64)

## 開発期間
14日間(3/29 ~ 4/11)

## アプリケーション機能
現在地の周辺にある店舗の一覧と、その詳細を確認することが出来る。
現在地からの距離等の諸条件による絞り込み検索も可能。

### 機能一覧
- 飲食店検索：ホットペッパーグルメサーチAPIを使用して、現在地周辺の飲食店を検索する。
- 飲食店情報取得：ホットペッパーグルメサーチAPIを使用して、飲食店の詳細情報を取得する。

### 画面一覧
- 検索画面 ：現在地からの半径して飲食店を検索する。
- 一覧画面 ：検索結果の飲食店を一覧表示する。
- 詳細画面 ：指定した店舗の詳細情報を表示する。

### 使用しているAPI,SDK,ライブラリなど
- ホットペッパーグルメサーチAPI
- Geolocation API

### アドバイスしてほしいポイント
- 本アプリの開発で初めてAPIを利用してアプリケーションを作成したためエラーが発生することが多く、根幹機能の実装に大きく時間を割いてしまいました。今まで扱ったことのない技術を導入し、エラー等で長時間解決しなかったとき、どのように対処されますか？
- 全体的に簡素なデザインとなってしまいました。デザイン案のアドバイスをいただければと思います。

### 自己評価
- 開発初期の進捗度が悪かったため、追加実装したい機能やデザイン案は多くありますが、結果として最低限の機能の実装のみとなってしまいました。今後はタスク管理と知識・技術の向上をもってよりよい成果物を製作したいと思います。
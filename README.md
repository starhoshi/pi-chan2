# pi-chan2

pi-chan を書き直す

# 開発環境
- Xcode 8.1
- Swift 3.0.1
- ruby 2.3.1
- CocoaPods >= 1.1.1

# コーディング規約
Swift Lint で規約に従わない場合にエラー出るようになっています。

* [swift\-style\-guide/README\_JP\.md at master · jarinosuke/swift\-style\-guide](https://github.com/jarinosuke/swift-style-guide/blob/master/README_JP.md)


# 環境構築手順

## Ruby
Ruby は 2.3.x を利用しますので、 rbenv などで install しておいてください。  
また、 Bundler をインストールしていない場合は、先に下記コマンドでインストールしてください。

```
$ gem install bundler
```

利用する Gemfile のバージョンを固定するため、Bundler で gem をインストールします。プロジェクトのルートで以下のコマンドを実行してください。

```
$ bundle install --path vendor/bundle
```

## CocoaPods

CocoaPods で install するライブラリ自体をソース管理しています。  
CocoaPods ライブラリを追加する際は下記コマンドを実行してください。

```
$ bundle exec pod install
```


## Lint
Swift Lint を利用するため、下記コマンドでインストールしてください。

```
$ brew install swiftlint
```

# ビルド設定
TODO

# その他
TODO

## synx

新しいファイルを追加した場合、 synx を実行してください。  
Xcode 上の Directory 構成と実際の　Directory 構成は異なるため、 synx により一致させてください。  
(ここはプルリク時にチェック自動化したい)

```
$ bundle exec synx pi-chan2.xcodeproj/
```




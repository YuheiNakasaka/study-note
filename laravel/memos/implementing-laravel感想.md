# implementing laravelのメモ

## 依存注入(p12~p15)

アプリの他の機能に影響を与えずに拡張実装していくための仕組み。
email機能を例にawssdkからgridmailsdkに差し替える手順が説明されている。
依存注入とIoCの概念がわかりやすい。

(【インターフェース】--【サブクラスクラス】) >>依存注入>> 【アプリケーション(controller,model,...)】

- interfaceの実装:機能。ドメインよりの設計ができる。
- サブクラス実装:機能の振る舞い
- ** interface・サブクラスとアプリケーションをつなぐbind **
- アプリケーション実装:アプリケーションのロジック

## サンプルアプリ

- アプリケーションはLaravelフレームワークの実装ではなく逆に、Laravelが私達のアプリケーションの実装である
    - アプリケーションの一部としてのフレームワーク = 保守性高まる

### アプリ実装の流れ

- アプリケーションディレクトリにインターフェースを実装
- インターフェース(interface)を実際に実装した抽象クラス(abstruct)を実装
- 実際にcontrollerで使用するサービス(ライブラリクラス)を実装(controller独自のルールとかはここに)
- controllerで作成したサービス(ライブラリクラス)を__constructで依存注入し利用

### (【インターフェース】--【サブクラスクラス】)はどこにおくか?

- A.アプリケーションライブラリを作成する。そしてオートロードさせる。

場所

    laravel-app
    |-app
    |-commands
    |-config
    |-.....
    |-ApplicationLibrary
        |-selfLibrary1
        |-selfLibrary2
        |-selfLibrary3

composer.jsonにautoload設定を追加

    {
        "require": {
        "laravel/framework": "4.0.*"
        },
        "autoload": {
        "classmap": [
        ...
        ],
        "psr-0": {
            "Impl": "app"
            }
        },
        "minimum-stability": "dev"
    }

登録

    $composer dump-autoload

## リポジトリパターン

- 外部(DBやアプリ外API等)からデータを取得する層。ビジネスロジックと明確に切り離す。

### 最悪なアンチパターン

- controllerから直接Eloquentモデルを使用する
    - すべてのデータ源(DB、キャッシュ、配列,json)に対して切り替え可能ではない
    - DBなしでテストできない
    - 再利用性が低い。
    ↓↓↓↓↓↓↓
#### controllerからmodelにアクセスしない

## バリデーションをコントローラーに書かない

## フォームのクラスでバリデーションクラスとリポジトリクラスを統合

- これによりcontrllerからバリデーションとmodelへのアクセスが消える

## サードパーティパッケージの利用も手順は同じ
### rspecでtest

rspecでrails用にテストを書いたのではまったところなどメモ。

- よく使う宣言は
    - describe(メソッド名)
    - fixtures
    - subject(共通のアレ)
    - context(条件名)
    - before(準備)
    - it(実行)
    - should,should_not
    - be_blank
    - post :action名
    - get :action名
    - response
    - assigns(インスタンス変数)

- テストデータはfixturesに定義しておく
    - table同士の関連もyamlでできるらしい
- controllerのテスト
    - getとかpostする->responseをshouldで検証が鉄板の流れ
    - paramsを渡す時はget :show, :id => 1みたいな感じで。
        - 例えば、/users/1みたいなURLはget :showだけにしがちだけど:id => 1のように指定しないとRouting Errorに見舞われる
    - cookies[:cookie名]でcookieを指定できる
    - assigns(インスタンス変数)でrequestしたactionのインスタンス変数にアクセスできる
- modelのテスト
    - it {respond_to :name}みたいにしてattr_accessorはテストする
    - validationはbeforeで@user = User.find(1)みたいなインスタンス変数を作っておいて、@user.name.should_not be_blankみたいな流れで行なう
- helperのテスト
    - 他と流れは同じ
    - helperのテストだけじゃないけどassign(:val, "1")のようにすると、メソッド内の@valを置き換えられる
- jsonの扱い
    - controllerではpost :create, {:format => :json,:id => 1〜}のようにformatを指定しないとjsonでresponseが返ってこない
    - gemの[json_spec](https://github.com/collectiveidea/json_spec)が便利


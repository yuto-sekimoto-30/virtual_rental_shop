# サービス名

仮想レンタルショップ(仮)

# サービス概要

レンタルショップ屋のようなデザインで映画をジャンル別にランダムで一覧表示する

# メインのターゲットユーザー

・映画好きの人<br>
・レンタルショップ屋に行かなくなった人<br>
・未知の映画や懐かしの映画に出会いたい人<br>

# ユーザーが抱える課題

最近ではサブスクの充実により、レンタルショップ屋が減少してきており、
その結果として未知の映画や懐かしの映画を偶然発見できる可能性が減ってきている
(ネトフリ等の大手サブスクでは、見たい映画を検索するか最新映画やランキング、おすすめ一覧等から選択するなど、どうしても見る映画がありきたりになる)

# 解決方法

個人的にレンタルショップで映画を選ぶ場合、店内を適当に歩き回り偶然面白そうと思ったものを手に取る<br>
それを再現するために、古い映画含め色々な映画をランダムに一覧表示する機能を実装する<br>
具体的な表示方法として、映画のジャンル(アニメ、アクション、ホラー等)や年代別などに分け、そこから数をいくつか絞りランダムで一覧表示をする<br>s

# 実装予定の機能

・全ユーザー<br>
&emsp;・ユーザーにランダムで映画一覧を表示する<br>
&emsp;・ユーザーが調べたい映画を検索できる<br>
&emsp;・ユーザーは表示された映画一覧から選択した映画詳細について確認できる<br>
&emsp;・ユーザーはユーザー情報を登録できる<br>
・ログインユーザー<br>
&emsp;・ログインユーザーは映画をお気に入りに登録でき、お気に入り一覧を確認できる<br>
&emsp;・ログインユーザー同士で相互フォローができ、ユーザー間でお気に入り映画を確認できる<br>
&emsp;・ログインユーザーに対して、フォローしたユーザーのお気に入り映画をランダムで表示する<br>
&emsp;・ログインユーザーは映画に対してコメントが投稿できる<br>
・管理ユーザー<br>
&emsp;・ユーザーの検索、一覧、詳細、編集、作成、削除<br>

# なぜこのサービスを作りたいのか？

・映画が好きだから<br>
・自宅でもレンタルショップで映画を選ぶような体験がしたいから（そうすれば、普段見ないような名作、B 級映画、懐かしいの映画などに出会えるかもしれない）<br>

# スケジュール

２ヶ月以内に作成する

# 補足

・他のサイトと差別化しサイトの雰囲気を出すために、jquery,css のアニメーションを利用するなどしデザインを工夫する必要がある<br>
・調べた結果、TMDB という映画情報を取得できる API があるのでそちらを利用する<br>
・レンタルショップと記載しているが、特にそのような機能は実装なし(あくまで閲覧メイン)<br>

# 画面遷移図

https://www.figma.com/file/2esMKDIl8dpOWOSH6hROD9/Untitled?node-id=25%3A425

# ER 図

![ER図](ER図.png)

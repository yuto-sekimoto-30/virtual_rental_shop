# サービス名

仮想レンタルショップ(仮)

# サービス概要

レンタルショップ屋のようなデザインで映画を一覧表示する

# メインのターゲットユーザー

・映画好きの人<br>
・レンタルショップ屋に行かなくなった人<br>
・未知の映画や懐かしの映画に出会いたい人<br>

# ユーザーが抱える課題

最近ではサブスクの充実により、レンタルショップ屋が減少してきており、
その結果として未知の映画や懐かしの映画を偶然発見できる可能性が減ってきている
(ネトフリ等の大手サブスクでは、見たい映画を検索するか最新映画やランキング、おすすめ一覧等から選択するなど、どうしても見る映画がありきたりになる)

# 解決方法

個人的にレンタルショップで映画を選ぶ場合、店内を適当に歩き回り偶然面白そうと思ったものを手に取る
それを再現するために、古い映画含め色々な映画をランダムに一覧表示する機能を実装する
あとは本当のレンタルショップ屋のようにジャンル別、最新、おすすめ一覧も表示できるようにする

# 実装予定の機能

・利用ユーザー<br>
&emsp;・ユーザーにランダムで映画一覧を表示する<br>
&emsp;・ユーザーが調べたい映画を検索できる<br>
&emsp;・ユーザーは表示された映画一覧から選択した映画詳細について確認できる<br>
&emsp;・ユーザーはユーザー情報を登録できる<br>
&emsp;・ユーザー情報を登録しログインすることでお気に入り機能が利用できる<br>
・管理ユーザー<br>
&emsp;・登録ユーザーの検索、一覧、詳細、編集<br>
&emsp;・管理ユーザーの検索、一覧、詳細、編集<br>

# なぜこのサービスを作りたいのか？

・映画が好きだから<br>
・自宅でもレンタルショップで映画を選ぶような体験がしたいから（そうすれば、普段見ないような名作、B 級映画、懐かしいの a 映画などに出会えるかもしれない）<br>

# スケジュール

２ヶ月以内に作成する

# 補足

・検索機能や年代別、最新、ランキング一覧表示等のシンプルな機能も実装する<br>
・他のサイトと差別化しサイトの雰囲気を出すために、jquery,css のアニメーションを利用するなどしデザインを工夫する必要がある<br>
・調べた結果、TMDB という映画情報を取得できる API があるのでそちらを利用する<br>
・レンタルショップと記載しているが、特にそのような機能は実装しない(あくまで閲覧メイン)<br>

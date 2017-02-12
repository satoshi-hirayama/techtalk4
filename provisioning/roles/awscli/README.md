# awscli of role

awscliコマンドを有効にします。AWS認証情報は、Ansibleを実行しているコンピュータのシェルの環境変数から設定されます（対象のホストではありません）。

## Vars

|Name|Default|Description|
|---|---|---|
|aws_region|ap-northeast-1|利用するリージョン|
|main_user|ubuntu|configのインストール先ユーザー（rootには対応していません）|

## Dependencies

* pip

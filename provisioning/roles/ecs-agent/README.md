# ecs-agent of role

EC2上のUbuntu 16.04にECS Container Agentをインストールします、ECSコンテナインスタンスとして利用できるようにします。

* Ubuntu 15.10以前には未対応です。
* EC2上のインスタンスのみ対応しています。

## Vars

|Name|Default|Description|
|---|---|---|
|main_user|ubuntu|設定を書き込む対象のユーザー|
|cluster_name||ECSクラスタ名|
|proxy_ip|127.0.0.1|プロキシサーバのIPアドレス（プロキシ環境の場合）|

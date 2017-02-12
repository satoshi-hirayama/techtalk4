# squid-proxy of role

プライベートなネットワークから踏み台のProxy（Squid）を経由してapt/curl/wget/git/gemできるようにします。

**（注意）**
`rbenv`は`.curlrc`を無視しますので、proxyを使う環境で`rbenv install`する場合は、playbookで以下のような形式で`http_proxy`を指定をする必要があります。

```
environment:
  http_proxy: http://10.0.11.15:3128
```

## Vars

|Name|Default|Description|
|---|---|---|
|proxy_ip|127.0.0.1|Proxy（Squid）が稼働しているサーバーのIPアドレス|
|main_user|ubuntu|設定を書き込む対象のユーザー|

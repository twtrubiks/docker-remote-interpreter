# docker-remote-interpreter

* [Youtube Tutorial - docker-remote-interpreter-using-pycharm](https://youtu.be/bOUGyitONQ0)

## 前言

這篇文章主要是要教大家如何使用 Pycharm remote interpreter ( Using Docker )，這邊需要注意的是，

要使用此功能，你的 Pycharm 必須是 **Professional** 的版本。

為什麼我會突然介紹這個呢？原因是之前我在 windows 上用 Anaconda 安裝套件 ( Channels ) 時，

一直有問題，於是我就想說不然用 docker 來解決，當然同時也需要 debug 阿:weary:

於是就有了這篇文章的教學:smiley:

## 教學

首先，要先對 docker 有一些基本的認識，如果你對 docker 非常的陌生，可以參考我之前寫的文章

* [Docker 基本教學 - 從無到有 Docker-Beginners-Guide 教你用 Docker 建立 Django + PostgreSQL 📝](https://github.com/twtrubiks/docker-tutorial)

基本上，這篇的範例就是用上面文章的範例下去教學的:smirk:

我主要是參考  [Configuring Remote Interpreter via DockerCompose](https://www.jetbrains.com/help/pycharm/using-docker-compose-as-a-remote-interpreter-1.html) 這篇文章，但步驟不一樣相同，接下來的教學，

使用的環境是 Win10，如果你是 MAC 用戶，也是可以使用 ( 只是手邊目前沒有 MAC，但確定可以使用 ，方法大同小異 )。

先設定，將  Expose daemon...  這個打勾

![alt tag](https://i.imgur.com/R3ot2a9.png)

File -> Settings ( 或是快捷鍵`Ctrl+Alt+S`) 設定以下參數

![alt tag](https://i.imgur.com/mttgpFu.png)

再找到 Project Interpreter，選擇 Add Remote

![alt tag](https://i.imgur.com/zl63LUr.png)

接下來，請選擇 Docker Compose (這邊使用 docker-compose 來建立環境 )，

其他參數，理論上預設就會幫你帶入了，

![alt tag](https://i.imgur.com/kaJF9bw.png)

先來介紹一下資料夾內的東西，

[Dockerfile](https://github.com/twtrubiks/docker-remote-interpreter/blob/master/Dockerfile)

基本上就是將目錄底下的檔案複製到 docker 容器裡面以及安裝 [requirements.txt](https://github.com/twtrubiks/docker-remote-interpreter/blob/master/requirements.txt)。

[docker-compose.yml](https://github.com/twtrubiks/docker-remote-interpreter/blob/master/docker-compose.yml)

裡面也很簡單，就是一個 postgres database，然後一個 app 啟動 django。

docker_remote_interpreter/[settings.py](https://github.com/twtrubiks/docker-remote-interpreter/blob/master/docker_remote_interpreter/settings.py)

`settings.py` 裡面必須設定兩個東西，第一個是 `ALLOWED_HOSTS` 這部分，

```python
ALLOWED_HOSTS = ["*"]
```

( 這邊提醒一下大家，設定 `*` 只是為了測試方便而已 )。

第二個部分是將你的 db 修改成 postgres

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': 'password123',
        'HOST': 'db',
        'PORT': 5432,
    }
}
```

接下來就是等，可能需要等一小段時間 ( 尤其是第一次，先去泡杯咖啡吧:relaxed: )

![alt tag](https://i.imgur.com/k3jVYKb.png)

當他跑完之後，按 ok ，會看到下圖

![alt tag](https://i.imgur.com/gFqUXDD.png)

右下角

![alt tag](https://i.imgur.com/d0WHzT1.png)

等全部都執行完之後

![alt tag](https://i.imgur.com/iWnjI7t.png)

填入 `0.0.0.0`，以這個範例來講， port 就是 8000

![alt tag](https://i.imgur.com/y82Dvo3.png)

直接開始 debug

![alt tag](https://i.imgur.com/YbsC8yt.png)

啟動成功

![alt tag](https://i.imgur.com/CSq5oOl.png)

可以使用 `docker ps` 確認

![alt tag](https://i.imgur.com/8zeSK9s.png)

最後我們直接進去容器 migrate

```cmd
python manage.py makemigrations
python manage.py migrate
```

![alt tag](https://i.imgur.com/CWJIHD6.png)

直接瀏覽，[http://localhost:8000/](http://localhost:8000/) ( 有時候可能會是 [http://0.0.0.0:8000/](http://0.0.0.0:8000/)，要看你電腦的 host 設定 )

![alt tag](https://i.imgur.com/A0kF1wt.png)

觀看容器內的 log ( 我們的確有成功連線上 )

![alt tag](https://i.imgur.com/HbejCAg.png)

到這邊就完成了:smile:

## 後記

整體來看，相信大家應該會覺得用 Pycharm 設定 remote-interpreter 蠻簡單的，但他也有缺點，就是如果你今天

需要增加一個套件，你的 docker 就需要重新 build。

可能有人會問，有沒有 vscode 的 remote-interpreter 教學呢 ? 這是個好問題，我後來也有嘗試用 vscode 設定，但

設定一直失敗，如果有人成功，麻煩可以再指點一下，我會把教學補進文章裡面:grin:

## 執行環境

* Python 3.6.4
* Win10

## Reference

* [Configuring Remote Interpreter via DockerCompose](https://www.jetbrains.com/help/pycharm/using-docker-compose-as-a-remote-interpreter-1.html)

## Donation

文章都是我自己研究內化後原創，如果有幫助到您，也想鼓勵我的話，歡迎請我喝一杯咖啡:laughing:

![alt tag](https://i.imgur.com/LRct9xa.png)

[贊助者付款](https://payment.opay.tw/Broadcaster/Donate/9E47FDEF85ABE383A0F5FC6A218606F8)

## License

MIT licens
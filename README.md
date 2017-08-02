# Spigot on Heroku

## Run your spigot minecraft server on the cloud with Heroku.

This is a Heroku [buildpack](https://devcenter.heroku.com/articles/buildpacks), in order to install it you need to install the Heroku [toolbelt](https://toolbelt.heroku.com).

## Requirement

1. The Heroku toolbelt installed

2. A free Heroku account. [Sign up here](https://signup.heroku.com)

3. A ngrok account (for ip tunneling). [Sign up here](https://ngrok.com/signup)

4. A dropbox account for files sync. [Sign up here](https://www.dropbox.com/login) (info below)

## Usage

After download and install the Heroku CLI, open Command Prompt (cmd) and type

```
heroku login
```

with your account credentials.

Next, simply copy the following lines to your Command Promt (cmd)

```
heroku create
heroku buildpacks:add heroku/jvm
heroku buildpacks:add https://github.com/kimbang012/Spigot-on-heroku
heroku ps:exec
git commit -m "Heroku Exec" --allow-empty
done
```

Then, manually add these command with your Ngrok auth token, Dropbox app config file link (read below)

```
$ heroku config:set NGROK_API_TOKEN="xxxxx"
$ heroku config:set DBCONFIG="xxxxx"
```
**Put your Dropbox Access Token in the DBCONFIG!**

Then copy these commands in the cmd

```
git push heroku master
heroku ps:scale worker=1
done
```

And your done!

Go [here](https://dashboard.ngrok.com/status/) to check your server ip.

## Files sync

The Heroku filesystem is ephemeral, which means files written to the file system will be destroyed when the server is restarted.

Minecraft keeps all of the data for the server in flat files on the file system. Thus, if you want to keep you world, you'll need to sync it to Dropbox or AWS S3.

By defaule, dropbox sync will automatic backup your data every 5 minutes.

You can add Amazon S3 to sync your datas

First, create an AWS account and an S3 bucket. Then configure the bucket and your AWS keys like this:

```
$ heroku config:set AWS_BUCKET=your-bucket-name
$ heroku config:set AWS_ACCESS_KEY=xxx
$ heroku config:set AWS_SECRET_KEY=xxx
```

The buildpack will sync your world to the bucket every 60 seconds, but this is configurable by setting the AWS_SYNC_INTERVAL config var.

## Customizing Minecraft

You can choose the Minecraft version by setting the MINECRAFT_VERSION like so:

By default version is `1.8.8-R0.1-SNAPSHOT-latest`, files name are list at [GetBukkit](https://getbukkit.org/spigot) offical site.

```
heroku config:set MINECRAFT_VERSION="1.8.8-R0.1-SNAPSHOT-latest"
```

You can also configure the server properties by creating a server.properties file in your project and adding it to Git. This is how you would set things like Creative mode and Hardcore difficulty. The various options available are described on the Minecraft Wiki.

You can add files such as ``banned-players.json``, ``banned-ips.json``, ``ops.json``, ``whitelist.json`` to your Git repository and the Minecraft server will pick them up.

## Tips

You may create your own server on your computer with your own plugins, worlds then ZIP it to a file with the name **backup.zip**. Upload it to dropbox and you will have your own configured server.

# PaperMC on Heroku

## Run your papermc minecraft server on the cloud with Heroku.

This project is a fork from Tanashi Spigot on Heroku buildpack.
[PaperMC](https://papermc.io) is an active spigot fork focused on performance.

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
heroku buildpacks:add https://github.com/DavidNexuss/Spigot-on-heroku
heroku ps:exec
git commit -m "Heroku Exec" --allow-empty
done
```

Then, manually add these command with your Ngrok auth token, Dropbox app config file link (read below)

```
$ heroku config:set NGROK_API_TOKEN="xxxxx"
$ heroku config:set OAUTH_APP_KEY="xxxx"
$ heroku config:set OAUTH_APP_SECRET="xxxx"
```
Replace the fields, which will get your access code:
https://www.dropbox.com/oauth2/authorize?client_id=${OAUTH_APP_KEY}&token_access_type=offline&response_type=code
```
$ heroku config:set access_code="xxxx"
```

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

```
heroku config:set MINECRAFT_VERSION="Paper-1.16"
```
You can check all available versions of PaperMC [here](https://papermc.io/ci/)

Or you can specify custom build url by setting the PAPER env variable like so:

```
heroku config:set PAPER="https://papermc.io/ci/job/Paper-1.16/lastSuccessfulBuild/artifact/paperclip.jar" 
```

You can also configure the server properties by creating a server.properties file in your project and adding it to Git. This is how you would set things like Creative mode and Hardcore difficulty. The various options available are described on the Minecraft Wiki.

You can add files such as ``banned-players.json``, ``banned-ips.json``, ``ops.json``, ``whitelist.json`` to your Git repository and the Minecraft server will pick them up.

## Tips

You may create your own server on your computer with your own plugins, worlds then ZIP it to a file with the name **backup.zip**. Upload it to dropbox and you will have your own configured server.

## Credits

Original Spigot port by Tanashi  
Original buildpack by jkutner

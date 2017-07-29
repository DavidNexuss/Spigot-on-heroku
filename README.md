# Spigot on Heroku

## Run your spigot minecraft server on the cloud with Heroku.

This is a Heroku [buildpack](https://devcenter.heroku.com/articles/buildpacks), in order to install it you need to install the Heroku [toolbelt](https://toolbelt.heroku.com).

## Requirement

1. The Heroku toolbelt installed

2. A Free Heroku account. [Sign up here](https://signup.heroku.com)

3. An Ngrok account (for ip tunneling). [Sign up here](https://ngrok.com/signup)

4. A Dropbox account for files sync. [Sign up here](https://www.dropbox.com/login)

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
```

Then, manually add these command with your Ngrok auth token, Dropbox app config file link (read below)

```
$ heroku config:set NGROK_API_TOKEN="xxxxx"
$ heroku config:set DBCONFIG="xxxxx"
```

**NOTE** the download link should look like this if you use dropbox: https://www.dropbox.com/s/y7wg2bq1ko3xxxx/.dropbox_uploader?dl=0

Remove the ?dl=0 at the end for the link.

Then copy these commands in the cmd

```
git push heroku master
heroku ps:scale worker=1
```

And your done!

Go [here](https://dashboard.ngrok.com/status/) to check your server ip.

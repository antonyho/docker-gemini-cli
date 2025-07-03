## Build the iamge and push to Docker repository
(You don't have to do this if you feel safe to use my image on Docker Hub)

Building image and push to private Docker Hub account.
```
docker build -t antonyho/gemini-cli .
docker push antonyho/gemini-cli
```


## Sign in with Google Account
The first run for signing in with Gemini Code Assistant with free tier.

Map container network to the host. This works only when you don't have Docker user namespace enabled.
```
docker run -it \
    --name gemini-cli \
    --network host \
    -v $HOME/.gemini:/home/node/.gemini \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/gemini-cli gemini -d
```

In the TUI, choose the colour profile you prefer and proceed.
Then choose Auth Method, pick "Login with Google".

The auth URL with localhost callback will be printed to the stdout. Copy it. Especially notice the port.

Go to auth URL with browser on your host. Complete the Google account authentication.
The Gemini configurations along with authentication token will be stored in your home directory's `.gemini` by design.

Next time, to start a container. Use:
```
docker run -it \
    --name gemini-cli \
    -v $HOME/.gemini:/home/node/.gemini \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/gemini-cli
```



## Authenticate by Gemini API key
This is very useful when you can create an API key from Google Cloud. And when your Docker has user namespace enabled.

Create a plain text file named `.env`. I would store it inside `~/.gemini`, as it is a secret.
Put your API key into the file with environment variable name `GEMINI_API_KEY`.

For example:
```env
GEMINI_API_KEY=my_api_key_hex_text
```

If you are using API key authentication, I recommend yu to put the `.env` inside `~/.gemini` so that your API key won't be scanned by Gemini CLI during inferencing.

Start the container. *I have habit to remove the exited container*
```
docker run -it --rm \
    --name gemini-cli \
    -v $HOME/.gemini:/root/.gemini \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/gemini-cli
```


You should check the user of your Docker service. And also the permission for the Docker user to access your `~/.gemini` and your mounted volume to worvking directory.
Especially when you have user namespace enabled on your Docker configuration.
Using `--userns=host` to disable user namespace for this container, along with `-u $(id -u):$(id -g)` could possibly solve the permission problem.

```
docker run -it --rm \
    --name gemini-cli \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $HOME/.gemini:/home/node/.gemini \
    -v $(pwd):/workspace \
    -w /workspace \
    antonyho/gemini-cli
```

Gemini CLI would also take the `.gemini` in the workspace directory into account.
# Introduction

This repository contains experiment to build Containers suitable for the development of applications inside the container.

Goal:
- Offer all CLI commands of a standard Debian distribution suitable for development and hacking.
- Suitable as a dev container for VS Code via Remote SSH.
- Runnable as a non-root Pod in Kubernetes.

# Design

- The container will simply run an OpenSSH server upon startup, compatible with RSA, DSA, ECDSA, and ED25519.
- Upon startup the container reads the AUTHORIZED_KEYS environment variable to configure OpenSSH.
- The private keys of OpenSSH are generated upon Container startup so that each user of the Container have different keys and prevent MITM attacks.

# Node.js

Install
- `sudo docker build . -t debackerl/node-dev-env:14.17.0`
- `sudo docker run --rm -it debackerl/node-dev-env:14.17.0`
- `sudo docker push debackerl/node-dev-env:14.17.0`

- `kubectl apply -f k8s-manifests/namespace.yaml`
- `kubectl apply -f k8s-manifests/node-dev-pod.yaml`
- `kubectl -n laurent port-forward pod/node-dev-pod 2222:2222`
- `ssh-keygen -f "/home/laurent/.ssh/known_hosts" -R "[localhost]:2222"`
- `ssh -p 2222 developer@localhost`

Now, we could successfully open a Terminal to our remote container via SSH. Let's connect via VS Code now:

- Open VS Code
- Enter command: "Remote-SSH: Connect to Host..."
- "Add new SSH Host..."
- Enter "ssh -p 2222 developer@localhost -A"
- Now, enter again "Remote-SSH: Connect to Host..."
- Choose your new host: "localhost"

- In VS Code's Explorer, click "Open Folder"
- Open new terminal and type:
- `npm install -g express-generator`
- `express myExpressApp --view pug`
- `cd myExpressApp`
- `npm install`

- Enter command in VS Code: "Forward a Port", enter port '3000'
- Press F5, and choose Node.js environment

Demo: https://youtu.be/auHXPUvhVf4

Manual build of the container:
- `sudo docker build . -t XXX/node-dev-env:14.17.0`
- `sudo docker push XXX/node-dev-env:14.17.0`

# .NET Core

- `kubectl apply -f k8s-manifests/namespace.yaml`
- `kubectl apply -f k8s-manifests/dotnet-dev-pod.yaml`
- `kubectl -n laurent port-forward pod/dotnet-dev-pod 2222:2222`
- `ssh-keygen -f "/home/laurent/.ssh/known_hosts" -R "[localhost]:2222"`
- `ssh -p 2222 developer@localhost`

- Open VS Code
- Enter command: "Remote-SSH: Connect to Host..."
- "Add new SSH Host..."
- Enter "ssh -p 2222 developer@localhost -A"
- Now, enter again "Remote-SSH: Connect to Host..."
- Choose your new host: "localhost"

- Open new terminal and type:
- `dotnet new webapi -o SampleApi`
- `cd SampleApi`

- In VS Code's Explorer, click "Open Folder"
- In VS Code's extension manager, search for `ms-dotnettools.csharp`
- Choose "Install in SSH"
- Open the "Run and Debug" side panel, and click "Start Debugging"
- Opening your browser to https://localhost:5001/WeatherForecast

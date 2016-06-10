# WatchMaker

Kubernetes watcher, a little application to define and manage events in Kubernetes

## What is WatchMaker?

Have you ever thought that you would like to react to this or that event? Well, Kubernetes provides a very extensive API and good news here, the API provides a way to watch different objects like Pods, Nodes or Services.

Excellent, so, now what? well, now what we need it's an easy way to define things like:

* Watch these objects
* If this event happens, do this

## Setup

You will need a running kubernetes cluster, of course. Once you have your cluster and you can access using `kubectl` you have to create a ServiceAccount:

    kubectl create -f kube/serviceaccount.yaml

## Architecture

The architecture is pretty simple: a datasource where to keep your watches, an application that watches the kubernetes api and a frontend.

## Note

This project is not meant to be run in production, but as an example of the possibilities of using the kubernetes watch API.


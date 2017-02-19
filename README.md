# jlang-docker
[![Docker Pulls](https://img.shields.io/docker/pulls/nesachirou/jlang.svg)](https://hub.docker.com/r/nesachirou/jlang/)
Run Linux version of [J programming language](http://www.jsoftware.com/)

```sh
make build
make run
```

You can pass J file to ARGS.

```sh
make ARGS='sample.ijs' run
```

Pre-built image is available.

```sh
docker pull nesachirou/jlang
docker run -it -v $(pwd):/data nesachirou/jlang
docker run -it -v $(pwd):/data nesachirou/jlang sample.ijs
```

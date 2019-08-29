# Chatter.Umbrella

Simple chat service using Elixir, Phoenix and Phoenix Live View.


## Contributing

#### Requirements:
- **Elixir** (to install follow the official docs [here](https://elixir-lang.org/install.html)).
- **Postgres**

Download the project:
```
$ git clone https://github.com/barboza/chatter
$ cd chatter
```

Install dependencies and creates database:
```
$ mix deps.get
$ mix ecto.create
```

Start server on `localhost:4000`:
```
$ mix phx.server
```

To run tests use `mix test`

Always run `mix check` before pushing changes!

MIX_ENV=dev

export MIX_ENV

clean:
	mix deps.clean --all

compile:
	mix deps.get
	mix deps.compile
	mix compile

run-iex:
	iex -S mix phx.server

run:
	mix phx.server

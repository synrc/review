defmodule Sample.Index do
  require NITRO ; require KVS ; require N2O ; require Logger

  def room() do
      case :n2o.session(:room) do
           '' -> "msg"
           "" -> "msg"
           x -> x
      end
  end

  def event(:init) do
    room = Sample.Index.room
    :kvs.ensure(KVS.writer(id: room)) ; :n2o.reg({:topic, room})
    :nitro.update(:upload, NITRO.upload())
    :nitro.update(:heading, NITRO.h2(id: :heading, body: room))
    :nitro.update(:logout, NITRO.button(id: :logout, postback: :logout, body: "Logout"))
    :nitro.update(:send, NITRO.button(id: :send, body: "Chat", postback: :chat, source: [:message]))
    room |> :kvs.feed() |> Enum.each(fn {:msg, _, user, message} ->
      event({:client, {user, message}})
    end)
  end
  def event(:logout) do :n2o.user([]) ; :nitro.redirect("/app/login.html") end
  def event(:chat), do: chat(:nitro.q(:message))
  def event({:client, {user, message}}) do
    :nitro.wire(NITRO.jq(target: :message, method: [:focus, :select]))
    :nitro.insert_top(:history, NITRO.message(body: [NITRO.author(body: user), :nitro.jse(message)]))
  end
  def event(unexpected), do: unexpected |> inspect() |> Logger.warning()

  def chat(message) do
    room = Sample.Index.room ; user = :n2o.user()
    room |> :kvs.writer() |> KVS.writer(args: {:msg, :kvs.seq([], []), user, message})
    |> :kvs.add() |> :kvs.save()
    :n2o.send({:topic, room}, N2O.client(data: {user, message}))
  end

end

defmodule RumblWeb.TestHelpers do
  def insert_user(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(default_user())
      |> Rumbl.Accounts.register_user

    user
  end

  def insert_video(user, attrs \\ %{}) do
    video_fields = Enum.into(attrs, default_video())
    {:ok, video} = Rumbl.Multimedia.create_video(user, video_fields)
    video
  end

  def login(%{conn: conn, login_as: username}) do
    user = insert_user(username: username)
    {Plug.Conn.assign(conn, :current_user, user), user}
  end

  def login(%{conn: conn}), do: {conn, :logged_out}

  defp default_user() do
    %{
      name: "Some User",
      username: "user#{System.unique_integer([:positive])}",
      password: "supersecret"
    }
  end

  defp default_video() do
    %{
      url: "test@xample.com",
      description: "a video",
      body: "body"
    }
  end
end

defmodule WebmaniaNfe.ConfigTest do
  use ExUnit.Case
  doctest WebmaniaNfe.Config

  alias WebmaniaNfe.Config

  describe "config" do

    test "new/1 with valid data return a config" do
      assert {:ok, %Config{}} = Config.new(%{
               consumerKey: "consumerKey",
               consumerSecret: "consumerSecret",
               accessToken: "accessToken",
               accessTokenSecret: "accessTokenSecret",
             })
    end
  end

end

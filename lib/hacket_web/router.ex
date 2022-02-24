defmodule HacketWeb.Router do
  use HacketWeb, :router

  import HacketWeb.UserAuth
  alias HacketWeb.Hooks

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HacketWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  live_session :default, on_mount: Hooks.FetchUser do
    scope "/", HacketWeb do
      pipe_through :browser

      live "/", Page.Index
      live "/about", Page.About
      live "/blog", Page.Blog

      live "/post/:id", Post
      live "/user/:username", Profile
      live "/search", Search
      live "/search/:query", Search
    end
  end

  ## Authentication routes

  scope "/", HacketWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/register", UserRegistrationController, :new
    post "/register", UserRegistrationController, :create
    get "/login", UserSessionController, :new
    post "/login", UserSessionController, :create
    get "/reset_password", UserResetPasswordController, :new
    post "/reset_password", UserResetPasswordController, :create
    get "/reset_password/:token", UserResetPasswordController, :edit
    put "/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", HacketWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/account/settings", UserSettingsController, :edit
    put "/account/settings", UserSettingsController, :update
    get "/account/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", HacketWeb do
    pipe_through [:browser]

    delete "/logout", UserSessionController, :delete
    get "/account/confirm", UserConfirmationController, :new
    post "/account/confirm", UserConfirmationController, :create
    get "/account/confirm/:token", UserConfirmationController, :edit
    post "/account/confirm/:token", UserConfirmationController, :update
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end

defmodule PhoenixLiveviewAppWeb.BookLive do
  use PhoenixLiveviewAppWeb, :live_view
  alias PhoenixLiveviewApp.Books.Store

  def mount(_params, _session, socket) do
    if connected?(socket) do
      PhoenixLiveviewAppWeb.Endpoint.subscribe("books")  # Subscribe to books topic
    end

    {:ok,
     assign(socket,
       books: Store.list_books(),
       form_data: %{
         "title" => "",
         "author" => "",
         "year" => ""
       }
     )}
  end

  def handle_event("save", %{"book" => book_params}, socket) do
    {:ok, _book} = Store.add_book(book_params)
    broadcast_change()

    {:noreply,
     socket
     |> put_flash(:info, "Buku berhasil ditambahkan")
     |> assign(books: Store.list_books())
     |> assign(form_data: %{"title" => "", "author" => "", "year" => ""})}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    :ok = Store.delete_book(String.to_integer(id))
    broadcast_change()

    {:noreply,
     socket
     |> put_flash(:info, "Buku berhasil dihapus")
     |> assign(books: Store.list_books())}
  end

  # Handle incoming broadcasts
  def handle_info(%{topic: "books", event: "books_updated"}, socket) do
    {:noreply, assign(socket, books: Store.list_books())}
  end

  # Helper function to broadcast changes
  defp broadcast_change do
    PhoenixLiveviewAppWeb.Endpoint.broadcast("books", "books_updated", %{})
  end
end

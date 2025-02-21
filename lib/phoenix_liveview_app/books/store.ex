# lib/phoenix_liveview_app/books/store.ex
defmodule PhoenixLiveviewApp.Books.Store do
  use GenServer

  # Client API - fungsi-fungsi yang dipanggil dari luar
  def start_link(_) do
    # Memulai GenServer dengan nama module ini
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def list_books do
    # Mengambil semua buku
    GenServer.call(__MODULE__, :list_books)
  end

  def add_book(book) do
    # Menambah buku baru
    GenServer.call(__MODULE__, {:add_book, book})
  end

  def delete_book(id) do
    # Menghapus buku berdasarkan ID
    GenServer.call(__MODULE__, {:delete_book, id})
  end

  # Server Callbacks - fungsi-fungsi yang menangani request
  @impl true
  def init(_) do
    # State awal: list buku kosong dan ID mulai dari 1
    {:ok, %{books: [], next_id: 1}}
  end

  @impl true
  def handle_call(:list_books, _from, state) do
    # Mengembalikan list buku dari state
    {:reply, state.books, state}
  end

  @impl true
  def handle_call({:add_book, book}, _from, state) do
    # Membuat buku baru dengan ID yang auto-increment
    new_book = Map.put(book, :id, state.next_id)
    new_state = %{
      books: [new_book | state.books],
      next_id: state.next_id + 1
    }
    {:reply, {:ok, new_book}, new_state}
  end

  @impl true
  def handle_call({:delete_book, id}, _from, state) do
    # Menghapus buku dari list berdasarkan ID
    new_books = Enum.reject(state.books, &(&1.id == id))
    {:reply, :ok, %{state | books: new_books}}
  end
end

defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  defstruct [:balance, :status]

  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(BankAccount, 0)
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.call(account, :close_bank)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    GenServer.call(account, {:update, amount})
  end

  @impl true
  def init(initial_balance) do
    {:ok, %BankAccount{balance: initial_balance, status: :open}}
  end

  @impl true
  def handle_call(_event, _from, %{status: :closed} = account),
    do: {:reply, {:error, :account_closed}, account}

  def handle_call(:balance, _from, account), do: {:reply, account.balance, account}

  def handle_call({:update, amount}, _from, account),
    do: {:reply, account.balance + amount, %{account | balance: account.balance + amount}}

  def handle_call(:close_bank, _from, account), do: {:reply, :ok, %{account | status: :closed}}
end

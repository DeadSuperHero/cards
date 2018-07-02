  defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Returns a list of strings representing a deck of playing cards.

  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  @doc """
  Leverages the `Enum` module from Elixir, and calls the `shuffle`
  function to randomize the cards in the deck.

  ## Examples

      iex > deck = Cards.create_deck
      iex > deck = Cards.shuffle(deck)
      iex > deck
      
  """

  def shuffle(deck) do
    Enum.shuffle(deck)

  end

  @doc """
  Determines whether a deck is in a given card.

  ## Examples

      iex > deck = Cards.create_deck
      iex > Cards.contains?(deck, "Ace of Spades")
      true

  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size`
  argument indicates how many cards should be in the hand.

  ## Examples

      iex > deck = Cards.create_deck
      iex > {hand, deck} = Cards.deal(deck, 1)
      iex > hand
      ["Ace of Spades"]

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves a generated deck into a file using Erlang's `term_to_binary`,
  which then calls `File.write`

  ## Examples

      iex > Cards.create_hand(5)
      iex > Cards.save(deck, 'test_deck')

  """

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Uses `File.read` to open a file, then convert from a binary back
  into something that Elixir can read, using Erlang's `binary_to_term`
  function.

  ## Examples

      iex > Cards.load('test_deck')

  """

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Error: File does not exist."
    end
  end

  @doc """
  Takes an argument for `hand_size`, then calls Cards.create_deck.
  Using a pipe operator, the hand_size is passed over to `Cards.deal`

  ## Examples

      iex > hand = Cards.create_hand(6)

  """

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end

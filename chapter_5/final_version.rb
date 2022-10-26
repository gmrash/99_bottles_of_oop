class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).collect { |i| verse(i) }.join("\n")
  end

  def verse(number)
    bottle_number = BottleNumber.new(number)
    next_bottle_number = BottleNumber.new(bottle_number.successor)

    "#{bottle_number.quantity.capitalize} #{bottle_number.container} of beer on the wall, " +
      "#{bottle_number.quantity} #{bottle_number.container} of beer.\n" +
      "#{bottle_number.action}, " +
      "#{next_bottle_number.quantity} #{next_bottle_number.container} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def quantity
    Quantity.new.call(number)
  end

  def container
    Container.new.call(number)
  end

  def action
    Action.new.call(number)
  end

  def pronoun
    Pronoun.new.call(number)
  end

  def successor
    Successor.new.call(number)
  end
end

class Quantity
  def call(number)
    if number == 0
      "no more"
    else
      number.to_s
    end
  end
end

class Container
  def call(number)
    if number == 1
      "bottle"
    else
      "bottles"
    end
  end
end

class Pronoun
  def call(number)
    if number == 1
      "it"
    else
      "one"
    end
  end
end

class Successor
  def call(number)
    if number == 0
      99
    else
      number - 1
    end
  end
end

class Action
  def call(number)
    if number == 0
      "Go to the store and buy some more"
    else
      "Take #{Pronoun.new.call(number)} down and pass it around"
    end
  end
end

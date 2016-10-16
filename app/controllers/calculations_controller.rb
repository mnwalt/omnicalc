class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    text_space_drop = @text.gsub(" ", "")

    @character_count_without_spaces = text_space_drop.length

    @word_count = @text.split.size

    word_list = @text.downcase.split(" ")

    @occurrences = word_list.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    adj_rate = (@apr / 1200.0)
    periods = (@years * 12.0)
    @monthly_payment = (adj_rate * @principal * ((1 + adj_rate) **periods)) / (((1 + adj_rate) ** periods) - 1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.sort.first

    @maximum = @numbers.sort.last

    @range = @numbers.sort.last - @numbers.sort.first

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2

    @sum = @numbers.sum

    @mean = @sum / @count

    var_numerator = 0

    @numbers.each do |number|
    var_numerator = var_numerator + ((number - @mean)**2)
    end

    @variance = var_numerator / @count

    @standard_deviation = @variance**0.5

    bin = Hash.new(0)
    @numbers.each do |i|
      bin[i] += 1
    end

    mode_array = []

    bin.each do |k, v|
      if v == bin.values.max
        mode_array << k
      end
    end

    @mode = mode_array.sort.join(", ")

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ==========================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ==========================================================================

    # Character count with spaces
    # ===========================
    @character_count_with_spaces = @text.length


    # Character count without spaces
    # ==============================

    # Removing whitespace from string:
    text_without_spaces = @text.gsub(" ",  "")
    text_without_newlines = text_without_spaces.gsub("\n", "")
    text_without_carriage_returns = text_without_newlines.gsub("\r", "")
    text_without_tabs = text_without_carriage_returns.gsub("\t", "")

    # Alternatively, @text.gsub(/\s+/, "") would remove all whitespace at once.

    @character_count_without_spaces = text_without_tabs.length

    # Another alternative would be to count the occurrences of each whitespace
    #   character, then subtract that from the total length:
    # @text.length - @text.count(" ") - @text.count("\n") - etc

    # Word Count
    # ==========

    array_of_words = @text.split
    @word_count = array_of_words.count

    # Occurrences
    # ===========

    text_without_periods            = @text.gsub(".", "")
    text_without_commas             = text_without_periods.gsub(",", "")
    text_without_exclamation_points = text_without_commas.gsub("!", "")
    text_without_question_marks     = text_without_exclamation_points.gsub("?", "")
    text_without_colons             = text_without_exclamation_points.gsub(":", "")
    text_without_semicolons         = text_without_colons.gsub(";", "")
    text_without_forward_slashes    = text_without_semicolons.gsub("/", "")
    text_without_back_slashes       = text_without_forward_slashes.gsub("\\", "")

    # Alternatively, @text.gsub(/[^a-z0-9\s]/i, '') would remove anything
    #   except letters, digits, and whitespace all at once.

    downcased_text = text_without_back_slashes.downcase

    clean_word_array = downcased_text.split

    @occurrences = clean_word_array.count(@special_word.downcase)
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ==========================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ==========================================================================

    rate = @apr / 100 / 12
    nper = @years * 12

    @monthly_payment = (rate * @principal)/(1 - (1 + rate)**-nper)
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ==========================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ==========================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 1.minute # 1.minute is just shorthand for 1 * 60
    @hours = @seconds / 1.hour # 1.hour is just shorthand for 1 * 3600
    @days = @seconds / 1.day
    @weeks = @seconds / 1.week
    @years = @seconds / 1.year
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ==========================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ==========================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    # Median
    # ======
    if @count.odd?
      @median = @sorted_numbers[@count / 2]
    else
      left_of_middle = @sorted_numbers[(@count / 2) - 1]
      right_of_middle = @sorted_numbers[(@count / 2)]
      @median = (left_of_middle + right_of_middle) / 2
    end


    @sum = @numbers.sum

    @mean = @sum / @count

    # Variance
    # ========
    squared_differences = []

    @numbers.each do |num|
      difference = num - @mean
      squared_difference = difference ** 2
      squared_differences.push(squared_difference)
    end

    @variance = squared_differences.sum / @count


    @standard_deviation = Math.sqrt(@variance)

    # Mode
    # ====

    leader = nil
    leader_count = 0

    @numbers.each do |num|
      occurrences = @numbers.count(num)
      if occurrences > leader_count
        leader = num
        leader_count = occurrences
      end
    end

    @mode = leader
  end
end

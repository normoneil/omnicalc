class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # @character_count_with_spaces = @text.gsub(/\r\n?/, "  ").length
    # @character_count_with_spaces = @text.length

    #  @text_char_count_squish = @text_char_count.gsub(/\r\n?/, "").squish.length
    #  @character_count_without_spaces = @text.gsub(" ", "").squish.length
    # @character_count_without_spaces = @text.gsub(/\r\n?/, "").length

    text_without_spaces = @text.gsub(" ",  "")
    text_without_newlines = text_without_spaces.gsub("\n", "")
    text_without_carriage_returns = text_without_newlines.gsub("\r", "")
    text_without_tabs = text_without_carriage_returns.gsub("\t", "")

    @character_count_with_spaces = @text.length

    text_no_tabs = @text.gsub("\t", "")
    @character_count_without_spaces = text_no_tabs.gsub(" ", "").gsub(/\r\n?/, "").squish.length

    # @word_count = @text.split.size
    @word_count = @text.scan(/(\w|-)+/).size

    if @special_word != ''
      # @occur_count = @text.scan(@special_word).size
      mod_text = @text.downcase
      mod_special_word = @special_word.downcase
      @occurrences = mod_text.scan(mod_special_word).size
    else
      @occurrences = "[ERROR: No special word was input]"
    end

    render("word_count.html.erb")
  end

  # ================================================================================
  # Your code goes above.
  # ================================================================================

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

    # P = L[c(1 + c)^n]/[(1 + c)n - 1]
    #  @months = @years * 12
    #  @rate = @apr / 12000
    #  @monthly_payment = @principal * (@rate * (1 + @rate)**@months)/((1 + @rate)**@months - 1)

     @rate = (@apr / 1200)
     @months = (@years * 12)
     @monthly_payment = ((@rate * @principal) * ((1 + @rate)**@months))/(((1 + @rate)**@months) - 1)

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

    # elapsed_seconds = ((end_time - start_time) * 24 * 60 * 60).to_i

    @seconds = (@ending - @starting)
    @minutes = (@ending - @starting) / 60
    @hours = (@ending - @starting) / 60 / 60
    @days = (@ending - @starting) / 60 / 60 / 24
    @weeks = (@ending - @starting) / 60 / 60 / 24 / 7
    @years = (@ending - @starting) / 60 / 60 / 24 / 7 / 52

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

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    def median(list_of_numbers)
      array_sorted = list_of_numbers.sort
      array_length = array_sorted.length
      (array_sorted[(array_length - 1) / 2] + array_sorted[array_length / 2]) / 2.0
    end
    @median = median(@numbers)

    # @sum = @numbers.sum
    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total
    end

    @sum = sum(@numbers)

    # average = @numbers.sum / @numbers.count
    # @mean = @numbers.sum / @numbers.count

    def mean(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total / list_of_numbers.count
    end
    @mean = mean(@numbers)

    def variance(list_of_numbers)
      sq_diff = 0
      running_total = 0
      list_of_numbers.each do |number|
        sq_diff = (number - (list_of_numbers.sum / list_of_numbers.count))**2
        running_total = running_total + sq_diff
      end
      return running_total / list_of_numbers.count
    end
    @variance = variance(@numbers)

    def stdev(list_of_numbers)
      var = variance(list_of_numbers)
      return Math.sqrt(var)
    end
    @standard_deviation = stdev(@numbers)

    def mode(list_of_numbers)
      sorted_numbers = list_of_numbers.sort
      most_common_count = 0
      sorted_numbers.each do |number|
        if sorted_numbers.count(number) > most_common_count
          most_common_count = sorted_numbers.count(number)
          @most_common = number
        end
      end
    return @most_common
    end
    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

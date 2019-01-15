def prompt(msg)
  puts ">> #{msg}"
end

def valid_rate?(rate)
  rate == rate.to_i.to_s || rate == rate.to_f.to_s
end

def valid_amount?(amt)
  amt == amt.to_i.to_s || amt == amt.to_f.to_s
end

def valid_duration?(months)
  months == months.to_i.to_s
end

loop do
  loan_amount = ''
  apr = ''
  loan_duration_months = ''

  loop do
    prompt("Please enter loan amount:")
    print "$"
    loan_amount = gets.chomp

    if valid_amount?(loan_amount)
      break
    else
      prompt("Hmm.. that doesn't seem like a valid loan amount.")
    end
  end

  loop do
    prompt("Please enter the loan APR in percentage:")
    apr = gets.chomp

    if valid_rate?(apr)
      break
    else
      prompt("Hmm.. that doesn't seem like a valid rate.")
    end
  end

  loop do
    prompt("Please enter the loan duration in months:")
    loan_duration_months = gets.chomp

    if valid_duration?(loan_duration_months)
      break
    else
      prompt("Hmm.. that doesn't seem like a valid duration.")
    end
  end

  monthly_interest_rate = apr.to_f / 12
  monthly_payment = loan_amount.to_f *
                    (monthly_interest_rate / 100) /
                    (1 - (1 + (monthly_interest_rate / 100))**
                    -loan_duration_months.to_i)
  prompt("Your monthly payment is $#{monthly_payment.round(2)}
   at a monthly interest rate of #{(monthly_interest_rate * 100).round(2)}%")
  puts("---------------------")

  prompt("Would you like to calculate another mortgage/car payment? (Y/N)")
  choice = gets.chomp
  break if choice.downcase.start_with?('n')
end
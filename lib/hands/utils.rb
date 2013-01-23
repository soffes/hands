module Hands
  # Math utilities
  module Utils
    module_function

    # Solve binomial coefficients
    def ncr(n, r)
      return 1 if n == r or n == 0
      return n if r == 1
      ncr(n - 1, r) + ncr(n - 1, r - 1)
    end

    # Factorial
    def fact(n)
      (1..n).reduce(:*)
    end

    # Double factorial
    def dfact(n)
      (1..n).step(2).reduce(:*)
    end
  end
end

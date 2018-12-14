# frozen_string_literal: true

require_relative 'pattern/checkers'
require_relative 'pattern/gradient'
require_relative 'pattern/ring'
require_relative 'pattern/stripe'

module GlisteningRuby
  CheckersPattern = Pattern::Checkers
  GradientPattern = Pattern::Gradient
  RingPattern = Pattern::Ring
  StripePattern = Pattern::Stripe
end

require 'questrade_api/rest/market'
require 'questrade_api/rest/symbol'
require 'questrade_api/rest/quote'
require 'questrade_api/rest/candle'
require 'questrade_api/rest/option'
require 'questrade_api/rest/option_quote'
require 'questrade_api/rest/strategy_quote'

module QuestradeApi
  module MarketCall
    def markets
      QuestradeApi::REST::Market.fetch(authorization)
    end

    def symbols(params)
      QuestradeApi::REST::Symbol.fetch(authorization, params)
    end

    def symbol(id)
      symbol = QuestradeApi::REST::Symbol.new(authorization, id: id)
      symbol.fetch

      symbol
    end

    def search_symbols(params)
      QuestradeApi::REST::Symbol.search(authorization, params)
    end

    def quotes(ids)
      QuestradeApi::REST::Quote.fetch(authorization, ids)
    end

    def quote(id)
      quote =
        QuestradeApi::REST::Quote.new(authorization: authorization, id: id)

      quote.fetch

      quote
    end

    def quote_options(filters, option_ids)
      QuestradeApi::REST::OptionQuote.fetch(authorization,
                                            filters: filters,
                                            optionIds: option_ids)
    end

    def quote_strategies(variants)
      QuestradeApi::REST::StrategyQuote.fetch(authorization,
                                              variants: variants)
    end

    def candles(symbol_id, params)
      result = QuestradeApi::REST::Candle.fetch(authorization, symbol_id, params)
      @ratelimit_remaining = result.response.headers['x-ratelimit-remaining'].to_i
      @ratelimit_reset = result.response.headers['x-ratelimit-reset'].to_i
      result
    end

    def symbol_options(symbol_id)
      QuestradeApi::REST::Option.fetch(authorization, symbol_id)
    end
  end
end

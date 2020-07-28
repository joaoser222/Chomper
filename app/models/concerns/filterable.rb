module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      query = ''
      values = []
      i = 0
      unless filtering_params.nil?
        filtering_params.each do |key, value|
          i += 1
          numeric = (true if Float(value) rescue false)
          values.push(numeric ? value : "%#{value}%")
          query += "#{key} #{numeric ? '=' : 'like'} ? #{'and' if Hash(filtering_params).size>i} "
        end
      end
      self.public_send('where',query.empty? ? nil : values.unshift(query))
    end
  end
end
# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include HandleImages
  self.abstract_class = true
end

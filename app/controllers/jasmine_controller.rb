# frozen_string_literal: true

class JasmineController < ApplicationController
  skip_before_action :require_login
  layout false

  def index; end
end

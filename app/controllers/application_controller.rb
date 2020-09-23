class ApplicationController < ActionController::Base
  def health_check
    render plain: '', status: :ok
  end
end

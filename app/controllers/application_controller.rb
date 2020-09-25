class ApplicationController < ActionController::Base
  def index
    render template: 'home/index', status: :ok
  end

  def health_check
    render plain: '', status: :ok
  end
end

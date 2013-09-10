
# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  MHM-Systemhaus GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to projects_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| authorize_params u}
    devise_parameter_sanitizer.for(:account_update) { |u| authorize_params u }
  end

  def authorize_params(u)
    u.permit(:email, :name, :password, :password_confirmation, :current_password)
  end

  #rescue_from NoMethodError do |exception|
  #  flash[:error] = "That route doesn't exist!"
  #  redirect_to root_url
  #end
end

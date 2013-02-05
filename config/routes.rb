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

Cotopaxi::Application.routes.draw do
  devise_for :users

  resources :users

  resources :projects do
    resources :features
    resources :sprints
  end

  post 'projects/:id/sort_features' => 'projects#sort_features'
  post 'projects/:id/assign_roles' => 'projects#assign_roles'
  put  'projects/:id/assign_roles' => 'projects#assign_roles'
  get 'projects/:id/plan_sprint' => 'projects#plan_sprint'
  post 'projects/:id/confirm_sprint' => 'projects#confirm_sprint'
  get 'projects/:id/past_sprints' => 'sprints#past_sprints'

  root to: "users#show"

end

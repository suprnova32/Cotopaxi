# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  Patricio Cano
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

require "spec_helper"

describe SprintsController do
  describe "routing" do

    it "routes to #index" do
      get("/projects/1/sprints").should route_to("sprints#index", project_id: "1")
    end

    it "routes to #show" do
      get("/projects/1/sprints/1").should route_to("sprints#show", :id => "1", project_id: "1")
    end

  end
end

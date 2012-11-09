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

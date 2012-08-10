module GrapeDoc
  class Projects < Grape::API
    resource :projects do
      get do

      end

      desc "Create Project"
      post do

      end

      desc "Update Project", {
        :params => {
          :project_id => { 
            :description => "Project ID",
            :required => true
          }
        }
      }
      put do

      end

      desc "Delete Project", {
        :params => {
          :project_id => { 
            :description => "Project ID",
            :required => true
          }
        }, 
        :response => {
          :status => true
        }
      }
      delete do

      end

    end
  end
end

